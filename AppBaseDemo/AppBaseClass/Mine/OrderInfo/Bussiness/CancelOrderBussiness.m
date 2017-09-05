//
//  CancelOrderBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "CancelOrderBussiness.h"

@implementation CancelOrderBussiness

+ (void) requestCancelOrderWithToken : (NSString* ) token
						orderId: (NSString *) orderId
		completionSuccessHandler : (CancelOrderSuccessBlock) completionHandler
		   completionFailHandler : (CancelOrderFailBlock) completionFailHandler
				 completionError : (CancelOrderErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:orderId forKey:@"id"];
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kCancelOrderBussinessUrl
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
