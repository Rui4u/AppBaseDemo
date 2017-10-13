//
//  SaveAccountBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/10/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"



typedef void (^SaveAccountSuccessBlock)(NSDictionary* succeed);
typedef void (^SaveAccountFailBlock) (NSString * failMessage);
typedef void (^SaveAccountErrorBlcok)(NSString * netWorkErrorMessage);

/**
 
 */
@interface SaveAccountBussiness : BaseBussiness

/**
 问题
 
 */
+ (void) requestSaveAccountWithToken : (NSString* ) token
							 trueName:(NSString *)trueName
							 telPhone:(NSString *)telPhone
			  completionSuccessHandler : (SaveAccountSuccessBlock) completionHandler
				 completionFailHandler : (SaveAccountFailBlock) completionFailHandler
					   completionError : (SaveAccountErrorBlcok) completionError;

@end

