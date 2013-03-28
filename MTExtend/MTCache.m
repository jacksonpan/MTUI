//
//  MTCache.m
//  MicroTransfer
//
//  Created by jacksonpan on 13-3-23.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "MTCache.h"
#import <CommonCrypto/CommonDigest.h>
#include <fcntl.h>
#include <unistd.h>

#define MTCacheDownloadFolderName                   @"MTCache"

@interface MTCache ()
{
    NSCache* myCache;
}
@end

@implementation MTCache
+ (MTCache *)shareCache
{
    static MTCache *cache = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        cache = [[MTCache alloc] init];
    });
    return cache;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [self _init];
    }
    return self;
}

- (void)_init
{
    if(myCache == nil)
    {
        myCache = [[NSCache alloc] init];
    }
}

- (NSString*)cacheKeyFromURLRequest:(NSURLRequest*)request
{
    return [[request URL] absoluteString];
}

- (UIImage*)cachedImageForRequest:(NSURLRequest*)request
{
    switch ([request cachePolicy]) {
        case NSURLRequestReloadIgnoringCacheData:
        case NSURLRequestReloadIgnoringLocalAndRemoteCacheData:
            return nil;
        default:
            break;
    }
    
	return [myCache objectForKey:[self cacheKeyFromURLRequest:request]];
}

- (void)cacheImage:(UIImage *)image forRequest:(NSURLRequest *)request
{
    if (image && request)
    {
        [myCache setObject:image forKey:[self cacheKeyFromURLRequest:request]];
    }
}

- (NSString*)keyWithURL:(NSString*)url
{
    return [[self class] md5StringForString:url];
}

- (NSString *)pathWithKey:(NSString*)key
{
    NSString* tempPath = nil;
    if (key) {
        tempPath = [[[self class] cacheFolder] stringByAppendingPathComponent:key];
    }
    return tempPath;
}

- (UIImage*)diskImageForKey:(NSString*)key
{
    // Second check the disk cache...
    UIImage *diskImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:[self pathWithKey:key]]];
    
    return diskImage;
}

- (void)diskImage:(UIImage*)image forKey:(NSString*)key
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
       NSData *data = nil;
       if(image)
       {
           data = UIImageJPEGRepresentation(image, (CGFloat)1.0);
       }
       if (data)
       {
           // Can't use defaultManager another thread
           NSFileManager *fileManager = NSFileManager.new;
           [fileManager createFileAtPath:[self pathWithKey:key] contents:data attributes:nil];
       }    
    });
}

- (UIImage*)cacheImageForKey:(NSString*)key
{
	return [myCache objectForKey:key];
}

- (void)cacheImage:(UIImage*)image forKey:(NSString*)key
{
    [myCache setObject:image forKey:key];
}

- (UIImage*)imageWithKey:(NSString*)key
{
    UIImage* image = [self cacheImageForKey:key];
    if(image == nil)
    {
        image = [self diskImageForKey:key];
    }
    return image;
}

- (void)image:(UIImage*)image forKey:(NSString*)key
{
    [self diskImage:image forKey:key];
}

+ (NSString *)cacheFolder
{
    static NSString *cacheFolder;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        cacheFolder = [cacheDir stringByAppendingPathComponent:MTCacheDownloadFolderName];
        
        // ensure all cache directories are there (needed only once)
        NSError *error = nil;
        if(![[NSFileManager new] createDirectoryAtPath:cacheFolder withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Failed to create cache directory at %@", cacheFolder);
        }
    });
    return cacheFolder;
}

// calculates the MD5 hash of a key
+ (NSString *)md5StringForString:(NSString *)string
{
    const char *str = [string UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
}

+ (UIImage *)decodedImageWithImage:(UIImage *)image
{
    CGImageRef imageRef = image.CGImage;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    CGRect imageRect = (CGRect){.origin = CGPointZero, .size = imageSize};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    int infoMask = (bitmapInfo & kCGBitmapAlphaInfoMask);
    BOOL anyNonAlpha = (infoMask == kCGImageAlphaNone ||
                        infoMask == kCGImageAlphaNoneSkipFirst ||
                        infoMask == kCGImageAlphaNoneSkipLast);
    
    // CGBitmapContextCreate doesn't support kCGImageAlphaNone with RGB.
    // https://developer.apple.com/library/mac/#qa/qa1037/_index.html
    if (infoMask == kCGImageAlphaNone && CGColorSpaceGetNumberOfComponents(colorSpace) > 1)
    {
        // Unset the old alpha info.
        bitmapInfo &= ~kCGBitmapAlphaInfoMask;
        
        // Set noneSkipFirst.
        bitmapInfo |= kCGImageAlphaNoneSkipFirst;
    }
    // Some PNGs tell us they have alpha but only 3 components. Odd.
    else if (!anyNonAlpha && CGColorSpaceGetNumberOfComponents(colorSpace) == 3)
    {
        // Unset the old alpha info.
        bitmapInfo &= ~kCGBitmapAlphaInfoMask;
        bitmapInfo |= kCGImageAlphaPremultipliedFirst;
    }
    
    // It calculates the bytes-per-row based on the bitsPerComponent and width arguments.
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 imageSize.width,
                                                 imageSize.height,
                                                 CGImageGetBitsPerComponent(imageRef),
                                                 0,
                                                 colorSpace,
                                                 bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    
    // If failed, return undecompressed image
    if (!context) return image;
	
    CGContextDrawImage(context, imageRect, imageRef);
    CGImageRef decompressedImageRef = CGBitmapContextCreateImage(context);
	
    CGContextRelease(context);
	
    UIImage *decompressedImage = [UIImage imageWithCGImage:decompressedImageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(decompressedImageRef);
    return decompressedImage;
}
@end
