//
//  WeChaPayModel.h
//  GPhoneFlowiOSClient
//
//  Created by RKL on 2017/5/24.
//  Copyright © 2017年 RKL. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  微信支付model
 */
@interface WeChaPayModel : NSObject

/**
 "timeStamp": "1495695385201",
 "msg": "OK",
 "package": "Sign=WXPay",
 "success": true,
 "sign": "518D5564F7CC567786356843B46C96E2",
 "prepayId": "wx20170525145634bf5ef9b3570971185285",
 "partnerId": "1349717401",
 "nonceStr": "q0IAPTASxv6DCQKB",
 "orgRetCode": "5C81B45378ED49EE989CB10001FF2E09"
 */
@property (nonatomic , copy )  NSString * timeStamp ;

@property (nonatomic , copy ) NSString * msg ;

@property (nonatomic , copy ) NSString * package ;

@property (nonatomic , copy ) NSString * success ;

@property (nonatomic , copy ) NSString * sign ;

@property (nonatomic , copy ) NSString * prepayId ;

@property (nonatomic , copy ) NSString * partnerId ;

@property (nonatomic , copy ) NSString * nonceStr ;

@property (nonatomic , copy ) NSString * orgRetCode ;

@end
