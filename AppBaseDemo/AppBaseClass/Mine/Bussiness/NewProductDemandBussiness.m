//
//  NewProductDemandBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "NewProductDemandBussiness.h"
#import "NewProductDemandModel.h"
@implementation NewProductDemandBussiness

+ (void) requestNewProductDemandWithToken : (NSString* ) token
				 completionSuccessHandler : (NewProductDemandSuccessBlock) completionHandler
					completionFailHandler : (NewProductDemandFailBlock) completionFailHandler
					completionError : (NewProductDemandErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kCommonToolsCategoryBussinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 
		 NewProductDemandModel * model = [NewProductDemandModel mj_objectWithKeyValues:responeMp];
		 
		 completionHandler(model);
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end
