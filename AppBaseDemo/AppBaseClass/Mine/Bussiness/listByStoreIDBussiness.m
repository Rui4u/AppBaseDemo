//
//  listByStoreIDBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "listByStoreIDBussiness.h"

@implementation listByStoreIDBussiness

+ (void) requestlistByStoreIDWithToken : (NSString* ) token
		 completionSuccessHandler : (listByStoreIDSuccessBlock) completionHandler
			completionFailHandler : (listByStoreIDFailBlock) completionFailHandler
				  completionError : (listByStoreIDErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setObject:token forKey:@"token"];
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:klistByStoreIDBussinessUrl
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


