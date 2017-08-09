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
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kCityListBusinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 
		 if ([[responeMp objectForKey:@"isSucceed"] isEqualToString:@"yes"]) {
			 completionHandler(YES);//注册成功
		 }else {
			 completionHandler(NO);//提交成功
		 }
		 
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 if (error)
		 {
			 if (error.code == 1001)//服务器链接异常,请稍后重试.
			 {
				 if (error.domain)
				 {
					 completionError([error.domain copy]);
				 }
			 }
			 else if (error.code == 1010)//网络异常,请稍后重试。
			 {
				 if (error.domain)
				 {
					 completionError([error.domain copy]);
				 }
			 }
			 else
			 {
				 NSString * errorMessage = @"网络异常,请稍后重试。";
				 completionError(errorMessage);
			 }
		 }
	 }];
}
@end
