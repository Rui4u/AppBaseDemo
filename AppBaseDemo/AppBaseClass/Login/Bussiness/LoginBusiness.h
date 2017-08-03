//
//  LoginBusiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"


typedef void (^LoginBusinessSuccessBlock)(BOOL sucessFlag);
typedef void (^LoginBusinessFailBlock) (NSString * failMessage);
typedef void (^LoginBusinessErrorBlcok)(NSString * netWorkErrorMessage);

/**
 注册接口
 */
@interface LoginBusiness : NSObject


/**
 依据userName、verificationCode、passWord完成用户注册
 
 @param userName              用户名
 @param verificationCode      验证码
 @param passWord              用户密码
 @param isSubmitCommitment    是否勾选承诺书
 @param completionHandler     <#completionHandler description#>
 @param completionFailHandler <#completionFailHandler description#>
 @param completionError       <#completionError description#>
 */


+ (void) loginWithStoreTelephone : (NSString * ) storeTelephone
                           storePwd : (NSString * ) storePwd
           completionSuccessHandler : (LoginBusinessSuccessBlock) completionHandler
              completionFailHandler : (LoginBusinessFailBlock) completionFailHandler
                    completionError : (LoginBusinessErrorBlcok) completionError;


@end
