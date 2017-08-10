//
//  GetCityListBusiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "GetCityListBusiness.h"
#import "SelectCityModel.h"
@implementation GetCityListBusiness

+ (void) requestGetCityListWithToken : (NSString* ) token
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
         SelectCityModel *result = [SelectCityModel mj_objectWithKeyValues:responeMp];

         
             completionHandler(result);//注册成功
         
         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
		 completionError([super netWorkFailWithErroe:error]);

     }];
}
@end
