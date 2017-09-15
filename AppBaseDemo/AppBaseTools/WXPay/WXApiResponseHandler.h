//
//  WXApiResponseManager.h
//  SDKSample
//
//  Created by RKL on 2017/5/24.
//  Copyright © 2017年 RKL. All rights reserved.//
//

#import <Foundation/Foundation.h>
#import "WXApiObject.h"
#import "WeChaPayModel.h"

@interface WXApiResponseHandler : NSObject

/**
 *  跳转微信支付
 *
 *  @param data 数据
 *
 *  @return <#return value description#>
 */
+ (NSString *)jumpToWxPayWithData:(WeChaPayModel *)weChaPayModel;

@end
