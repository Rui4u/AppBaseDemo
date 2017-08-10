//
//  GetHomeBusiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class HomeDataModel;
typedef void (^GetHomeSuccessBlock)(HomeDataModel * listArray);
typedef void (^GetHomeFailBlock) (NSString * failMessage);
typedef void (^GetHomeErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取首页信息
 */
@interface GetHomeBusiness : BaseBussiness




+ (void) requestGetHomeWithToken : (NSString * ) token
        completionSuccessHandler : (GetHomeSuccessBlock) completionHandler
           completionFailHandler : (GetHomeFailBlock) completionFailHandler
                 completionError : (GetHomeErrorBlcok) completionError;


@end
