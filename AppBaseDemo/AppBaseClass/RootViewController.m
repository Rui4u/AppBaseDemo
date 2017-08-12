//
//  RootViewController.m
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 16/9/29.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "AppProductViewController.h"

@interface RootViewController ()<UITabBarControllerDelegate,SRCustomTabBarViewDelegate>



/**
 首页
 */
@property (nonatomic ,strong ) HomeViewController * homeViewController;

/**
 产品中心
 */
@property (nonatomic ,strong ) AppProductViewController * productViewController;

/**
 我的财富
 */
@property (nonatomic ,strong ) UIViewController * myTreasureViewController;

/**
 更多
 */
@property (nonatomic ,strong ) UIViewController * moreViewController;


/**
 当前控制器
 */
@property (nonatomic ,strong ) UIViewController * currentViewController;

/**
 是否登录
 */
@property (nonatomic ,assign ) BOOL isLogin;
/**
 刷新rootVc
 */
- (void) privateReferRootViewWithBuy ;

- (void) privateReferRootReciveLogOutSucess ;

- (void) privateReferRootReciveLoginSucess ;

@property (nonatomic ,strong ) SRCustomTabBarController *customTabBar;
@end

@implementation RootViewController

- (instancetype) init
{
    return self;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
	
    [self setUpCustomTabBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - tabBar面包客

- (void)selectCustomTabBarAtCurrentIndex:(NSInteger)index withLastIndex:(NSInteger)lastIndex {
	
	
	if ([self tabBarController:APP_DELEGATE.customTabBar shouldSelectViewController:APP_DELEGATE.customTabBar.childViewControllers[index]]) {
		
		APP_DELEGATE.customTabBar.selectedIndex = index;
	
	}else {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

			APP_DELEGATE.customTabBar.tabBarView.selectedIndex = lastIndex;
		});
		
	}
	
	
}


// 实现点击选择前截取
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (self.isLogin)//未登录状态
    {
        if ([viewController isEqual:self.myTreasureViewController])
        {
            __block NSInteger selectedIndex = [APP_DELEGATE.customTabBar.childViewControllers indexOfObject:viewController];
            NSLog(@"%tu",selectedIndex);
            [super showLoginViewController:^(BOOL loginStatus) {
				APP_DELEGATE.customTabBar.tabBarView.selectedIndex = selectedIndex;
			}];
            return NO;
        }
    }
    return YES;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	
	self.currentViewController = viewController;
    if (!([viewController isKindOfClass:[self.moreViewController class]] ||
          [viewController isKindOfClass:[self.myTreasureViewController class]]))
    {
        [self privateReferRootViewWithBuy];
    }
}




#pragma mark --



- (void) privateReferRootViewWithBuy
{
}


- (void)setUpCustomTabBar
{
    
    SRCustomTabBarController *customTabBar = [[SRCustomTabBarController alloc] init];
	self.customTabBar = customTabBar;
    customTabBar.delegate = self;
    APP_DELEGATE.customTabBar = customTabBar;
    [self.view addSubview: customTabBar.view];
    [self addChildViewController:customTabBar];
	
	customTabBar.tabBarView.delegate = self;
	
    self.mainTabBar = customTabBar;
    
    NSMutableDictionary *selectAtts=[NSMutableDictionary dictionary];
    // 更改文字大小
    selectAtts[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    // 更改文字颜色
	selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithHexString:Main_Font_Green_Color];
	
    
    
    self.homeViewController = [[HomeViewController alloc] init];
    self.  homeViewController.title = @"首页";
    [self.  homeViewController.tabBarItem setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    
    
    
    self.  homeViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_selection_select"]
                                                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.  homeViewController.tabBarItem.image = [[UIImage imageNamed:@"icon_selection_normal"]
                                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    self.productViewController = [[AppProductViewController alloc] init];
	
    self.productViewController.title = @"产品中心";
    [self.productViewController.tabBarItem setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    
    self.productViewController.tabBarItem.image = [[UIImage imageNamed:@"icon_product_normal"]
                                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.productViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_product_select"]
                                                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.myTreasureViewController = [[UIViewController alloc] init];
    self.myTreasureViewController.title = @"咨询管理";
    [self.myTreasureViewController.tabBarItem setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    
    
    self.myTreasureViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_wealth_select"]
                                                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.myTreasureViewController.tabBarItem.image = [[UIImage imageNamed:@"icon_wealth_normal"]
                                                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    self.moreViewController = [[UIViewController alloc] init];
    self.moreViewController.title = @"更多";
    [self.moreViewController.tabBarItem setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    
    
    self.moreViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_more_select"]
                                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.moreViewController.tabBarItem.image = [[UIImage imageNamed:@"icon_more_normal"]
                                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
	
    [customTabBar addChildViewController:self.  homeViewController];
    [customTabBar addChildViewController:self.productViewController];
    [customTabBar addChildViewController:self.myTreasureViewController];
    [customTabBar addChildViewController:self.moreViewController];
    
   	
	[customTabBar.tabBarView setlectNomalTabBar];
}




//第一次默认第一个控制器
- (UIViewController *)currentViewController
{
    if (_currentViewController == nil)
    {
        _currentViewController = self.  homeViewController;
    }
    return _currentViewController;
}
@end
