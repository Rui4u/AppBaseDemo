//
//  LoginBusiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "LoginBusiness.h"
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
         
         if ([[success valueForKey:@"isFinish"] isEqualToString:@"1"]) {
             completionHandler (YES);
         }else {
         completionHandler (NO);
         }
         
         saveDataUserDefaultForValueKey([success valueForKey:@"token"] , @"token");
         saveDataUserDefaultForValueKey([success valueForKey:@"isFinish"] , @"isFinish");

         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
		 completionError([super netWorkFailWithErroe:error]);

     }];
}
@end
