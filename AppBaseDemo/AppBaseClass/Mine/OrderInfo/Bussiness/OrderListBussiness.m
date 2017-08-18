//
//  OrderListBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "OrderListBussiness.h"
#import "OrderListModel.h"
@implementation OrderListBussiness

+ (void) requestOrderListWithToken : (NSString* ) token
							  state:(NSString *)state
				 completionSuccessHandler : (OrderListSuccessBlock) completionHandler
					completionFailHandler : (OrderListFailBlock) completionFailHandler
					completionError : (OrderListErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:state forKey:@"state"];
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kOrderListBussinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 
		 OrderListModel * model = [OrderListModel mj_objectWithKeyValues:responeMp];
		 
		 completionHandler(model);
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end
