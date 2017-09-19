//
//  GetSelectGoodsListBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//


#import "GetSelectGoodsListBussiness.h"
#import "GetSelectedProductModel.h"

@implementation GetSelectGoodsListBussiness

+ (void) requestGetSelectGoodsListWithToken : (NSString* ) token
								   parented : (NSString *)parented
							  categoryIdTwo : (NSString *)categoryIdTwo
				  completionSuccessHandler : (GetSelectGoodsListSuccessBlock) completionHandler
					 completionFailHandler : (GetSelectGoodsListFailBlock) completionFailHandler
						   completionError : (GetSelectGoodsListErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:parented forKey:@"parentId"];
	[body setValue:categoryIdTwo forKey:@"categoryIdTwo"];
	[body setValue:CITYCODE forKey:@"cityCode"];
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kSelectGoodsListlBussinessUrl
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
