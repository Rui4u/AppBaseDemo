//
//  GetCityListBusiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "GetCityListBusiness.h"

@implementation GetCityListBusiness

+ (void) requestGetCityListWithToken : (NSString * ) token
            completionSuccessHandler : (GetCityListSuccessBlock) completionHandler
               completionFailHandler : (GetCityListFailBlock) completionFailHandler
                     completionError : (GetCityListErrorBlcok) completionError
{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:token forKey:@"token"];
    
    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:kCityListBusinessUrl
                                           param:body
                                         success:^(id success)
     {
         NSDictionary * responeMp = (NSDictionary * ) success ;
         
         
             completionHandler(responeMp);//注册成功
         
         
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
