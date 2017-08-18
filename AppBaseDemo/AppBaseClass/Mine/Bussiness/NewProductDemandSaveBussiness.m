//
//  NewProductDemandSaveBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "NewProductDemandSaveBussiness.h"
@implementation NewProductDemandSaveBussiness

+ (void) requestNewProductDemandSaveWithToken : (NSString* ) token
				 completionSuccessHandler : (NewProductDemandSaveSuccessBlock) completionHandler
					completionFailHandler : (NewProductDemandSaveFailBlock) completionFailHandler
						  completionError : (NewProductDemandSaveErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kQuickFeedbackBussinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 		 
		 completionHandler(YES);
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end
