//
//  SaveAccountBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "SaveAccountBussiness.h"

@implementation SaveAccountBussiness

+ (void) requestSaveAccountWithToken : (NSString* ) token
							 trueName:(NSString *)trueName
							 telPhone:(NSString *)telPhone
			  completionSuccessHandler : (SaveAccountSuccessBlock) completionHandler
				 completionFailHandler : (SaveAccountFailBlock) completionFailHandler
					   completionError : (SaveAccountErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setObject:token forKey:@"token"];
	[body setObject:trueName forKey:@"trueName"];
	[body setObject:telPhone forKey:@"telPhone"];
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kSaveAccountBussinessUrl
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



