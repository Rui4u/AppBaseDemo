//
//  RegisterBusiness.m
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing on 16/10/23.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "RegisterBusiness.h"
@implementation RegisterBusiness

+ (void) registerWithStoreTelephone : (NSString * ) storeTelephone
						   storePwd : (NSString * ) storePwd
				   verificationCode : (NSString * ) verificationCode
     completionSuccessHandler : (RegisterSuccessBlock) completionHandler
			  completionFailHandler : (RegisterFailBlock) completionFailHandler
					completionError : (RegisterErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:storePwd forKey:@"storePwd"];
	[body setValue:storeTelephone forKey:@"storeTelephone"];
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kRegisterBusinessUrl
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
