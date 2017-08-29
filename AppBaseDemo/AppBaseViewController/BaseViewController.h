//
//  ViewController.h
//  AppBaseDemo
//
//  Created by sharui on 2017/7/27.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavBarView.h"
#import "HZCustomSearchBar.h"
typedef NS_ENUM ( NSInteger , SearchType) {
	
	SearchType_Push = 1, //面包客
	SearchType_Pop
	
};

@interface BaseViewController : UIViewController

@property(nonatomic,strong) CustomNavBarView * _Nullable navBarView;

/**
 搜索控件
 */
@property (nonatomic ,strong ) HZCustomSearchBar *searchBar;

- (void) showLoginViewController:(void (^_Nullable)( BOOL loginStatus)) loginBlock;
/**
 *  显示Toast形式提示
 *
 *  @param message  Toast Message
 *  @param interval Toas showTime
 */
- (void)showToastWithMessage:(NSString * _Nullable )message showTime:(float)interval;
+ (void)showToastWithMessage:(NSString *_Nullable)message showTime:(float)interval;
/**
 返回
 */
- (void)back;
- (void)initNavBarView:(NAV_BAR_TYPE)type;

- (void)initSearchBarViewWithPlaceholder:(NSString * _Nullable)placeholder withSearchType:(SearchType) searchType;


/**
 定时器

 @param color <#color description#>
 @param height <#height description#>
 @return <#return value description#>
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

- (void)openTimerWithTime:(NSInteger)time
             countDownBtn:(UIButton *)countDownBtn
        againAcquireColor:(NSString *)againAcquireColor
           countDownColor:(NSString *)countDownColor;

- (void)showHUD;
- (void)dismissHUD;

@end

