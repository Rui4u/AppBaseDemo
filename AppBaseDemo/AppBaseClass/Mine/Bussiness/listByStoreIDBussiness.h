//
//  listByStoreIDBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/10/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"



typedef void (^listByStoreIDSuccessBlock)(NSDictionary* succeed);
typedef void (^listByStoreIDFailBlock) (NSString * failMessage);
typedef void (^listByStoreIDErrorBlcok)(NSString * netWorkErrorMessage);

/**
 
 */
@interface listByStoreIDBussiness : BaseBussiness

/**
 问题
 
 */
+ (void) requestlistByStoreIDWithToken : (NSString* ) token
		 completionSuccessHandler : (listByStoreIDSuccessBlock) completionHandler
			completionFailHandler : (listByStoreIDFailBlock) completionFailHandler
				  completionError : (listByStoreIDErrorBlcok) completionError;

@end
