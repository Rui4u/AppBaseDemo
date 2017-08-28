//
//  SearchAppProductListBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"

@class GetSelectedProductModel;
typedef void (^SearchAppProductListSuccessBlock)(GetSelectedProductModel * getSelectedProductModel);
typedef void (^SearchAppProductListFailBlock) (NSString * failMessage);
typedef void (^SearchAppProductListErrorBlcok)(NSString * netWorkErrorMessage);

/**
 搜索商品
 */
@interface SearchAppProductListBussiness : BaseBussiness



/**
 <#Description#>

 @param token <#token description#>
 @param goodName <#goodName description#>
 @param completionHandler <#completionHandler description#>
 @param completionFailHandler <#completionFailHandler description#>
 @param completionError <#completionError description#>
 */
+ (void) requestSearchAppProductListWithToken : (NSString* ) token
									 goodName : (NSString *)goodName
				   completionSuccessHandler : (SearchAppProductListSuccessBlock) completionHandler
					  completionFailHandler : (SearchAppProductListFailBlock) completionFailHandler
							completionError : (SearchAppProductListErrorBlcok) completionError;


@end
