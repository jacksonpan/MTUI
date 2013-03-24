//
//  MTNibLoad.m
//  MicroTransfer
//
//  Created by jacksonpan on 13-3-12.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "MTNibLoad.h"

@implementation MTNibLoad
+ (id)loadWithName:(NSString*)name index:(NSInteger)index
{
    return [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] objectAtIndex:index];
}

+ (id)loadOneWithName:(NSString *)name
{
    return [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] objectAtIndex:0];
}
@end

@implementation UIViewController (MTNibLoad)
+ (id)loadNib
{
    NSString* selfName = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"%@",selfName);
    id object = [MTNibLoad loadOneWithName:selfName];
    return object;
}
@end

@implementation UIView (MTNibLoad)
+ (id)loadNib
{
    NSString* selfName = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"%@",selfName);
    id object = [MTNibLoad loadOneWithName:selfName];
    return object;
}
@end