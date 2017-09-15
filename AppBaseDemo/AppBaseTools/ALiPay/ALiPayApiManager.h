//
//  ALiPayApiManager.h
//  GPhoneFlowiOSClient
//
//  Created by sharui on 16/9/15.
//  Copyright © 2016年 ZhentaiNing. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ALiApiManagerDelegate <NSObject>

@optional

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

@interface ALiPayApiManager : NSObject
+(instancetype)sharedManager;
@property (nonatomic, weak) id<ALiApiManagerDelegate> delegate;


- (void)payStatus:(NSDictionary *)resultDic;

@end
