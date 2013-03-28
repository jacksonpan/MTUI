//
//  UIImageView+MTExtend_AFNetworking.m
//  MicroTransfer
//
//  Created by jacksonpan on 13-3-23.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "UIImageView+MTExtend_AFNetworking.h"
#import "AFImageRequestOperation.h"
#import "MTCache.h"
#import <objc/runtime.h>
#import "UIImage+FX.h"

static char kAFImageRequestOperationObjectKey;

@interface UIImageView (_MTExtend_AFNetworking)
@property (readwrite, nonatomic, strong, setter = af_setImageRequestOperation:) AFImageRequestOperation *af_imageRequestOperation;
@end

@implementation UIImageView (_MTExtend_AFNetworking)
@dynamic af_imageRequestOperation;
@end

@implementation UIImageView (MTExtend_AFNetworking)

+ (NSOperationQueue *)af_sharedImageRequestOperationQueue
{
    static NSOperationQueue *_af_imageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _af_imageRequestOperationQueue = [[NSOperationQueue alloc] init];
        [_af_imageRequestOperationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    });
    
    return _af_imageRequestOperationQueue;
}

- (AFHTTPRequestOperation *)af_imageRequestOperation
{
    return (AFHTTPRequestOperation *)objc_getAssociatedObject(self, &kAFImageRequestOperationObjectKey);
}

- (void)af_setImageRequestOperation:(AFImageRequestOperation *)imageRequestOperation
{
    objc_setAssociatedObject(self, &kAFImageRequestOperationObjectKey, imageRequestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (void)setImageWithURL:(NSURL *)url imageSize:(enum_image_size)imageSize
{
    [self setImageWithURL:url placeholderImage:nil imageSize:imageSize];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage
              imageSize:(enum_image_size)imageSize
{
    [self setImageWithURL:url placeholderImage:placeholderImage imageSize:imageSize result:nil];
}

- (void)cancelImageRequestOperation
{
    [self.af_imageRequestOperation cancel];
    self.af_imageRequestOperation = nil;
}

- (void)setImageWithURL:(NSURL*)url
         placeholderImage:(UIImage *)placeholderImage
                imageSize:(enum_image_size)imageSize
                   result:(void (^)(UIImage *image, NSError *error, BOOL isCache))result
{
    [self cancelImageRequestOperation];
    MTCache* cache = [MTCache shareCache];
    NSString* key = nil;
    NSString* urlString = [url absoluteString];
    switch (imageSize) {
        case enum_image_size_original:
        {
            key = [cache keyWithURL:urlString];
        }
            break;
        case enum_image_size_resize:
        {
            key = [cache keyWithURL:[urlString stringByAppendingPathComponent:@"resize"]];
        }
            break;
        case enum_image_size_thumb:
        {
            key = [cache keyWithURL:[urlString stringByAppendingPathComponent:@"thumb"]];
        }
            break;
        default:
            break;
    }
    UIImage *cachedImage = [[MTCache shareCache] imageWithKey:key];
    if (cachedImage)
    {
        if(result)
        {
            result(cachedImage, nil, YES);
        }
        else
        {
            self.image = cachedImage;
        }
        self.af_imageRequestOperation = nil;
    }
    else
    {
        self.image = placeholderImage;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:request];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            if ([request isEqual:[self.af_imageRequestOperation request]])
            {
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    NSString* key_original = [cache keyWithURL:urlString];
                    NSString* key_resize = [cache keyWithURL:[urlString stringByAppendingPathComponent:@"resize"]];
                    NSString* key_thumb = [cache keyWithURL:[urlString stringByAppendingPathComponent:@"thumb"]];
                    
                    UIImage* image = responseObject;
                    if(imageSize == enum_image_size_original)
                    {
                        if(result)
                        {
                            result(image, nil, NO);
                        }
                        else
                        {
                            self.image = image;
                        }
                    }
                    [[MTCache shareCache] image:image forKey:key_original];
                    
                    image = [self resizeWithImage:image];
                    if(imageSize == enum_image_size_resize)
                    {
                        if(result)
                        {
                            result(image, nil, NO);
                        }
                        else
                        {
                            self.image = image;
                        }
                    }
                    [[MTCache shareCache] image:image forKey:key_resize];
                    
                    image = [self thunmbWithimage:image];
                    if(imageSize == enum_image_size_thumb)
                    {
                        if(result)
                        {
                            result(image, nil, NO);
                        }
                        else
                        {
                            self.image = image;
                        }
                    }
                    [[MTCache shareCache] image:image forKey:key_thumb];
                    [[MTCache shareCache] cacheImage:image forKey:key_thumb];
                });

                if (self.af_imageRequestOperation == operation)
                {
                    self.af_imageRequestOperation = nil;
                }
            }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            if ([request isEqual:[self.af_imageRequestOperation request]])
            {
                if (result)
                {
                    result(nil, error, NO);
                }
                
                if (self.af_imageRequestOperation == operation)
                {
                    self.af_imageRequestOperation = nil;
                }
            }
        }];
        
        self.af_imageRequestOperation = requestOperation;
        
        [[[self class] af_sharedImageRequestOperationQueue] addOperation:self.af_imageRequestOperation];
    }
}

- (UIImage*)resizeWithImage:(UIImage*)image
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGSize d = CGSizeMake(bounds.size.width, bounds.size.height);
    if(image.size.width <= d.width && image.size.height <= d.height)
    {
        return image;
    }
    UIImage* ret = [image imageScaledToFitSize:d];
    NSLog(@"resizeWithImage, w:%f, h:%f", ret.size.width, ret.size.height);
    return ret;
}

- (UIImage*)thunmbWithimage:(UIImage*)image
{
    UIImage* ret = [image imageCroppedAndScaledToSize:self.frame.size contentMode:UIViewContentModeScaleAspectFill padToFit:YES];
    NSLog(@"croppedAndScaledToSize, w:%f, h:%f", ret.size.width, ret.size.height);
    return ret;
}

@end
