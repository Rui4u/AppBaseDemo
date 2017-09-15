//
//  WXApiManager.m
//  SDKSample
//
//  Created by RKL on 2017/5/24.
//  Copyright © 2017年 RKL. All rights reserved.//
//

#import "WXApiManager.h"

@implementation WXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp
{
    
    PayResp *payResp =(PayResp *)resp;
    
    switch (payResp.errCode)
    {
        case WXSuccess://支付成功
        {
            [self.delegate paySuccessd];
        }
            break;
            
        case WXErrCodeUserCancel://用户取消
        {
            [self.delegate payCancel];
            
        }
            break;
            
        case WXErrCodeCommon:
        case WXErrCodeSentFail:
        case WXErrCodeAuthDeny:
        case WXErrCodeUnsupport:  //失败
        {
            [self.delegate payFail];
            
        }            break;
        default:
            break;
    }
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvMessageResponse:)])
        {
            SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
            [_delegate managerDidRecvMessageResponse:messageResp];
        }
    }
    else if ([resp isKindOfClass:[SendAuthResp class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)])
        {
            SendAuthResp *authResp = (SendAuthResp *)resp;
            [_delegate managerDidRecvAuthResponse:authResp];
        }
    }
    else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAddCardResponse:)])
        {
            AddCardToWXCardPackageResp *addCardResp = (AddCardToWXCardPackageResp *)resp;
            [_delegate managerDidRecvAddCardResponse:addCardResp];
        }
    }
}

- (void)onReq:(BaseReq *)req
{
    if ([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvGetMessageReq:)])
        {
            GetMessageFromWXReq *getMessageReq = (GetMessageFromWXReq *)req;
            [_delegate managerDidRecvGetMessageReq:getMessageReq];
        }
    }
    else if ([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageReq:)])
        {
            ShowMessageFromWXReq *showMessageReq = (ShowMessageFromWXReq *)req;
            [_delegate managerDidRecvShowMessageReq:showMessageReq];
        }
    }
    else if ([req isKindOfClass:[LaunchFromWXReq class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvLaunchFromWXReq:)])
        {
            LaunchFromWXReq *launchReq = (LaunchFromWXReq *)req;
            [_delegate managerDidRecvLaunchFromWXReq:launchReq];
        }
    }
}

@end
