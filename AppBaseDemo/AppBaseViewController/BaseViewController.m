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
#import "LoginViewRootController.h"
#import "DispatchTimer.h"
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

@property (nonatomic , strong) DispatchTimer * dispatchTimer;

/**
 <#Description#>
 */
@property (nonatomic ,strong) MBProgressHUD *hud;
@end

@implementation BaseViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.navigationController.navigationBar.hidden = YES;
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.view.backgroundColor = [UIColor colorWithHexString:Main_BackGround_Color];
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
	_hud.center = self.view.center;
	
}

- (void)showHUD {

    if (!_hud.superview) {
        [self.view addSubview:_hud];
    }
	
	_hud.center = self.view.center;
    [self.view bringSubviewToFront:_hud];
    [_hud showAnimated:YES];
	


}
- (void)dismissHUD {
    [_hud hideAnimated:YES];
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

/**
 *  显示Toast形式提示
 *
 *  @param message  Toast Message
 *  @param interval Toas showTime
 */
+ (void)showToastWithMessage:(NSString *)message showTime:(float)interval {
    
    if (message == nil || [message isEqualToString:@""]) return;
    
    TipLabel * tip = [[TipLabel alloc] init];
    [tip showToastWithMessage:message showTime:interval];
}
- (void)back {
	
	[self.navigationController popViewControllerAnimated:YES];
	
}
- (void) showLoginViewController:(void (^ __nullable )( BOOL loginStatus)) loginBlock
{
    LoginViewRootController * login = [[LoginViewRootController alloc] init];
	login.loginInBlock = loginBlock;
    [self presentViewController:login animated:YES completion:nil];
}


- (void)initSearchBarViewWithPlaceholder:(NSString *)placeholder withSearchType:(SearchType) searchType{
	self.searchType = searchType;
	self.searchBarPlaceholder = placeholder;
	
	
	HZCustomSearchBar *searchBar;
	if (self.navBarType == NAV_BAR_TYPE_SECOND_LEVEL_VIEW ) {
		searchBar = [[HZCustomSearchBar alloc]initWithFrame:CGRectMake(55, NAV_BAR_HEIGHT - 30 - 7, SCREEN_WIDTH - 70, 30)];
	}else {
		
		searchBar = [[HZCustomSearchBar alloc]initWithFrame:CGRectMake(60, NAV_BAR_HEIGHT - 30 - 7, SCREEN_WIDTH - 120, 30)];
		
	}
	self.searchBar = searchBar;
	searchBar.delegate = self;
	searchBar.placeholder = placeholder;
	searchBar.searchBarBackgroundColor = [UIColor colorWithWhite:0 alpha:.3];
    
//	searchBar.searchBarBackgroundColor = [UIColor colorWithWhite:1 alpha:1];
	searchBar.layer.masksToBounds = YES;
	searchBar.layer.cornerRadius = 15;
	[self.navBarView addSubview:self.searchBar];
	
}

- (void)searchBarShouldBeginEditing
{
	
	
	if (self.searchType == SearchType_Pop) {
		[self.navigationController popViewControllerAnimated:YES];
	}else {
		CommonSearchController * commonSearchController = [[CommonSearchController alloc] init];
		commonSearchController.searchType = self.searchType;
		commonSearchController.searchBarPlaceholder = self.searchBarPlaceholder;
		
		[self.navigationController pushViewController:commonSearchController animated:YES];
	}
	
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

#pragma mark - 定时器
- (void)openTimerWithTime:(NSInteger)time
             countDownBtn:(UIButton *)countDownBtn
        againAcquireColor:(NSString *)againAcquireColor
           countDownColor:(NSString *)countDownColor
{
    __weak typeof(self) weakSelf = self;
    __block NSInteger timeout = time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    if (self.dispatchTimer.timer)
    {
        dispatch_source_cancel(self.dispatchTimer.timer);
    }
    self.dispatchTimer.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(self.dispatchTimer.timer,dispatch_walltime(NULL, 0),1.0 *NSEC_PER_SEC, 0); //每60秒执行
    
    
    dispatch_source_set_event_handler(self.dispatchTimer.timer, ^{
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if (timeout<= 0)
            {
                countDownBtn.userInteractionEnabled = YES;
                dispatch_source_cancel(weakSelf.dispatchTimer.timer);
                [countDownBtn setTitle:@"重新获取" forState:UIControlStateNormal];
                [countDownBtn setTitleColor:[UIColor colorWithHexString:againAcquireColor] forState:UIControlStateNormal];
                NSLog(@"-----------------------------------");
            }
            else
            {
                countDownBtn.userInteractionEnabled = NO;
                [countDownBtn setTitleColor:[UIColor colorWithHexString:countDownColor] forState:UIControlStateNormal];
                [countDownBtn setTitle:[NSString stringWithFormat:@"%lds",(long)timeout] forState:UIControlStateNormal];
                NSLog(@"++++++++++++++++++++++++++++++++++");
                
            }
            timeout --;
        });
    });
    //启动dispatch_source_t
    dispatch_resume(self.dispatchTimer.timer);
}
- (DispatchTimer *)dispatchTimer
{
    return [DispatchTimer sharedDispathTimer];
}
#pragma mark - NSObject dealloc
- (void) dealloc
{
    if (self.dispatchTimer.timer)
    {
        if (dispatch_source_testcancel(self.dispatchTimer.timer) != 0)
        {
            self.dispatchTimer.timer = nil;
        }
        else
        {
            dispatch_source_cancel(self.dispatchTimer.timer);
            self.dispatchTimer.timer = nil;
        }
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [self.searchBar resignFirstResponder];
    self.searchBar.text = @"";
    [super viewWillDisappear:animated];
    
    
    DDLog(@" \n viewWillDisappear  class is  = %@  \n" , self.class);
    
    if (self.dispatchTimer.timer)
    {
        if (dispatch_source_testcancel(self.dispatchTimer.timer) != 0)
        {
            self.dispatchTimer.timer = nil;
        }
        else
        {
            dispatch_source_cancel(self.dispatchTimer.timer);
            self.dispatchTimer.timer = nil;
        }
    }
    
    
}
@end
