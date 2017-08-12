//
//  DispatchTimer.m
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 2016/11/7.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "DispatchTimer.h"

@implementation DispatchTimer


+ (instancetype)sharedDispathTimer{
    
    static id temp;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        temp = [[self alloc] init];
    });
    return temp;
}
@end
