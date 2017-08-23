//
//  VerifyCodeTelUpdateBusiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/9.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"

typedef void (^VerifyCodeTelUpdateSuccessBlock)(BOOL succeed);
typedef void (^VerifyCodeTelUpdateFailBlock) (NSString * failMessage);
typedef void (^VerifyCodeTelUpdateErrorBlcok)(NSString * netWorkErrorMessage);

/**
 验证码接口
 */
@interface VerifyCodeTelUpdateBussiness : BaseBussiness
+ (void) requestStoreInfoWithPhoneNum : (NSString *) phoneNum
		  completionSuccessHandler : (VerifyCodeTelUpdateSuccessBlock) completionHandler
			 completionFailHandler : (VerifyCodeTelUpdateFailBlock) completionFailHandler
				   completionError : (VerifyCodeTelUpdateErrorBlcok) completionError;


@end
