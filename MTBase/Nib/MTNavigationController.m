//
//  MTNavigationController.m
//  MicroTransfer
//
//  Created by jacksonpan on 13-3-12.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "MTNavigationController.h"
#import "MTRotateHelper.h"

@interface MTNavigationController ()
{
    
}
@end

@implementation MTNavigationController

+ (id)navigation
{
    MTNavigationController* nav = [MTNavigationController loadNib];
    return nav;
}

+ (id)navigationGeneral
{
    UINavigationController* nav = [[UINavigationController alloc] init];
    return nav;
}

- (BOOL)shouldAutorotate
{
    return [[MTRotateHelper current] isSupportAutorotate];
}

/*
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */
@end
