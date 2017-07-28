//
//  ViewController.h
//  AppBaseDemo
//
//  Created by sharui on 2017/7/27.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavBarView.h"
@interface BaseViewController : UIViewController

@property(nonatomic,strong) CustomNavBarView * _Nullable navBarView;

- (void) showLoginViewController:(void (^_Nullable)( BOOL loginStatus)) loginBlock;
/**
 *  显示Toast形式提示
 *
 *  @param message  Toast Message
 *  @param interval Toas showTime
 */
- (void)showToastWithMessage:(NSString * _Nullable )message showTime:(float)interval;

/**
 返回
 */
- (void)back;
- (void)initNavBarView:(NAV_BAR_TYPE)type;

@end

