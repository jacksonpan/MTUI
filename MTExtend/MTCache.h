//
//  MTCache.h
//  MicroTransfer
//
//  Created by jacksonpan on 13-3-23.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCache : NSObject
+ (MTCache *)shareCache;

- (UIImage*)cachedImageForRequest:(NSURLRequest*)request;
- (void)cacheImage:(UIImage *)image forRequest:(NSURLRequest *)request;

- (NSString*)keyWithURL:(NSString*)url;
- (NSString *)pathWithKey:(NSString*)key;

- (UIImage*)diskImageForKey:(NSString*)key;
- (void)diskImage:(UIImage*)image forKey:(NSString*)key;

- (UIImage*)cacheImageForKey:(NSString*)key;
- (void)cacheImage:(UIImage*)image forKey:(NSString*)key;

- (UIImage*)imageWithKey:(NSString*)key;
- (void)image:(UIImage*)image forKey:(NSString*)key;

- (void)clearDisk;
- (void)clearMemory;
- (void)clearAll;
@end
