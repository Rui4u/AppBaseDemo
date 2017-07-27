//
//  BaseNetWorkClient.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/27.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseNetWorkClient.h"
#import <AFHTTPSessionManager.h>
#import <AFNetworkReachabilityManager.h>

@implementation BaseNetWorkClient
+ (void) jsonFormPOSTRequestWithUrl : (NSString  *)        url
							  param : (NSDictionary *)     param
							success : (void(^)(id))        success
				   operationFailure : (void(^)(NSString * ))  operationFailure
							failure : (void(^)(NSError *)) failure {

	AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];

	
	[manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		success(responseObject);

	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		failure(error);
	}];
}
@end
