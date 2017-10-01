//
//  Activity.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
#import "GetSelectedProductModel.h"

typedef void (^ActivitySuccessBlock)(GetSelectedProductModel * model);
typedef void (^ActivityFailBlock) (NSString * failMessage);
typedef void (^ActivityErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取首页活动信息
 */
@interface ActivityBussiness : BaseBussiness




+ (void) requestActivityWithToken:(NSString *)token
                       activityId:(NSString *)activityId
        completionSuccessHandler : (ActivitySuccessBlock) completionHandler
           completionFailHandler : (ActivityFailBlock) completionFailHandler
                 completionError : (ActivityErrorBlcok) completionError;


@end


