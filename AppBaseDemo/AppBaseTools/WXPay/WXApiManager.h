//
//  WXApiManager.h
//  SDKSample
//
//  Created by RKL on 2017/5/24.
//  Copyright © 2017年 RKL. All rights reserved.//
//

#import <Foundation/Foundation.h>
#import "WXApiObject.h"
#import "WXApi.h"

@protocol WXApiManagerDelegate <NSObject>

@optional

- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;

/**
 *  支付成功
 */
- (void)paySuccessd;

/**
 *  支付失败
 */
- (void)payFail;
/**
 *  支付取消
 */
- (void)payCancel;

@end

@interface WXApiManager : NSObject<WXApiDelegate>

@property (nonatomic, weak) id<WXApiManagerDelegate> delegate;

+ (instancetype)sharedManager;

@end
