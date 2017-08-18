//
//  CountPriceBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "CountPriceBussiness.h"
#import "CountPriceModel.h"
@implementation CountPriceBussiness

+ (void) requestCountPriceWithToken : (NSString* ) token
							  status:(NSString *)status
						   goodsList:(NSArray *)goodsList
				 completionSuccessHandler : (CountPriceSuccessBlock) completionHandler
					completionFailHandler : (CountPriceFailBlock) completionFailHandler
						  completionError : (CountPriceErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:status forKey:@"status"];
	[body setValue:goodsList forKey:@"goodsList"];
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kCountPriceBussinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 
		 CountPriceModel * model = [CountPriceModel mj_objectWithKeyValues:responeMp];
		 
		 completionHandler(model);
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end
