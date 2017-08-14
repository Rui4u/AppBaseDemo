//
//  ProductDetailBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProductDetailBussiness.h"

@implementation ProductDetailBussiness

+ (void) requestProductDetailWithToken : (NSString* ) token
                               goodsId : (NSString *)goodsId
              completionSuccessHandler : (ProductDetailSuccessBlock) completionHandler
                 completionFailHandler : (ProductDetailFailBlock) completionFailHandler
                       completionError : (ProductDetailErrorBlcok) completionError
{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:token forKey:@"token"];
    [body setValue:goodsId forKey:@"goodsId"];
    
    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:kProductDetailBussinessUrl
                                           param:body
                                         success:^(id success)
     {
         NSDictionary * responeMp = (NSDictionary * ) success ;
         
         
//         completionHandler(result);
//
         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
         completionError([super netWorkFailWithErroe:error]);
         
     }];
}
@end
