//
//  ProductRemoveListBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/16.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"


typedef void (^ProductRemoveListSuccessBlock)(BOOL succeed);
typedef void (^ProductRemoveListFailBlock) (NSString * failMessage);
typedef void (^ProductRemoveListErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取商品商品详情
 */
@interface ProductRemoveListBussiness : BaseBussiness




+ (void) requestProductRemoveListWithToken : (NSString * )token
                                goodsId : (NSString *)goodsId
               completionSuccessHandler : (ProductRemoveListSuccessBlock) completionHandler
                  completionFailHandler : (ProductRemoveListFailBlock) completionFailHandler
                        completionError : (ProductRemoveListErrorBlcok) completionError;
@end
