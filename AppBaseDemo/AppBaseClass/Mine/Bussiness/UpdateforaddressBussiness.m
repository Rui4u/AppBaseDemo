//
//  UpdateforaddressBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "UpdateforaddressBussiness.h"

@implementation UpdateforaddressBussiness

+ (void) requestUpdateforaddressWithToken : (NSString* ) token
							 addressId:(NSString *)addressId
			completionSuccessHandler : (UpdateforaddressSuccessBlock) completionHandler
			   completionFailHandler : (UpdateforaddressFailBlock) completionFailHandler
					 completionError : (UpdateforaddressErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setObject:token forKey:@"token"];
	[body setObject:addressId forKey:@"addressId"];
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kUpdateforaddressBussinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 
		 
		 completionHandler(responeMp);
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end




