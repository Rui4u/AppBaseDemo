//
//  ShopCartListBottomView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/16.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShopCartListBottomViewDelegate<NSObject>

- (void)clickSelectAllWithButtonSelected:(BOOL)selected;

- (void)goToSettle;

@end
@interface ShopCartListBottomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *depositLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UIButton *goShopCartButton;

/**
 <#Description#>
 */
@property (nonatomic ,assign) BOOL isCalculation;
@property (nonatomic ,weak ) id <ShopCartListBottomViewDelegate> delegate;
@end
