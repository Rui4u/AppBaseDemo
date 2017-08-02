//
//  CommonNotification.m
//  HZAgentiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/12/5.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "CommonNotification.h"

NSString * const CNotificationLogOut  = @"Notification_LogOut";
NSString * const CNotificationLogInSucess = @"Notification_LogIn";
NSString * const CNotificationGetMoreDataRefreshRootViewController = @"CNotificationGetMoreDataRefreshRootViewController";
NSString * const CNotificationMoreDateRefreshRootVCWithBuy = @"CNotificationMoreDateRefreshRootVCWithBuy";

NSString * const LoginViewRootControllerBlock = @"LoginViewRootControllerBlock";  // 登录后登录控制器回调
NSString * const CNotificationConfirmation = @"AlreadySubmitConfirmation"; //提交合格投资人
NSString * const NotificationProductViewController = @"NotificationProductViewController"; //产品中心刷新
NSString * const CNotificationUpdate = @"CNotificationUpdate" ;



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
