//
//  ExecuteAliPayBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ExecuteAliPayBussiness.h"
#import "WeChaPayModel.h"
@implementation ExecuteAliPayBussiness

+ (void) requestExecuteAliPayWithToken : (NSString* ) token
                                  price:(NSString *)totalPrice
                               orderNum:(NSString *)orderNum
			 completionSuccessHandler : (ExecuteAliPaySuccessBlock) completionHandler
				completionFailHandler : (ExecuteAliPayFailBlock) completionFailHandler
					  completionError : (ExecuteAliPayErrorBlcok) completionError;
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:token forKey:@"token"];
    [body setValue:orderNum forKey:@"orderNum"];
    [body setValue:totalPrice forKey:@"totalPrice"];
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kExecuteAliPayBussinessUrl
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


