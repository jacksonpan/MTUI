//
//  MTTableView+Transform.m
//  MicroTransfer
//
//  Created by jacksonpan on 13-1-28.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "MTTableView+Transform.h"
#import <QuartzCore/QuartzCore.h>

NSTimeInterval MTDefaultDuration = 0.2;

CGFloat CGFloatSign(CGFloat value) {
    if (value < 0) {
        return -1.0f;
    }
    return 1.0f;
}

MTTableViewCellTransform MTTableViewCellTransformCurl = ^(CALayer * layer, float speed){
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500;
    transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    transform = CATransform3DRotate(transform, M_PI/2, 0.0f, 1.0f, 0.0f);
    layer.transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    return MTDefaultDuration;
};

MTTableViewCellTransform MTTableViewCellTransformFade = ^(CALayer * layer, float speed){
    if (speed != 0.0f) { // Don't animate the initial state
        layer.opacity = 1.0f - fabs(speed);
    }
    return 2 * MTDefaultDuration;
};

MTTableViewCellTransform MTTableViewCellTransformFan = ^(CALayer * layer, float speed){
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    transform = CATransform3DRotate(transform, -M_PI/2 * speed, 0.0f, 0.0f, 1.0f);
    layer.transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    layer.opacity = 1.0f - fabs(speed);
    return MTDefaultDuration;
};

MTTableViewCellTransform MTTableViewCellTransformFlip = ^(CALayer * layer, float speed){
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0.0f, CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    transform = CATransform3DRotate(transform, CGFloatSign(speed) * M_PI/2, 1.0f, 0.0f, 0.0f);
    layer.transform = CATransform3DTranslate(transform, 0.0f, -CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    layer.opacity = 1.0f - fabs(speed);
    return 2 * MTDefaultDuration;
};

MTTableViewCellTransform MTTableViewCellTransformHelix = ^(CALayer * layer, float speed){
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0.0f, CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    transform = CATransform3DRotate(transform, M_PI, 0.0f, 1.0f, 0.0f);
    layer.transform = CATransform3DTranslate(transform, 0.0f, -CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    layer.opacity = 1.0f - 0.2*fabs(speed);
    return 2 * MTDefaultDuration;
};

MTTableViewCellTransform MTTableViewCellTransformTilt = ^(CALayer * layer, float speed){
    if (speed != 0.0f) { // Don't animate the initial state
        layer.transform = CATransform3DMakeScale(0.8f, 0.8f, 0.8f);
        layer.opacity = 1.0f - fabs(speed);
    }
    return 2 * MTDefaultDuration;
};

MTTableViewCellTransform MTTableViewCellTransformWave = ^(CALayer * layer, float speed){
    if (speed != 0.0f) { // Don't animate the initial state
        layer.transform = CATransform3DMakeTranslation(-layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    }
    return MTDefaultDuration;
};

