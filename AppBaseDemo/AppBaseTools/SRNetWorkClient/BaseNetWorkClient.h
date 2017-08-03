//
//  BaseNetWorkClient.h
//  AppBaseDemo
//
//  Created by sharui on 2017/7/27.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetWorkClient : NSObject
+ (void) jsonFormGetRequestWithUrl : (NSString  *)        url
							  param : (NSDictionary *)     param
							success : (void(^)(id))        success
				   operationFailure : (void(^)(NSString * ))  operationFailure
							failure : (void(^)(NSError *)) failure;

#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil;
@end
