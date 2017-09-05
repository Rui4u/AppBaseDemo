//
//  UpdatePwdBusiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/9.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"

typedef void (^UpdatePwdSuccessBlock)(BOOL succeed);
typedef void (^UpdatePwdFailBlock) (NSString * failMessage);
typedef void (^UpdatePwdErrorBlcok)(NSString * netWorkErrorMessage);

/**
 修改密码
 */
@interface UpdatePwdBussiness : BaseBussiness
+ (void) requestStoreInfoWithToken : (NSString *) token
							oldPwd :(NSString *)oldPwd
						   newPwd  :(NSString *)newPwd
		  completionSuccessHandler : (UpdatePwdSuccessBlock) completionHandler
			 completionFailHandler : (UpdatePwdFailBlock) completionFailHandler
				   completionError : (UpdatePwdErrorBlcok) completionError;


@end
