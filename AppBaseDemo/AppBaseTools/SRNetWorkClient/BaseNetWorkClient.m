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
#import "LoginViewRootController.h"
#import "BaseViewController.h"
@implementation BaseNetWorkClient
+ (void) jsonFormGetRequestWithUrl : (NSString  *)        url
							  param : (NSDictionary *)     param
							success : (void(^)(id))        success
				   operationFailure : (void(^)(NSString * ))  operationFailure
							failure : (void(^)(NSError *)) failure {

    
//    if ([param objectForKey:@"token"] == nil ||[[param objectForKey:@"token"] isEqualToString:@""]) {
//        
//    	[ [self getCurrentVC] presentViewController:[[LoginViewRootController alloc ]init] animated:YES completion:nil];
//        return;
//    }
	AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];

	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html" , @"text/javascript", nil];
	

	NSString * paramString = [param JSONRepresentation];
	
	NSString * handlerDESEncryStr = [DESEncryption TripleDES:paramString
											encryptOrDecrypt:(CCAlgorithm)kCCEncrypt key:@"scguoshu"];

    id classVC =   [self getCurrentVC];
    
    if ([classVC isKindOfClass:[BaseViewController class]]) {
        [((BaseViewController *)classVC) showHUD];
    }
	
	NSDictionary * dict = @{@"params":handlerDESEncryStr};
	[manager GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if ([classVC isKindOfClass:[BaseViewController class]]) {
            [((BaseViewController *)classVC) dismissHUD];
        }
 
        [BaseNetWorkClient  handlerRequest:(NSDictionary *)responseObject
                                  succerss:success
                          operationFailure:operationFailure
                                   failure:failure
                                       url:url];
        
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([classVC isKindOfClass:[BaseViewController class]]) {
            [((BaseViewController *)classVC) dismissHUD];
        }
		failure(error);
	}];
}
+ (void) handlerRequest : (id)                     resquest
                       succerss : (void (^)(id JSON))      handlerSuccess
               operationFailure : (void (^)(id JSON))      handlerException
                        failure : (void (^)(NSError * err)) handlerFailure
                            url : (NSString * ) url {

    if ( [[[resquest valueForKey:@"header"]valueForKey:@"errorCode"] isEqualToString:@"200"]) {
        
        BLOCK_SAFE_RUN(handlerSuccess ,[resquest objectForKey:@"body"]);

    }
	else if ( [[[resquest valueForKey:@"header"]valueForKey:@"errorCode"] isEqualToString:@"-4"]) {
		clearUserDefaults();

		BLOCK_SAFE_RUN(handlerException,[[resquest valueForKey:@"header"] valueForKey:@"errorMsg"]);
        
        [BaseViewController showToastWithMessage:[[resquest valueForKey:@"header"] valueForKey:@"errorMsg"] showTime:1];
		//token失效跳转登录界面
		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[LoginViewRootController alloc ]init] animated:YES completion:nil];

	}


}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isEqual:APP_DELEGATE.rootViewController]) {
        // 根视图为UITabBarController
        
        RootViewController *rootVC1 = (RootViewController *)rootVC;
        currentVC = [self getCurrentVCFrom:rootVC1.mainTabBar.selectedViewController];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

@end
