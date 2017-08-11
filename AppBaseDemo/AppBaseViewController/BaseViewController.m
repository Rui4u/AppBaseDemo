//
//  ViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/27.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseViewController.h"
#import "TipLabel.h"
#import "CommonSearchController.h"
@interface BaseViewController ()<CustomNavBarViewDelegate,UISearchBarDelegate,HZCustomSearchBarDelegate>

/**
 navBar 类型
 */
@property (nonatomic ,assign )  NAV_BAR_TYPE navBarType;
/**
 search搜索类型
 */
@property (nonatomic ,assign ) SearchType searchType;
@property (nonatomic ,copy ) NSString * searchBarPlaceholder;

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


- (void)initSearchBarViewWithPlaceholder:(NSString *)placeholder withSearchType:(SearchType) searchType{
	self.searchType = searchType;
	self.searchBarPlaceholder = placeholder;
	
	HZCustomSearchBar *searchBar;
	if (self.navBarType == NAV_BAR_TYPE_SECOND_LEVEL_VIEW ) {
		searchBar = [[HZCustomSearchBar alloc]initWithFrame:CGRectMake(55, NAV_BAR_HEIGHT - 30 - 7, SCREEN_WIDTH - 70, 30)];
	}else {
		
		searchBar = [[HZCustomSearchBar alloc]initWithFrame:CGRectMake(15, NAV_BAR_HEIGHT - 30 - 7, SCREEN_WIDTH - 30, 30)];
		
	}
	self.searchBar = searchBar;
	searchBar.delegate = self;
	searchBar.placeholder = placeholder;
	searchBar.searchBarBackgroundColor = [UIColor colorWithHexString:@"232226"];
	
	//    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
	//    [searchField setValue:[UIColor colorWithHexString:@"8d8d8e"] forKeyPath:@"_placeholderLabel.textColor"];
	//    [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
	//
	//    searchField.textColor = [UIColor colorWithHexString:@"ffffff"];
	//    searchBar.showsCancelButton = NO;
	//    [searchBar setContentMode:UIViewContentModeLeft];
	//    UIImage* searchBarBg = [self GetImageWithColor:[UIColor colorWithHexString:@"232226"] andHeight:searchBar.height];
	//    //设置背景图片
	//    [searchBar setBackgroundImage:searchBarBg];
	//    //设置背景色
	//    [searchBar setBackgroundColor:[UIColor clearColor]];
	//    //设置文本框背景
	//    [searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
	searchBar.layer.masksToBounds = YES;
	searchBar.layer.cornerRadius = 3;
	[self.navBarView addSubview:self.searchBar];
	
}

- (void)searchBarShouldBeginEditing
{
	
		CommonSearchController * commonSearchController = [[CommonSearchController alloc] init];
		commonSearchController.searchType = self.searchType;
		commonSearchController.searchBarPlaceholder = self.searchBarPlaceholder;
		
		[self.navigationController pushViewController:commonSearchController animated:YES];
		
	
}

/**
*  生成图片
*
*  @param color  图片颜色
*  @param height 图片高度
*
*  @return 生成的图片
*/
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
	CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
	UIGraphicsBeginImageContext(r.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, r);
	
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return img;
}
@end
