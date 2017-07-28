//
//  CustomNavBarView.h
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/10/9.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *   CustBarView类型
 */
typedef NS_ENUM(NSInteger , NAV_BAR_TYPE)
{
    NAV_BAR_TYPE_ROOT_VIEW = 0,//主框架的导航条
    NAV_BAR_TYPE_SECOND_LEVEL_VIEW = 1,//二级页面导航条
    NAV_BAR_TYPE_SECOND_LEVEL_VIEW_CLOSE = 2, //二级页面导航条 待返回键  带关闭文案
};

@protocol CustomNavBarViewDelegate;




/**
 *   自定义ViewController顶部BarView
 */
@interface CustomNavBarView : UIView

@property(nonatomic,weak) id <CustomNavBarViewDelegate> delegate;
@property(nonatomic,assign) NAV_BAR_TYPE bType;
@property(nonatomic,strong) UIImageView * navBarImageView;
@property(nonatomic,strong) UIButton * backBtn;
@property(nonatomic,strong) UILabel * titleLabel;
/**
 *  初始化 CustomNavBarView
 *
 *  @param frame frame
 *  @param type  type
 *
 *  @return CustomNavBarView
 */
- (id)initWithFrame:(CGRect)frame type:(NAV_BAR_TYPE)type;
/**
 *  设置BarView Title
 *
 *  @param title <#title description#>
 */
- (void)setTitle:(NSString *)title;
@end

#pragma mark -  CustomNavBarViewDelegate
/**
 *  自定义NavgationBarView 协议
 */
@protocol CustomNavBarViewDelegate <NSObject>
@optional
/**
 *  顶部TopBarView 返回上一级页面
 */
- (void)back;
/**
 *  顶部TopBarView 消失
 */
- (void)dismiss;

@end
