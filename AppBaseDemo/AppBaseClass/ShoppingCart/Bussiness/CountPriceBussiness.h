//
//  CountPriceBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class CountPriceModel;


typedef void (^CountPriceSuccessBlock)(CountPriceModel * getSelectedProductModel);
typedef void (^CountPriceFailBlock) (NSString * failMessage);
typedef void (^CountPriceErrorBlcok)(NSString * netWorkErrorMessage);

/**
 计算价格
 */
@interface CountPriceBussiness : BaseBussiness

/**
 <#Description#>
 
 @param token <#token description#>
 @param status 0 未选中 1选中
 @param dataArray <#dataArray description#>
 @param completionHandler <#completionHandler description#>
 @param completionFailHandler <#completionFailHandler description#>
 @param completionError <#completionError description#>
 */
+ (void) requestCountPriceWithToken : (NSString* ) token
							  status:(NSString *)status
						   goodsList:(NSArray *)goodsList
				 completionSuccessHandler : (CountPriceSuccessBlock) completionHandler
					completionFailHandler : (CountPriceFailBlock) completionFailHandler
						  completionError : (CountPriceErrorBlcok) completionError;


@end
