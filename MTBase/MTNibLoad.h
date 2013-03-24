//
//  MTNibLoad.h
//  MicroTransfer
//
//  Created by jacksonpan on 13-3-12.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTNibLoad : NSObject
+ (id)loadWithName:(NSString*)name index:(NSInteger)index;
+ (id)loadOneWithName:(NSString *)name;
@end

@interface UIViewController (MTNibLoad)
+ (id)loadNib;
@end

@interface UIView (MTNibLoad)
+ (id)loadNib;
@end