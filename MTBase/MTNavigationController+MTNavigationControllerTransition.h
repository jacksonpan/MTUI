#import <UIKit/UIKit.h>

@interface UINavigationController (MTNavigationControllerTransition)
- (void)pushViewControllerWithNavigationControllerTransition:(UIViewController *)viewController;
- (void)popViewControllerWithNavigationControllerTransition;
@end
