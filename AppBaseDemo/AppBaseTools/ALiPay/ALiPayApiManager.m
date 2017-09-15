//
//  ALiPayApiManager.m
//  GPhoneFlowiOSClient
//
//  Created by sharui on 16/9/15.
//  Copyright © 2016年 ZhentaiNing. All rights reserved.
//

#import "ALiPayApiManager.h"

@implementation ALiPayApiManager
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static ALiPayApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ALiPayApiManager alloc] init];
    });
    return instance;
}
- (void)payStatus:(NSDictionary *)resultDic {
    
    
    
    switch ([[resultDic objectForKey:@"resultStatus"] integerValue]) {
            
//            9000 订单支付成功
//            8000 正在处理中
//            4000 订单支付失败
//            6001 用户中途取消
//            6002 网络连接出错
           //成功
        case 9000 :
        {
            [self.delegate paySuccessd];
        }
            break;
            //失败
        case 4000:
        {
            [self.delegate payFail];
        }
            break;
            //取消
        case 6001:
        {
            [self.delegate payCancel];
        }
            break;
            
        default:
            break;
    }
    
    

}
@end
