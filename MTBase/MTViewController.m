//
//  MTViewController.m
//  MicroTransfer
//
//  Created by jacksonpan on 13-3-12.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "MTViewController.h"
#import "MTRotateHelper.h"

@interface MTViewController ()

@end

@implementation MTViewController
@synthesize saveViewController;
@synthesize rootViewController;
@synthesize lastViewController;
@synthesize nextViewController;

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self unregisterForKeyboardNotifications];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)gotoNextView
{
    if(nextViewController)
    {
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
}

- (void)gotoNextView:(BOOL)_animated
{
    if(nextViewController)
    {
        [self.navigationController pushViewController:nextViewController animated:_animated];
    }
}

- (UIViewController*)backtoPrevView
{
    return [self.navigationController popViewControllerAnimated:YES];
}

- (UIViewController*)backtoPrevView:(BOOL)_animated
{
    return [self.navigationController popViewControllerAnimated:_animated];
}

- (NSArray*)jumptoView:(UIViewController*)view
{
    return [self.navigationController popToViewController:view animated:YES];
}

- (NSArray*)jumptoView:(UIViewController*)view animated:(BOOL)_animated
{
    return [self.navigationController popToViewController:view animated:_animated];
}

- (NSArray*)jumptoRoot
{
    return [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSArray*)jumptoRoot:(BOOL)_animated
{
    return [self.navigationController popToRootViewControllerAnimated:_animated];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    
}

- (void)keyboardWasHidden:(NSNotification *)notification
{
    
}

- (CGSize)keyboardSize:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    NSValue *beginValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    NSLog(@"info:%@", info);
    //NSValue *endValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize;
    keyboardSize = [beginValue CGRectValue].size;
    
    return keyboardSize;
}

- (BOOL)shouldAutorotate
{
    return [[MTRotateHelper current] isSupportAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
