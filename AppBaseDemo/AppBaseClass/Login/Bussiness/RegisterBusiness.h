//
//  RegisterBusiness.h
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing on 16/10/23.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "BaseBussiness.h"


typedef void (^RegisterSuccessBlock)(BOOL sucessFlag);
typedef void (^RegisterFailBlock) (NSString * failMessage);
typedef void (^RegisterErrorBlcok)(NSString * netWorkErrorMessage);

/**
 注册接口
 */
@interface RegisterBusiness : BaseBussiness


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


+ (void) registerWithStoreTelephone : (NSString * ) storeTelephone
						   storePwd : (NSString * ) storePwd
						   phoneNum : (NSString * ) phoneNum
     completionSuccessHandler : (RegisterSuccessBlock) completionHandler
			  completionFailHandler : (RegisterFailBlock) completionFailHandler
					completionError : (RegisterErrorBlcok) completionError;


@end
