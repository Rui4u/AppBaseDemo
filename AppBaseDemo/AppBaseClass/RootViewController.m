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
#import "MoreViewController.h"
#import "ShoppingCartViewController.h"
#import "ShoppingCartListBussiness.h"
#import "ShoppingCartListModel.h"
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
@property (nonatomic ,strong ) ShoppingCartViewController * shoppingCartViewController;

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
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(ShoppingCartNumberNotify)
												 name:CNotificationShoppingCartNumberNotify
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(CNotificationLogInSucessFuntion)
												 name:CNotificationLogInSucess
											   object:nil];

	//注册退出成功通知

    [self setUpCustomTabBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登录成功

- (void)CNotificationLogInSucessFuntion {
	
	
	[ShoppingCartListBussiness requestShoppingCartListWithToken:TOKEN completionSuccessHandler:^(ShoppingCartListModel *shoppingCartListModel) {
		[ShoppingCartManager sharedManager].CarInfoList = shoppingCartListModel.CarInfoList.mutableCopy;
		[CommonNotification postNotification:CNotificationShoppingCartNumberNotify userInfo:nil object:nil];

	} completionFailHandler:^(NSString *failMessage) {
		[self showToastWithMessage:failMessage showTime:1];
	} completionError:^(NSString *netWorkErrorMessage) {
		[self showToastWithMessage:netWorkErrorMessage showTime:1];
	}];

}

#pragma mark - 添加购物车通知

- (void)ShoppingCartNumberNotify {

	APP_DELEGATE.customTabBar.tabBarView.shoppingCartButton.badgeString = [NSString stringWithFormat:@"%tu",[ShoppingCartManager sharedManager].selectNumber];

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
        if ([viewController isEqual:self.shoppingCartViewController])
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
 
}




#pragma mark --





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
	
    self.productViewController.title = @"全部产品··";
    [self.productViewController.tabBarItem setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    
    self.productViewController.tabBarItem.image = [[UIImage imageNamed:@"icon_product_normal"]
                                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.productViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_product_select"]
                                                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.shoppingCartViewController = [[ShoppingCartViewController alloc] init];
    self.shoppingCartViewController.title = @"购物车";
    [self.shoppingCartViewController.tabBarItem setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    
    
    self.shoppingCartViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_wealth_select"]
                                                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.shoppingCartViewController.tabBarItem.image = [[UIImage imageNamed:@"icon_wealth_normal"]
                                                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    self.moreViewController = [[MoreViewController alloc] init];
    self.moreViewController.title = @"我的";
    [self.moreViewController.tabBarItem setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    
    
    self.moreViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_more_select"]
                                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.moreViewController.tabBarItem.image = [[UIImage imageNamed:@"icon_more_normal"]
                                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
	
    [customTabBar addChildViewController:self.  homeViewController];
    [customTabBar addChildViewController:self.productViewController];
    [customTabBar addChildViewController:self.shoppingCartViewController];
    [customTabBar addChildViewController:self.moreViewController];
    
   	
	[customTabBar.tabBarView setlectNomalTabBar];
	
	if (!isNotLogin) {
		[CommonNotification postNotification:CNotificationLogInSucess userInfo:nil object:nil];

	}
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
