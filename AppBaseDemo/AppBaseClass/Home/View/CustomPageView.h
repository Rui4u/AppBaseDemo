//
//  CustomPageView.h
//  HZAgentiOSClient
//
//  Created by sharui on 2016/11/16.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 自定义页数PageView
 */
@interface CustomPageView : UIView

/**
 创建

 @param number <#number description#>
 @return <#return value description#>
 */
- (instancetype)initWithNumber:(NSInteger )number;

/**
 滑动到指定位置

 @param number <#number description#>
 */
- (void) setRotationToNumber:(NSInteger) number;
@end
