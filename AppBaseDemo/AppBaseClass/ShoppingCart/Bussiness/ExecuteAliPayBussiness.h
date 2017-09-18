//
//  ExecuteAliPayBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
typedef void (^ExecuteAliPaySuccessBlock)(NSString * orderInfoStr);
typedef void (^ExecuteAliPayFailBlock) (NSString * failMessage);
typedef void (^ExecuteAliPayErrorBlcok)(NSString * netWorkErrorMessage);

/**
 计算价格
 */
@interface ExecuteAliPayBussiness : BaseBussiness


+ (void) requestExecuteAliPayWithToken : (NSString* ) token
								 price:(NSString *)price
			 completionSuccessHandler : (ExecuteAliPaySuccessBlock) completionHandler
				completionFailHandler : (ExecuteAliPayFailBlock) completionFailHandler
					  completionError : (ExecuteAliPayErrorBlcok) completionError;


@end


