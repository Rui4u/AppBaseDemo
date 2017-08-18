//
//  OrderDetailBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class OrderDetailModel;


typedef void (^OrderDetailSuccessBlock)(OrderDetailModel * getSelectedProductModel);
typedef void (^OrderDetailFailBlock) (NSString * failMessage);
typedef void (^OrderDetailErrorBlcok)(NSString * netWorkErrorMessage);

/**
 订单详情
 */
@interface OrderDetailBussiness : BaseBussiness

/**
 <#Description#>
 
 @param token <#token description#>
 @param status  1 待发货，2待收货，3已完成
 
 @param dataArray <#dataArray description#>
 @param completionHandler <#completionHandler description#>
 @param completionFailHandler <#completionFailHandler description#>
 @param completionError <#completionError description#>
 */
+ (void) requestOrderDetailWithToken : (NSString* ) token
							  State:(NSString *)State
		  completionSuccessHandler : (OrderDetailSuccessBlock) completionHandler
			 completionFailHandler : (OrderDetailFailBlock) completionFailHandler
				   completionError : (OrderDetailErrorBlcok) completionError;


@end
