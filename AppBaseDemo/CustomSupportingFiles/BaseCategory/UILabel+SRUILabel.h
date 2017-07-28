//
//  UILabel+SRUILabel.h
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 16/10/24.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SRUILabel)

/**
 创建自定义Label
 @param text     文字
 @param sizeOfFloat     字体大小
 @param colorWithString 字体颜色

 @return 
 */
+ (instancetype)creatLabelWithText:(NSString *)text
                        FontOfSize:(CGFloat)sizeOfFloat
                         textColor:(NSString *)colorWithString;



/**
 自适应高度

 @param width 宽度
 @param title 标题
 @param font  字体大小

 @return <#return value description#>
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width
                      title:(NSString *)title
                       font:(UIFont*)font;


/**
 两端对齐
 */
- (void)changeAlignmentRightandLeft;

@end
