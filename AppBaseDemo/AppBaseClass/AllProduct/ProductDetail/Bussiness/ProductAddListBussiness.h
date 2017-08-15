//
//  ProductAddList.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//



#import "BaseBussiness.h"

typedef void (^ProductAddListSuccessBlock)(BOOL succeed);
typedef void (^ProductAddListFailBlock) (NSString * failMessage);
typedef void (^ProductAddListErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取商品商品详情
 */
@interface ProductAddListBussiness : BaseBussiness




+ (void) requestProductAddListWithToken : (NSString * )token
                               goodsId : (NSString *)goodsId
              completionSuccessHandler : (ProductAddListSuccessBlock) completionHandler
                 completionFailHandler : (ProductAddListFailBlock) completionFailHandler
                       completionError : (ProductAddListErrorBlcok) completionError;
@end
