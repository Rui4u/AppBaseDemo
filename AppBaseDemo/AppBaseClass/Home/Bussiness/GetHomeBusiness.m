//
//  GetHomeBusiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "GetHomeBusiness.h"
#import "HomeDataModel.h"
@implementation GetHomeBusiness

+ (void) requestGetHomeWithToken : (NSString* ) token
            completionSuccessHandler : (GetHomeSuccessBlock) completionHandler
               completionFailHandler : (GetHomeFailBlock) completionFailHandler
                     completionError : (GetHomeErrorBlcok) completionError
{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:token forKey:@"token"];
    
    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:KHomeBussinessUrl
                                           param:body
                                         success:^(id success)
     {
         NSDictionary * responeMp = (NSDictionary * ) success ;
         HomeDataModel *result = [HomeDataModel mj_objectWithKeyValues:responeMp];

         
             completionHandler(result);//注册成功
         
         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
		 completionError([super netWorkFailWithErroe:error]);

     }];
}
@end
