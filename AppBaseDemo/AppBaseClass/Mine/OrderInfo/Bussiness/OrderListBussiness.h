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

+ (void) requestOrderListWithToken : (NSString* ) token
							orderId:(NSString *)orderId
				 completionSuccessHandler : (OrderListSuccessBlock) completionHandler
					completionFailHandler : (OrderListFailBlock) completionFailHandler
					completionError : (OrderListErrorBlcok) completionError;


@end
