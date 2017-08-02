//
//  LoginViewRootController.h
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 2016/10/26.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 登录注册的根控制器
 */
@interface LoginViewRootController : UINavigationController

/**
 登录完成后回调
 */
@property (nonatomic ,copy ) void (^loginInBlock)(NSString *loginStatus);

@end
