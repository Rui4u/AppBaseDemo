//
//  CancelOrderBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"



typedef void (^CancelOrderSuccessBlock)(NSDictionary *dict);
typedef void (^CancelOrderFailBlock) (NSString * failMessage);
typedef void (^CancelOrderErrorBlcok)(NSString * netWorkErrorMessage);

/**
 取消订单
 */
@interface CancelOrderBussiness : BaseBussiness


+ (void) requestCancelOrderWithToken : (NSString* ) token
							  orderId: (NSString *) orderId
			completionSuccessHandler : (CancelOrderSuccessBlock) completionHandler
			   completionFailHandler : (CancelOrderFailBlock) completionFailHandler
					 completionError : (CancelOrderErrorBlcok) completionError;

@end
