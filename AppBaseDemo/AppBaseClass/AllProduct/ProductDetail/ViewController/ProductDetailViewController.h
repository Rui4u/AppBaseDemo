//
//  ProductDetailViewController.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseViewController.h"

@interface ProductDetailViewController : BaseViewController
/**
 商品id
 */
@property (nonatomic ,copy) NSString * goodsId;
/**
 规格id
 */
@property (nonatomic ,copy) NSString * guigeId;
@end
