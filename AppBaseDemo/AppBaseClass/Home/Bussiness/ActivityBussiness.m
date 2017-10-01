//
//  Activity.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ActivityBussiness.h"
#import "GetSelectedProductModel.h"
@implementation ActivityBussiness

+ (void) requestActivityWithToken:(NSString *)token
                       activityId:(NSString *)activityId
                      completionSuccessHandler : (ActivitySuccessBlock) completionHandler
                         completionFailHandler : (ActivityFailBlock) completionFailHandler
                               completionError : (ActivityErrorBlcok) completionError
{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:activityId forKey:@"activityId"];
    [body setValue:token forKey:@"token"];
    
    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:KactivityAPIBussinessUrl
                                           param:body
                                         success:^(id success)
     {
         NSDictionary * responeMp = (NSDictionary * ) success ;
         GetSelectedProductModel *result = [GetSelectedProductModel mj_objectWithKeyValues:responeMp];

         completionHandler(result);
         
         
         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
         completionError([super netWorkFailWithErroe:error]);
         
     }];
}
@end


