//
//  DoOrderBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"



typedef void (^DoOrderSuccessBlock)(NSDictionary *dict);
typedef void (^DoOrderFailBlock) (NSString * failMessage);
typedef void (^DoOrderErrorBlcok)(NSString * netWorkErrorMessage);

/**
 下订单
 */
@interface DoOrderBussiness : BaseBussiness


+ (void) requestDoOrderWithToken : (NSString* ) token
						addressId: (NSString *) addressId
					   orederType: (NSString *)orederType
					 carImageInfo:(NSArray *)carImageInfo
		completionSuccessHandler : (DoOrderSuccessBlock) completionHandler
		   completionFailHandler : (DoOrderFailBlock) completionFailHandler
				 completionError : (DoOrderErrorBlcok) completionError;

@end
