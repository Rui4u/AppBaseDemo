//
//  NewCustomAlertView.h
//  HZAgentiOSClient
//
//  Created by sharui on 2017/8/23.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 对象方法 可控制宽度等。
 */
@interface NewCustomAlertView : UIView

/**
 alert宽度
 */
@property (nonatomic ,assign ) CGFloat alertViewWidth;

/**
 高度
 */
@property (nonatomic ,assign ) CGFloat contentViewHeight;

/**
 按钮数组
 */
@property (nonatomic ,strong ) NSArray * buttonTitleArray;

/**
 按钮颜色
 */
@property (nonatomic ,strong ) NSArray * buttonColorArray;

/**
 包含内容
 */
@property (nonatomic ,assign ) UIView *contentView;

/**
 标题名称
 */
@property (nonatomic ,copy ) NSString * titleLabelText;

/**
 点击回调
 */
@property (nonatomic ,copy ) void(^clickBlock)(NSInteger index);


- (void)reloadData;
@end
