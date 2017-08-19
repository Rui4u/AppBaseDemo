//
//  CommonNotification.m
//  HZAgentiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/12/5.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "CommonNotification.h"


NSString * const CNotificationLogOut = @"CNotificationLogOut";
NSString * const CNotificationLogInSucess = @"CNotificationLogInSucess";//登录成功
NSString * const LoginViewRootControllerBlock = @"LoginViewRootControllerBlock";  // 登录后登录控制器回调
NSString * const CNotificationShoppingCartNumberNotify = @"CNotificationShoppingCartNumberNotify";

NSString * const CNRefreashHomeData = @"CNRefreashHomeData";

NSString * const CNReLoadeAllProductList = @"CNReLoadeAllProductList";
NSString * const CNReLoadeShoppingCart = @"CNReLoadeShoppingCart";

@implementation CommonNotification


+ (void) postNotification:(NSString*)notification
                 userInfo:(NSDictionary*)userInfo
                   object:(id)object
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:object userInfo:userInfo];
    });

}
@end
