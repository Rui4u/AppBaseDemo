//
//  QuestionBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "QuestionBussiness.h"

@implementation QuestionBussiness

+ (void) requestQuestionWithToken : (NSString* ) token
		  completionSuccessHandler : (QuestionSuccessBlock) completionHandler
			 completionFailHandler : (QuestionFailBlock) completionFailHandler
				   completionError : (QuestionErrorBlcok) completionError
{
	NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
	
	
	[BaseNetWorkClient jsonFormGetRequestWithUrl:kQuestionBussinessUrl
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

