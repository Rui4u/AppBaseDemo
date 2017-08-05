//
//  CustomScrollSelectView.h
//  HZAgentiOSClient
//
//  Created by sharui on 2017/6/7.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomScrollSelectView;
/**
 点击不同产品类型时触发
 */
@protocol CustomScrollSelectViewDelegate <NSObject>

- (void)customScrollSelectView:(CustomScrollSelectView *)customScrollSelectView
 didSelectWithProductTypeModel:(id )productTypeMode;
@end

/**
 自定义可滑动选择视图 类似网易
 */
@interface CustomScrollSelectView : UIView


/**
 0 p2p 1 世泽
 
 @param index <#index description#>
 */
- (void)selectSwitchButtonAtIndex:(NSInteger) index;
@property (nonatomic,weak) id <CustomScrollSelectViewDelegate>delegate;


/**
 文字颜色
 */
@property (nonatomic ,strong ) UIColor * textColor;

/**
 文字选中颜色
 */
@property (nonatomic ,strong ) UIColor * textSelectColor;
/**
 数据源
 */
@property (nonatomic ,strong ) NSArray* dataSourse;

/**
 刷新数据
 */
- (void)reloadeData;
@end
