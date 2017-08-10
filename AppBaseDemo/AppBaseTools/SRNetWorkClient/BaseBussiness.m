//
//  BaseBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/10.
//  Copyright © 2017年 sharui. All rights reserved.
//
#import "BaseBussiness.h"

@implementation BaseBussiness

+ (NSString * ) netWorkFailWithErroe : (NSError * )error
{
	if (error)
	{
		if (error.code == 1001)//服务器链接异常,请稍后重试.
		{
			DDLog(@"服务器链接异常,请稍后重试.");
			
		}
		else if (error.code == 1010)//网络异常,请稍后重试。
		{
			DDLog(@"服务器链接异常,请稍后重试.");
			
		}
		
		NSString * errorMessage = @"网络异常,请稍后重试。";
		return errorMessage;
	}
	return nil;
}
+ (void) netWorkSucceed200WithDir : (NSDictionary * ) dir
					 succeedBlock : (netWorkSuccBlock) succeedBlock
{
	NSDictionary * responeMp = (NSDictionary * ) dir ;
	if ([[responeMp allKeys]containsObject:@"errorCode"])
	{
		if ([[responeMp objectForKey:@"errorCode"]isEqualToString:@"200"])
		{
			succeedBlock(YES);
		}
	}
	else
		succeedBlock(NO);
	//                                              @throw [NSErrorFailingURLStringKey]
	
	
}
@end
