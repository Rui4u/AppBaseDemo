//
//  CustomNavigationController.m
//  HZAgentiOSClient
//
//  Created by sharui on 2016/12/28.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
	
	[super viewDidLoad];
    __weak CustomNavigationController *weakSelf = self;
    
       if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
           {
                 self.interactivePopGestureRecognizer.delegate = weakSelf;
                 self.delegate = weakSelf;
               }
   
}

 // Hijack the push method to disable the gesture

 - (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.enabled = NO;
    [super pushViewController:viewController animated:animated];
}

 #pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    
//    if (navigationController.viewControllers.count == 1 ||  [viewController isKindOfClass:[AuthenticationRootViewController class]] || [viewController isKindOfClass:[ProductDetailViewController class]]) {
//        
//        //如果是 rootViewController  // 世泽认证流程关闭 禁止滑动手势
//        self.interactivePopGestureRecognizer.enabled = NO;
//    } else{
//        //如果不是 就启用 滑动手势
//        self.interactivePopGestureRecognizer.enabled = YES;
//    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}


@end

