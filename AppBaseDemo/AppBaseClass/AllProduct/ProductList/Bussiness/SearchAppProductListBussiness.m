//
//  SearchAppProductListBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//


#import "SearchAppProductListBussiness.h"
#import "GetSelectedProductModel.h"

@implementation SearchAppProductListBussiness

+ (void) requestSearchAppProductListWithToken : (NSString* ) token
									  goodName:(NSString *)goodName
					completionSuccessHandler : (SearchAppProductListSuccessBlock) completionHandler
					  completionFailHandler : (SearchAppProductListFailBlock) completionFailHandler
							completionError : (SearchAppProductListErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:goodName forKey:@"goodName"];
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kSearchGoodsListlBussinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 GetSelectedProductModel *result = [GetSelectedProductModel mj_objectWithKeyValues:responeMp];
		 
		 
		 completionHandler(result);
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end
