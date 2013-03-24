//
//  MTViewController.h
//  MicroTransfer
//
//  Created by jacksonpan on 13-3-12.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTNibLoad.h"

@interface MTViewController : UIViewController
@property (assign, nonatomic) id saveViewController;//usually save view which you want
@property (assign, nonatomic) id rootViewController;
@property (assign, nonatomic) id lastViewController;
@property (assign, nonatomic) id nextViewController;

- (UIViewController*)backtoPrevView;
- (UIViewController*)backtoPrevView:(BOOL)_animated;
- (void)gotoNextView;
- (void)gotoNextView:(BOOL)_animated;
- (NSArray*)jumptoView:(UIViewController*)view;
- (NSArray*)jumptoView:(UIViewController*)view animated:(BOOL)_animated;
- (NSArray*)jumptoRoot;
- (NSArray*)jumptoRoot:(BOOL)_animated;

- (CGSize)keyboardSize:(NSNotification *)aNotification;
@end
