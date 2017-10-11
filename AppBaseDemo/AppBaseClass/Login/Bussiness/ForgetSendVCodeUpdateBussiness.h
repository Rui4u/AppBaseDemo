//
//  SendVCodeUpdateBusiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/9.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"

typedef void (^SendVCodeUpdateSuccessBlock)(BOOL succeed);
typedef void (^SendVCodeUpdateFailBlock) (NSString * failMessage);
typedef void (^SendVCodeUpdateErrorBlcok)(NSString * netWorkErrorMessage);

/**
 验证码接口
 */
@interface ForgetSendVCodeUpdateBussiness : BaseBussiness
+ (void) requestStoreInfoWithPhoneNum : (NSString *) phoneNum
			 completionSuccessHandler : (SendVCodeUpdateSuccessBlock) completionHandler
				completionFailHandler : (SendVCodeUpdateFailBlock) completionFailHandler
					  completionError : (SendVCodeUpdateErrorBlcok) completionError;


@end

