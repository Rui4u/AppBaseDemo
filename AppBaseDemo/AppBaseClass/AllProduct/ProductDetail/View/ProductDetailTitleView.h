//
//  ProductDetailTitleView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailTitleView : UIView
@property (weak, nonatomic) IBOutlet UIButton *addProductListButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic ,copy )void(^clickAddProductListButton)(UIButton *sender);
@end
