//
//  ProductRemoveListBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/16.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProductRemoveListBussiness.h"

@implementation ProductRemoveListBussiness
+ (void) requestProductRemoveListWithToken : (NSString* ) token
                                goodsId : (NSString *)goodsId
               completionSuccessHandler : (ProductRemoveListSuccessBlock) completionHandler
                  completionFailHandler : (ProductRemoveListFailBlock) completionFailHandler
                        completionError : (ProductRemoveListErrorBlcok) completionError
{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:token forKey:@"token"];
    [body setValue:goodsId forKey:@"goodsId"];
    
    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:kProductRemoveListBussinessUrl
                                           param:body
                                         success:^(id success)
     {
         NSDictionary * responeMp = (NSDictionary * ) success ;
         
         
         if ([[responeMp objectForKey:@"isSucceed"] isEqualToString:@"yes"]) {
             completionHandler(YES);
         }else {
             completionHandler(NO);
         }
         
         
         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
         completionError([super netWorkFailWithErroe:error]);
         
     }];
}
@end
