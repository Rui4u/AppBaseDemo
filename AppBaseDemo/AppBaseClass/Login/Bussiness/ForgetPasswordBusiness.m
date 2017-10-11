//
//  ForgetPasswordBusiness.m
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing on 16/10/23.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "ForgetPasswordBusiness.h"

@implementation ForgetPasswordBusiness

+ (void) ForgetPasswordWithStoreTelephone : (NSString * ) storeTelephone
						   storePwd : (NSString * ) storePwd
						 verifyCode : (NSString * ) verifyCode
		   completionSuccessHandler : (ForgetPasswordSuccessBlock) completionHandler
			  completionFailHandler : (ForgetPasswordFailBlock) completionFailHandler
					completionError : (ForgetPasswordErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:storePwd forKey:@"storePwd"];
	[body setValue:storeTelephone forKey:@"storeTelephone"];
	[body setValue:verifyCode forKey:@"verifyCode"];
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kForgetPasswordBusinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 
		 
		 if ([[responeMp objectForKey:@"isSucceed"] isEqualToString:@"yes"]) {
			 completionHandler(YES);//注册成功
			 
		 }
		 
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end

