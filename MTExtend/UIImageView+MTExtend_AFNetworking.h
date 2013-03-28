//
//  UIImageView+MTExtend_AFNetworking.h
//  MicroTransfer
//
//  Created by jacksonpan on 13-3-23.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _enum_image_size
{
    enum_image_size_original,
    enum_image_size_resize,
    enum_image_size_thumb
}enum_image_size;

@interface UIImageView (MTExtend_AFNetworking)
+ (void)cancelAll;

- (void)setImageWithURL:(NSURL *)url imageSize:(enum_image_size)imageSize;

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage
              imageSize:(enum_image_size)imageSize;

- (void)setImageWithURL:(NSURL*)url
       placeholderImage:(UIImage *)placeholderImage
              imageSize:(enum_image_size)imageSize
                 result:(void (^)(UIImage *image, NSError *error, BOOL isCache))result;

- (void)cancelImageRequestOperation;
@end
