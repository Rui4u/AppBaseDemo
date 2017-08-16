//
//  ShoppingCartListBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class ShoppingCartListModel;


typedef void (^ShoppingCartListSuccessBlock)(ShoppingCartListModel * getSelectedProductModel);
typedef void (^ShoppingCartListFailBlock) (NSString * failMessage);
typedef void (^ShoppingCartListErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取购物车列表
 */
@interface ShoppingCartListBussiness : BaseBussiness

+ (void) requestShoppingCartListWithToken : (NSString* ) token
           completionSuccessHandler : (ShoppingCartListSuccessBlock) completionHandler
              completionFailHandler : (ShoppingCartListFailBlock) completionFailHandler
                    completionError : (ShoppingCartListErrorBlcok) completionError;


@end
