//
//  CheackVersion.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
typedef void (^CheackVersionSuccessBlock)(NSDictionary * upadataInfo);
typedef void (^CheackVersionFailBlock) (NSString * failMessage);
typedef void (^CheackVersionErrorBlcok)(NSString * netWorkErrorMessage);

/**
 获取首页信息
 */
@interface CheackVersionBussiness : BaseBussiness




+ (void) requestCheackVersionWithVersionMumber: (NSString * ) versionMumber   
        completionSuccessHandler : (CheackVersionSuccessBlock) completionHandler
           completionFailHandler : (CheackVersionFailBlock) completionFailHandler
                 completionError : (CheackVersionErrorBlcok) completionError;


@end

