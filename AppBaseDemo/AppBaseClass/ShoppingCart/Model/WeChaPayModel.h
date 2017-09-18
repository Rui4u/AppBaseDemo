//
//  WeChaPayModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/9/18.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChaPayModel : NSObject
/**
 *  "code": "SUCCESS",
 "message": "微信服务创建支付任务成功",
 "appId": "wx794d7bdef400e5b2",
 "partnerId": "1354034002",
 "prepayId": "wx20160827174455fd136739f10292972899",
 "exPackage": "Sign=WXPay",
 "nonceStr": "daca41214b39c5dc66674d09081940f0",
 "timestamp": "1472291107",
 "sign": "06C32DE17FB0B2355938F49FCDA8CDFC"
 */
@property (nonatomic , copy )  NSString * code ;

@property (nonatomic , copy ) NSString * message ;

@property (nonatomic , copy ) NSString * appid ;

@property (nonatomic , copy ) NSString * partnerid ;

@property (nonatomic , copy ) NSString * prepayid ;

@property (nonatomic , copy ) NSString * package ;

@property (nonatomic , copy ) NSString * noncestr ;

@property (nonatomic , copy ) NSString * timestamp ;

@property (nonatomic , copy ) NSString * sign ;

@end
