//
//  AppDelegate.h
//  AppBaseDemo
//
//  Created by sharui on 2017/7/27.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RootViewController.h"
#import "SRCustomTabBarController.h"
#import "CustomNavigationController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

/**
 *  RootViewController
 */
@property (nonatomic , strong) RootViewController * rootViewController ;

/**
 根控制器navgationController
 */
@property (nonatomic ,strong ) CustomNavigationController * navgationController;

/**
 customTabBar
 */
@property (nonatomic ,strong ) SRCustomTabBarController *customTabBar;
- (void)saveContext;


@end

