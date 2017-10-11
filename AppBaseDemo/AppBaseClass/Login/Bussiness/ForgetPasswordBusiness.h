//
//  ForgetPasswordBusiness.h
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing on 16/10/23.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "BaseBussiness.h"


typedef void (^ForgetPasswordSuccessBlock)(BOOL sucessFlag);
typedef void (^ForgetPasswordFailBlock) (NSString * failMessage);
typedef void (^ForgetPasswordErrorBlcok)(NSString * netWorkErrorMessage);

/**
 忘记密码接口
 */
@interface ForgetPasswordBusiness : BaseBussiness

+ (void) ForgetPasswordWithStoreTelephone : (NSString * ) storeTelephone
						   storePwd : (NSString * ) storePwd
						 verifyCode : (NSString * ) verifyCode
		   completionSuccessHandler : (ForgetPasswordSuccessBlock) completionHandler
			  completionFailHandler : (ForgetPasswordFailBlock) completionFailHandler
					completionError : (ForgetPasswordErrorBlcok) completionError;


@end

