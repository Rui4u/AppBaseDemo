//
//  ProductDetailBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//


#import "BaseBussiness.h"
@class HomeDataModel;
typedef void (^ProductDetailSuccessBlock)(HomeDataModel * listArray);
typedef void (^ProductDetailFailBlock) (NSString * failMessage);
typedef void (^ProductDetailErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取商品商品详情
 */
@interface ProductDetailBussiness : BaseBussiness




+ (void) requestProductDetailWithToken : (NSString * )token
                               goodsId : (NSString *)goodsId
              completionSuccessHandler : (ProductDetailSuccessBlock) completionHandler
                 completionFailHandler : (ProductDetailFailBlock) completionFailHandler
                       completionError : (ProductDetailErrorBlcok) completionError;
@end
