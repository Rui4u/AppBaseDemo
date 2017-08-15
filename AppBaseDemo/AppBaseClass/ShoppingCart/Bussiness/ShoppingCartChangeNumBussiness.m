//
//  ShoppingCartChangeNumBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ShoppingCartChangeNumBussiness.h"

@implementation ShoppingCartChangeNumBussiness


+ (void) requestShoppingCartChangeNumWithToken :(NSString *)token
                                       goodsId :(NSString *)goodsId
                                        specId :(NSString *)specId
                                           num :(NSString *)num
                    completionSuccessHandler:(ShoppingCartChangeNumSuccessBlock)completionHandler
                       completionFailHandler:(ShoppingCartChangeNumFailBlock)completionFailHandler
                             completionError:(ShoppingCartChangeNumErrorBlcok)completionError



{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:token forKey:@"token"];
    [body setValue:goodsId forKey:@"goodsId"];
    [body setValue:specId forKey:@"specId"];
    [body setValue:num forKey:@"num"];
    
    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:kAddCarBussinessUrl
                                           param:body
                                         success:^(id success)
     {
         NSDictionary * responeMp = (NSDictionary * ) success ;
         
		 NSLog(@"改变成功");
         completionHandler(@"1");
         
         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
         completionError([super netWorkFailWithErroe:error]);
         
     }];

}
@end
