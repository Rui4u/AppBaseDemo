//
//  UpdateforaddressBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/10/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"



typedef void (^UpdateforaddressSuccessBlock)(NSDictionary* succeed);
typedef void (^UpdateforaddressFailBlock) (NSString * failMessage);
typedef void (^UpdateforaddressErrorBlcok)(NSString * netWorkErrorMessage);

/**
 
 */
@interface UpdateforaddressBussiness : BaseBussiness

/**
 问题
 
 */
+ (void) requestUpdateforaddressWithToken : (NSString* ) token
								 addressId:(NSString *)addressId
			completionSuccessHandler : (UpdateforaddressSuccessBlock) completionHandler
			   completionFailHandler : (UpdateforaddressFailBlock) completionFailHandler
					 completionError : (UpdateforaddressErrorBlcok) completionError;

@end


