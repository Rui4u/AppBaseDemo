//
//  CommonNotification.h
//  HZAgentiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/12/5.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const CNotificationLogOut;          //退出
extern NSString * const CNotificationLogInSucess;     //登录成功
extern NSString * const CNotificationGetMoreDataRefreshRootViewController; //请求更多接口在刷新tabber4个跟控制器
extern NSString * const CNotificationMoreDateRefreshRootVCWithBuy;//在购买情况下发送刷新more接口
extern NSString * const LoginViewRootControllerBlock ;// 登录后登录控制器回调
extern NSString * const CNotificationConfirmation   ;
extern NSString * const NotificationProductViewController   ;//产品中心刷新
extern NSString * const CNotificationUpdate ;//请求更新接口


/**
 公共通知类
 */
@interface CommonNotification : NSObject

/**
 发送通知

 @param notification <#notification description#>
 @param userInfo <#userInfo description#>
 @param object <#object description#>
 */
+ (void) postNotification:(NSString*)notification
                 userInfo:(NSDictionary*)userInfo
                   object:(id)object;

@end
