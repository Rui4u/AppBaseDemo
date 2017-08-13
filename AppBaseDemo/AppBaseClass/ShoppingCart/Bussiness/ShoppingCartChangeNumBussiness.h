//
//  ShoppingCartChangeNumBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"

typedef void (^ShoppingCartChangeNumSuccessBlock)(NSString * succeed);
typedef void (^ShoppingCartChangeNumFailBlock) (NSString * failMessage);
typedef void (^ShoppingCartChangeNumErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取首页信息
 */
@interface ShoppingCartChangeNumBussiness : BaseBussiness




+ (void) requestShoppingCartChangeNumWithToken :(NSString *)token
                                       goodsId :(NSString *)goodsId
                                        specId :(NSString *)specId
                                           num :(NSString *)num
        completionSuccessHandler : (ShoppingCartChangeNumSuccessBlock) completionHandler
           completionFailHandler : (ShoppingCartChangeNumFailBlock) completionFailHandler
                 completionError : (ShoppingCartChangeNumErrorBlcok) completionError;
@end
