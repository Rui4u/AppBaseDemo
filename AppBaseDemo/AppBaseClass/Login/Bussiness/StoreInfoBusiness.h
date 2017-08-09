//
//  StoreInfoBusiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/9.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"

typedef void (^StoreInfoSuccessBlock)(BOOL succeed);
typedef void (^StoreInfoFailBlock) (NSString * failMessage);
typedef void (^StoreInfoErrorBlcok)(NSString * netWorkErrorMessage);

/**
 店铺更新接口
 */
@interface StoreInfoBusiness : BaseNetWorkClient
+ (void) requestStoreInfoWithToken : (NSString *) token
						  storeName: (NSString *) storeName
						managerName: (NSString *) managerName
						  storeAddress: (NSString *) storeAddress
						  longitude: (NSString *) longitude
						   latitude: (NSString *) latitude
							 adCode: (NSString *) adCode
		  completionSuccessHandler : (StoreInfoSuccessBlock) completionHandler
			 completionFailHandler : (StoreInfoFailBlock) completionFailHandler
				   completionError : (StoreInfoErrorBlcok) completionError;


@end
