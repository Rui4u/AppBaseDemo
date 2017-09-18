//
//  ExecuteWXPayBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class WeChaPayModel;


typedef void (^ExecuteWXPaySuccessBlock)(WeChaPayModel * getSelectedProductModel);
typedef void (^ExecuteWXPayFailBlock) (NSString * failMessage);
typedef void (^ExecuteWXPayErrorBlcok)(NSString * netWorkErrorMessage);

/**
 计算价格
 */
@interface ExecuteWXPayBussiness : BaseBussiness

/**
 <#Description#>
 
 @param token <#token description#>
 @param status 0 未选中 1选中
 @param dataArray <#dataArray description#>
 @param completionHandler <#completionHandler description#>
 @param completionFailHandler <#completionFailHandler description#>
 @param completionError <#completionError description#>
 */
+ (void) requestExecuteWXPayWithToken : (NSString* ) token
							  price:(NSString *)price
		   completionSuccessHandler : (ExecuteWXPaySuccessBlock) completionHandler
			  completionFailHandler : (ExecuteWXPayFailBlock) completionFailHandler
					completionError : (ExecuteWXPayErrorBlcok) completionError;


@end

