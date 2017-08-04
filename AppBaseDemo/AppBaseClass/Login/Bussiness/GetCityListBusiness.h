//
//  GetCityListBusiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class SelectCityModel;
typedef void (^GetCityListSuccessBlock)(SelectCityModel * listArray);
typedef void (^GetCityListFailBlock) (NSString * failMessage);
typedef void (^GetCityListErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取开通城市列表
 */
@interface GetCityListBusiness : BaseNetWorkClient




+ (void) requestGetCityListWithToken : (NSString * ) token
        completionSuccessHandler : (GetCityListSuccessBlock) completionHandler
           completionFailHandler : (GetCityListFailBlock) completionFailHandler
                 completionError : (GetCityListErrorBlcok) completionError;


@end
