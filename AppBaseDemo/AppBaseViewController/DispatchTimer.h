//
//  DispatchTimer.h
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 2016/11/7.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 定时器单利
 */
@interface DispatchTimer : NSObject

/**
 定时器timer
 */
@property (nonatomic ,strong ) dispatch_source_t timer;

+ (instancetype)sharedDispathTimer;

@end
