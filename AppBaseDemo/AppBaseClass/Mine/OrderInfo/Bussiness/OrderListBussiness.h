//
//  OrderListBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class OrderListModel;


typedef void (^OrderListSuccessBlock)(OrderListModel * getSelectedProductModel);
typedef void (^OrderListFailBlock) (NSString * failMessage);
typedef void (^OrderListErrorBlcok)(NSString * netWorkErrorMessage);

/**
 订单列表
 */
@interface OrderListBussiness : BaseBussiness

/**
 <#Description#>
 
 @param token <#token description#>
 @param status  1 待发货，2待收货，3已完成

 @param dataArray <#dataArray description#>
 @param completionHandler <#completionHandler description#>
 @param completionFailHandler <#completionFailHandler description#>
 @param completionError <#completionError description#>
 */
+ (void) requestOrderListWithToken : (NSString* ) token
							  state:(NSString *)state
				 completionSuccessHandler : (OrderListSuccessBlock) completionHandler
					completionFailHandler : (OrderListFailBlock) completionFailHandler
					completionError : (OrderListErrorBlcok) completionError;


@end
