//
//  OrderDetailBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "OrderDetailBussiness.h"
#import "OrderDetailModel.h"
@implementation OrderDetailBussiness

+ (void) requestOrderDetailWithToken : (NSString* ) token
							  State:(NSString *)State
		  completionSuccessHandler : (OrderDetailSuccessBlock) completionHandler
			 completionFailHandler : (OrderDetailFailBlock) completionFailHandler
				   completionError : (OrderDetailErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:State forKey:@"State"];
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kOrderDetailBussinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 
		 OrderDetailModel * model = [OrderDetailModel mj_objectWithKeyValues:responeMp];
		 
		 completionHandler(model);
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end
