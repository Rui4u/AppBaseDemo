//
//  VerifyCodeTelUpdateBusiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/9.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "VerifyCodeTelUpdateBussiness.h"

@implementation VerifyCodeTelUpdateBussiness

+ (void) requestStoreInfoWithPhoneNum:(NSString *)phoneNum
						   verifyCode:(NSString *)verifyCode
			completionSuccessHandler : (VerifyCodeTelUpdateSuccessBlock) completionHandler
			   completionFailHandler : (VerifyCodeTelUpdateFailBlock) completionFailHandler
					 completionError : (VerifyCodeTelUpdateErrorBlcok) completionError;
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:phoneNum forKey:@"phoneNum"];
	[body setValue:verifyCode forKey:@"verifyCode"];

	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:KVerifyCodeTelUpdateBussinessUrl
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
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end
