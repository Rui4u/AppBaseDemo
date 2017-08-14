//
//  SelectSpecificationView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/5.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectSpecificationViewDelegate <NSObject>
@optional;
- (void)changeProcutNumberBagWith:(NSString *)count with:(NSInteger) row withRect:(CGRect)rect;
/**
 选择哪个产品

 @param index 角标
 */
- (void)selectSpecificationWithIndex:(NSInteger)index;

@end
/**
 选择规格view
 */
@interface SelectSpecificationView : UIView
/**
 总价
 */
@property (nonatomic ,strong) UILabel * totolPriceLabel;
/**
 平均价
 */
@property (nonatomic ,strong) UILabel * averagePrice;

/**
 降价标签
 */
@property (nonatomic ,strong ) UIImageView* disCountView;
/**
 是否显示降价标签
 */
@property (nonatomic ,assign ) BOOL showDisCountView;
/**
 选择的角标
 */
@property (nonatomic ,assign ) NSInteger index;

@property (nonatomic ,weak ) id<SelectSpecificationViewDelegate> delegate;
@end
