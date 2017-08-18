//
//  MyInvoiceBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "MyInvoiceBussiness.h"

@implementation MyInvoiceBussiness

+ (void) requestMyInvoiceWithToken : (NSString* ) token
							   type:(NSString *)type
							  start:(NSString *)start
						 taxpayerId:(NSString *)taxpayerId
						  regAddres:(NSString *)regAddres
						   regPhone:(NSString *)regPhone
						   telphone:(NSString *)telphone
							account:(NSString *)account
							addTime:(NSString *)addTime
						  startTime:(NSString *)startTime
							   mail:(NSString *)mail
		  completionSuccessHandler : (MyInvoiceSuccessBlock) completionHandler
			 completionFailHandler : (MyInvoiceFailBlock) completionFailHandler
				   completionError : (MyInvoiceErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	[body setValue:token forKey:@"token"];
	[body setValue:type forKey:@"type"];
	[body setValue:start forKey:@"start"];
	[body setValue:taxpayerId forKey:@"taxpayerId"];
	[body setValue:regAddres forKey:@"regAddres"];
	[body setValue:regPhone forKey:@"regPhone"];
	[body setValue:telphone forKey:@"telphone"];
	[body setValue:account forKey:@"account"];
	[body setValue:addTime forKey:@"addTime"];
	[body setValue:startTime forKey:@"startTime"];
	[body setValue:mail forKey:@"mail"];
	

	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kCommonToolsInvoiceBussinessUrl
										   param:body
										 success:^(id success)
	 {
		 NSDictionary * responeMp = (NSDictionary * ) success ;
		 
		 NSLog(@"删除成功");
		 completionHandler(YES);
		 
		 
	 } operationFailure:^(id failure) {
		 
		 completionFailHandler(failure);
		 
	 } failure:^(NSError * error)
	 {
		 completionError([super netWorkFailWithErroe:error]);
		 
	 }];
}
@end
