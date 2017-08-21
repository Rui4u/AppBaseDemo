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
									 goodsName:(NSString *)goodsName
							   goodsCategoryId:(NSString *)goodsCategoryId
									 goodsSpec:(NSString *)goodsSpec
									   upplier:(NSString *)upplier
										 price:(NSString *)price
									 telephone:(NSString *)telephone
										remark:(NSString *)remark
				 completionSuccessHandler : (NewProductDemandSaveSuccessBlock) completionHandler
					completionFailHandler : (NewProductDemandSaveFailBlock) completionFailHandler
						  completionError : (NewProductDemandSaveErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:goodsCategoryId forKey:@"goodsCategoryId"];
	[body setValue:goodsName forKey:@"goodsName"];
	[body setValue:goodsSpec forKey:@"goodsSpec"];
	[body setValue:upplier forKey:@"upplier"];
	[body setValue:telephone forKey:@"telephone"];
	[body setValue:price forKey:@"price"];
	[body setValue:remark forKey:@"remark"];
	
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
