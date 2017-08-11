//
//  SRCustomLabel.h
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 2016/10/19.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,VerticalAlignment)
{
    VerticalAlignmentTop = 1, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} ;
/**
 自定义Label
 */
@interface SRCustomLabel : UILabel


/**
 控制字体与控件边界的间隙
 */
@property (nonatomic, assign) UIEdgeInsets textInsets;

/**
 居上
 */
@property (nonatomic) VerticalAlignment verticalAlignments;

/**
 间距
 */
@property (nonatomic ,assign ) NSInteger spacing;

@end
