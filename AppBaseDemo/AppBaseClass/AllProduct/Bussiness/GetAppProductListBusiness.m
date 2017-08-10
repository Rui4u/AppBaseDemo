//
//  GetAppProductListBusiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "GetAppProductListBusiness.h"
#import "HomeDataModel.h"
@implementation GetAppProductListBusiness

+ (void) requestGetAppProductListWithToken : (NSString* ) token
            completionSuccessHandler : (GetAppProductListSuccessBlock) completionHandler
               completionFailHandler : (GetAppProductListFailBlock) completionFailHandler
                     completionError : (GetAppProductListErrorBlcok) completionError
{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:token forKey:@"token"];
    
    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:KGoodslistAllBussinessUrl
                                           param:body
                                         success:^(id success)
     {
         NSDictionary * responeMp = (NSDictionary * ) success ;
         HomeDataModel *result = [HomeDataModel mj_objectWithKeyValues:responeMp];

         
             completionHandler(result);
         
         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
		 completionError([super netWorkFailWithErroe:error]);

     }];
}
@end
