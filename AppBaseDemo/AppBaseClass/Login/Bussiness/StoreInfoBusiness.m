//
//  StoreInfoBusiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/9.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "StoreInfoBusiness.h"

@implementation StoreInfoBusiness

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
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:storeName forKey:@"storeName"];
	[body setValue:managerName forKey:@"managerName"];
	[body setValue:storeAddress forKey:@"storeAddress"];
	[body setValue:longitude forKey:@"longitude"];
	[body setValue:latitude forKey:@"latitude"];
	[body setValue:adCode forKey:@"adCode"];
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:KStoreInfoBussinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 
		 
		 NSArray * infoArray = [[success objectForKey:@"store"] allKeys];
		 for (int i = 0 ; i < infoArray.count; i ++) {
			 if (![infoArray[i] isEqualToString:@"token"]){
				 saveDataUserDefaultForValueKey([[success objectForKey:@"store"] valueForKey:infoArray[i]] , infoArray[i]);
			 }
		 }
		 
		 if ([[responeMp objectForKey:@"isSucceed"] isEqualToString:@"yes"]) {
			 completionHandler(YES);//注册成功
		 }else {
			 completionHandler(NO);//提交成功
		 }
		 
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);

	 }];
}
@end
