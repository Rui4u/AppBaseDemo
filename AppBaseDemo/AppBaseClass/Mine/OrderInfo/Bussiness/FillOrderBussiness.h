//
//  FillOrderBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class FillOrderModel;


typedef void (^FillOrderSuccessBlock)(FillOrderModel * getSelectedProductModel);
typedef void (^FillOrderFailBlock) (NSString * failMessage);
typedef void (^FillOrderErrorBlcok)(NSString * netWorkErrorMessage);

/**
 填写订单
 */
@interface FillOrderBussiness : BaseBussiness


+ (void) requestFillOrderWithToken : (NSString* ) token
                           goodsList:(NSArray *)goodsList
            completionSuccessHandler : (FillOrderSuccessBlock) completionHandler
               completionFailHandler : (FillOrderFailBlock) completionFailHandler
                     completionError : (FillOrderErrorBlcok) completionError;

@end
