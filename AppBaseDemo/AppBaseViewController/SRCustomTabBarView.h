//
//  SRCustomTabbarView.h
//    SRiOSClient
//
//  Created by sharui on 2017/4/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCVerticalBadgeBtn.h"
@protocol SRCustomTabBarViewDelegate <NSObject>



/**
 选择哪个bar

 @param tag 当前tag
 @param lastTag 上一个tag
 */
- (void)selectCustomTabBarAtCurrentIndex:(NSInteger)index withLastIndex:(NSInteger)lastIndex;
@end
@interface SRCustomTabBarView : UIView

/**
 选择控制器的角标
 */
@property (nonatomic ,assign ) NSInteger selectedIndex;
/**
 点击代理
 */
@property (nonatomic ,weak ) id<SRCustomTabBarViewDelegate> delegate;
/**
 当前button
 */
@property (nonatomic ,strong ) LCVerticalBadgeBtn * shoppingCartButton;
/**
 设置默认tabbar
 */
- (void)setlectNomalTabBar;

@end
