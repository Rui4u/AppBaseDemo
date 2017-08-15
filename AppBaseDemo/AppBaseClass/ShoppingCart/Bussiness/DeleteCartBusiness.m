 //
//  GetDeleteCartBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "DeleteCartBusiness.h"

@implementation DeleteCartBusiness

+ (void) requestDeleteCartWithToken : (NSString* ) token
						   goodsList: (NSArray *)goodsList
				  completionSuccessHandler : (DeleteCartSuccessBlock) completionHandler
					 completionFailHandler : (DeleteCartFailBlock) completionFailHandler
						   completionError : (DeleteCartErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:goodsList forKey:@"goodsList"];
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kDleteCarBussinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 
		 NSLog(@"删除成功");
//		 completionHandler(result);DeleteCartBusinessDeleteCartBusiness
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end
