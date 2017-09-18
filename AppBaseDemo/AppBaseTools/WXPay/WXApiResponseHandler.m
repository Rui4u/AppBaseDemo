//
//  WXApiResponseManager.m
//  SDKSample
//
//  Created by RKL on 2017/5/24.
//  Copyright © 2017年 RKL. All rights reserved.//
//

#import "WXApi.h"
#import "WXApiResponseHandler.h"

@implementation WXApiResponseHandler

//PayReq *request = [[[PayReq alloc] init] autorelease];
//request.partnerId = @"10000100";
//request.prepayId= @"1101000000140415649af9fc314aa427";
//request.package = @"Sign=WXPay";
//request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
//request.timeStamp= @"1397527777";
//request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
//[WXApi sendReq：request];


#pragma mark - Public Methods
+ (NSString *)jumpToWxPayWithData:(WeChaPayModel *)weChaPayModel
{
    if(weChaPayModel != nil)
    {
        NSString * status           = weChaPayModel.message;
        NSString * partnerId        = weChaPayModel.partnerid;
//        if ([status isEqualToString:@"OK"])
//        {
            NSString *stamp         = weChaPayModel.timestamp;
            //调起微信支付
            PayReq * req            = [[PayReq alloc] init];
            req.partnerId           = partnerId;
            req.prepayId            = weChaPayModel.prepayid;
            req.nonceStr            = weChaPayModel.noncestr;
            req.timeStamp           = [stamp intValue];
            req.package             = weChaPayModel.package;
            req.sign                = weChaPayModel.sign;
            [WXApi sendReq:req];
            return weChaPayModel.message;
//        }
//        else
//        {
//            return weChaPayModel.message;
//        }
    }
    else
    {
        return @"服务器返回错误，未获取到json对象";
    }
    
}
@end
