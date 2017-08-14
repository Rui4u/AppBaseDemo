//
//  GetAppProductListBusiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class GoodslistAllModel;
typedef void (^GetAppProductListSuccessBlock)(GoodslistAllModel * listArray);
typedef void (^GetAppProductListFailBlock) (NSString * failMessage);
typedef void (^GetAppProductListErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取全部商品
 */
@interface GetAppProductListBusiness : BaseBussiness




+ (void) requestGetAppProductListWithToken : (NSString * ) token
        completionSuccessHandler : (GetAppProductListSuccessBlock) completionHandler
           completionFailHandler : (GetAppProductListFailBlock) completionFailHandler
                 completionError : (GetAppProductListErrorBlcok) completionError;


@end
