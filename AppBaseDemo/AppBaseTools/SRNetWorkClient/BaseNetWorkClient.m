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
#import "NSObject+SBJson.h"
#import "DESEncryption.h"
@implementation BaseNetWorkClient
+ (void) jsonFormGetRequestWithUrl : (NSString  *)        url
							  param : (NSDictionary *)     param
							success : (void(^)(id))        success
				   operationFailure : (void(^)(NSString * ))  operationFailure
							failure : (void(^)(NSError *)) failure {

	AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];

	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html" , @"text/javascript", nil];
	

	NSString * paramString = [param JSONRepresentation];
	
	NSString * handlerDESEncryStr = [DESEncryption TripleDES:paramString
											encryptOrDecrypt:(CCAlgorithm)kCCEncrypt key:@"guoshuguoshu"];
	
	NSDictionary * dict = @{@"params":handlerDESEncryStr};
	[manager GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		success([responseObject objectForKey:@"body"]);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		failure(error);
	}];
}
@end
