//
//  GetSelectGoodsListBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"

@class GetSelectedProductModel;
typedef void (^GetSelectGoodsListSuccessBlock)(GetSelectedProductModel * getSelectedProductModel);
typedef void (^GetSelectGoodsListFailBlock) (NSString * failMessage);
typedef void (^GetSelectGoodsListErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取全部商品
 */
@interface GetSelectGoodsListBussiness : BaseBussiness



/**
 <#Description#>

 @param token <#token description#>
 @param parented 一级菜品
 @param categoryIdTwo 二级类目
 @param completionHandler <#completionHandler description#>
 @param completionFailHandler <#completionFailHandler description#>
 @param completionError <#completionError description#>
 */
+ (void) requestGetSelectGoodsListWithToken : (NSString* ) token
								   parented : (NSString *)parented
							  categoryIdTwo : (NSString *)categoryIdTwo
				   completionSuccessHandler : (GetSelectGoodsListSuccessBlock) completionHandler
					  completionFailHandler : (GetSelectGoodsListFailBlock) completionFailHandler
							completionError : (GetSelectGoodsListErrorBlcok) completionError;


@end
