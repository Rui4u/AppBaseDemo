//
//  GetDeleteCartBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBussiness.h"


typedef void (^DeleteCartSuccessBlock)(NSString * getSelectedProductModel);
typedef void (^DeleteCartFailBlock) (NSString * failMessage);
typedef void (^DeleteCartErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取全部商品
 */
@interface DeleteCartBusiness : BaseBussiness

/**
 <#Description#>
 
 @param token <#token description#>
 @param parented 一级菜品
 @param categoryIdTwo 二级类目
 @param completionHandler <#completionHandler description#>
 @param completionFailHandler <#completionFailHandler description#>
 @param completionError <#completionError description#>
 */
+ (void) requestDeleteCartWithToken : (NSString* ) token
						   goodsList: (NSArray *)goodsList
				   completionSuccessHandler : (DeleteCartSuccessBlock) completionHandler
					  completionFailHandler : (DeleteCartFailBlock) completionFailHandler
							completionError : (DeleteCartErrorBlcok) completionError;


@end
