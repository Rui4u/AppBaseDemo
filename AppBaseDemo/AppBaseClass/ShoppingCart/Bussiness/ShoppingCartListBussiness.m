//
//  ShoppingCartListBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ShoppingCartListBussiness.h"
#import "ShoppingCartListModel.h"
@implementation ShoppingCartListBussiness

+ (void) requestShoppingCartListWithToken : (NSString* ) token
           completionSuccessHandler : (ShoppingCartListSuccessBlock) completionHandler
              completionFailHandler : (ShoppingCartListFailBlock) completionFailHandler
                    completionError : (ShoppingCartListErrorBlcok) completionError
{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:token forKey:@"token"];
    
    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:kShopCarListBussinessUrl
                                           param:body
                                         success:^(id success)
     {
         NSDictionary * responeMp = (NSDictionary * ) success ;
         
         ShoppingCartListModel * model = [ShoppingCartListModel mj_objectWithKeyValues:responeMp];

         completionHandler(model);
         
         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
         completionError([super netWorkFailWithErroe:error]);
         
     }];
}
@end
