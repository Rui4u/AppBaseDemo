//
//  ViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/27.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseViewController.h"
#import "TipLabel.h"
@interface BaseViewController ()<CustomNavBarViewDelegate>

/**
 navBar 类型
 */
@property (nonatomic ,assign )  NAV_BAR_TYPE navBarType;
@end

@implementation BaseViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.navigationController.navigationBar.hidden = YES;
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.view.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
	
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/**
 *  初始化自定义CustomBarView
 *
 *  @param type <#type description#>
 */
- (void)initNavBarView:(NAV_BAR_TYPE)type {
	
	if (self.navBarView != nil) {
		[self.navBarView removeFromSuperview];
	}
	
	self.navBarType = type;
	self.navBarView = [[CustomNavBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_BAR_HEIGHT) type:type];
	self.navBarView.delegate = self;
	self.navBarView.titleLabel.font = [UIFont boldSystemFontOfSize:17];
	[self.view addSubview:self.navBarView];
}

/**
 *  显示Toast形式提示
 *
 *  @param message  Toast Message
 *  @param interval Toas showTime
 */
- (void)showToastWithMessage:(NSString *)message showTime:(float)interval {
	
	if (message == nil || [message isEqualToString:@""]) return;
	
	TipLabel * tip = [[TipLabel alloc] init];
	[tip showToastWithMessage:message showTime:interval];
}
	
- (void)back {
	
	[self.navigationController popViewControllerAnimated:YES];
	
}
- (void) showLoginViewController:(void (^ __nullable )( BOOL loginStatus)) loginBlock
{
	
//	LoginViewRootController *loginViewRootController =  [[LoginViewRootController alloc ]init];
//	loginViewRootController.loginInBlock = loginBlock;
//	//token失效跳转登录界面
//	[[UIApplication sharedApplication].keyWindow.rootViewController
//	 presentViewController:loginViewRootController animated:YES completion:nil];
	
	
}


@end
