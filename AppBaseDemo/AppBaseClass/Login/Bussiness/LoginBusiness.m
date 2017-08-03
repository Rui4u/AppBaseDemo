//
//  LoginBusiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "LoginBusiness.h"
#import "BaseNetWorkClient.h"
@implementation LoginBusiness
+ (void) loginWithStoreTelephone : (NSString * ) storeTelephone
                           storePwd : (NSString * ) storePwd
            completionSuccessHandler:(LoginBusinessSuccessBlock)completionHandler
               completionFailHandler:(LoginBusinessFailBlock)completionFailHandler
                     completionError:(LoginBusinessErrorBlcok)completionError
{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:storePwd forKey:@"storePwd"];
    [body setValue:storeTelephone forKey:@"storeTelephone"];
    [body setValue:[[NSUUID UUID] UUIDString] forKey:@"uuid"];

    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:kLoginBusinessUrl
                                           param:body
                                         success:^(id success)
     {
         NSDictionary * responeMp = (NSDictionary * ) success ;
         
         
         saveDataUserDefaultForValueKey([responeMp objectForKey:@"toekn"] , @"token");
         completionHandler (YES);
         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
         if (error)
         {
             if (error.code == 1001)//服务器链接异常,请稍后重试.
             {
                 if (error.domain)
                 {
                     completionError([error.domain copy]);
                 }
             }
             else if (error.code == 1010)//网络异常,请稍后重试。
             {
                 if (error.domain)
                 {
                     completionError([error.domain copy]);
                 }
             }
             else
             {
                 NSString * errorMessage = @"网络异常,请稍后重试。";
                 completionError(errorMessage);
             }
         }
     }];
}
@end
