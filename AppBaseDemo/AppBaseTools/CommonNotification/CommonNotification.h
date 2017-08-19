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
extern NSString * const LoginViewRootControllerBlock ;// 登录后登录控制器回调
extern NSString * const CNotificationShoppingCartNumberNotify ;// 购物车
extern NSString * const CNRefreashHomeData ;// 刷新首页
extern NSString * const CNReLoadeAllProductList ;// 刷新全部菜品
extern NSString * const CNReLoadeShoppingCart ;// 刷新购物车



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
