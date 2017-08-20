//
//  FillOrderBussiness.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "FillOrderBussiness.h"
#import "FillOrderModel.h"
@implementation FillOrderBussiness

+ (void) requestFillOrderWithToken : (NSString* ) token
                          goodsList:(NSArray *)goodsList
          completionSuccessHandler : (FillOrderSuccessBlock) completionHandler
               completionFailHandler : (FillOrderFailBlock) completionFailHandler
                     completionError : (FillOrderErrorBlcok) completionError
{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:token forKey:@"token"];
    [body setValue:goodsList forKey:@"goodsList"];
    
    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:kFillOrderBussinessUrl
                                           param:body
                                         success:^(id success)
     {
         NSDictionary * responeMp = (NSDictionary * ) success ;
         
         FillOrderModel * model = [FillOrderModel mj_objectWithKeyValues:responeMp];
         
         completionHandler(model);
         
         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
         completionError([super netWorkFailWithErroe:error]);
         
     }];
}
@end
