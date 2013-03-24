//
//  MTToolbar.m
//  MicroTransfer
//
//  Created by jacksonpan on 13-3-13.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "MTToolbar.h"
#import <QuartzCore/QuartzCore.h>

static NSString *imageName = @"MTToolBar.png";

@interface MTToolbar ()
{
    UIImage* _image;
}
@end

@implementation MTToolbar
+ (void)setImage:(NSString*)name
{
    imageName = name;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _image = [UIImage imageNamed:imageName];
    
    [[self layer] setMasksToBounds:NO];
    [[self layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self layer] setShadowOffset:CGSizeMake(0, -3)];
    [[self layer] setShadowOpacity:0.3];
    [[self layer] setShadowRadius:1.0];
    [[self layer] setShadowPath:[UIBezierPath bezierPathWithRect:self.bounds].CGPath];
}

- (void)drawRect:(CGRect)rect
{
    [_image drawInRect:rect];
}

@end
