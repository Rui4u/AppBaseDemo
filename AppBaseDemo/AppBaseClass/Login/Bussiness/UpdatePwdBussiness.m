//
//  UpdatePwdBusiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/9.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "UpdatePwdBussiness.h"

@implementation UpdatePwdBussiness

+ (void) requestStoreInfoWithToken : (NSString *) token
							oldPwd :(NSString *)oldPwd
						   newPwd  :(NSString *)newPwd
		  completionSuccessHandler : (UpdatePwdSuccessBlock) completionHandler
			 completionFailHandler : (UpdatePwdFailBlock) completionFailHandler
				   completionError : (UpdatePwdErrorBlcok) completionError {
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:newPwd forKey:@"newPwd"];
	[body setValue:oldPwd forKey:@"oldPwd"];
	
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:KUpdatePwdBussinessUrl
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
