//
//  ProductAddList.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProductAddListBussiness.h"

@implementation ProductAddListBussiness

+ (void) requestProductAddListWithToken : (NSString* ) token
                               goodsId : (NSString *)goodsId
              completionSuccessHandler : (ProductAddListSuccessBlock) completionHandler
                 completionFailHandler : (ProductAddListFailBlock) completionFailHandler
                       completionError : (ProductAddListErrorBlcok) completionError
{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:token forKey:@"token"];
    [body setValue:goodsId forKey:@"goodsId"];
    
    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:kProductAddListBussinessUrl
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
