//
//  DoOrderBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "DoOrderBussiness.h"

@implementation DoOrderBussiness

+ (void) requestDoOrderWithToken : (NSString* ) token
						addressId: (NSString *) addressId
					   orederType: (NSString *)orederType
					 carImageInfo:(NSArray *)carImageInfo
		  completionSuccessHandler : (DoOrderSuccessBlock) completionHandler
			 completionFailHandler : (DoOrderFailBlock) completionFailHandler
				   completionError : (DoOrderErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:addressId forKey:@"addressId"];
	[body setValue:orederType forKey:@"orederType"];
	[body setValue:carImageInfo forKey:@"carImageInfo"];
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kDoOrderBussinessUrl
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
