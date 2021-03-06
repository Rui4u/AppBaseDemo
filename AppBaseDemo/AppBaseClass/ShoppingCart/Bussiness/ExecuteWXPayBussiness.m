//
//  ExecuteWXPayBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ExecuteWXPayBussiness.h"
#import "WeChaPayModel.h"
@implementation ExecuteWXPayBussiness

+ (void) requestExecuteWXPayWithToken : (NSString* ) token
								 price:(NSString *)totalPrice
                              orderNum:(NSString *)orderNum
			 completionSuccessHandler : (ExecuteWXPaySuccessBlock) completionHandler
				completionFailHandler : (ExecuteWXPayFailBlock) completionFailHandler
					  completionError : (ExecuteWXPayErrorBlcok) completionError;
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:orderNum forKey:@"orderNum"];
    [body setValue:totalPrice forKey:@"totalPrice"];
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kExecuteWXPayBussinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 
		 WeChaPayModel * model = [WeChaPayModel mj_objectWithKeyValues:responeMp];
		 
		 completionHandler(model);
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end

