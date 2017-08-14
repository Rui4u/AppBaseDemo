//
//  ProdcutDetailTopTitleView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProdcutDetailBottomView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LabelWidth;


/**
 价钱
 */
@property (nonatomic ,copy) NSString *priceText;
/**
 数量
 */
@property (nonatomic ,copy) NSString *numText;

/**
 去购物车回调
 */
@property (nonatomic ,copy ) void(^gotoProductCart)();
@end
