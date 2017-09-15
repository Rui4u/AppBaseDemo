//
//  ALiPayApiResponseHandler.m
//  GPhoneFlowiOSClient
//
//  Created by sharui on 16/9/15.
//  Copyright © 2016年 ZhentaiNing. All rights reserved.
//

#import "ALiPayApiResponseHandler.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation Product


@end

@implementation ALiPayApiResponseHandler
+ (void)jumpToALiPayWithData:(NSString *)dict {
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    
//    {
//        "_input_charset" = "utf-8";
//        body = "5G\U6d41\U91cf\U5e73\U53f0";
//        "it_b_pay" = 3m;
//        "notify_url" = "http://5g.pay.hiyogame.com/alipayNotify";
//        "out_trade_no" = 8a2ba8d5571e638701573bddece90073;
//        partner = 2088321029902222;
//        "payment_type" = 1;
//        "seller_id" = "admin@hiyobox.com";
//        service = "mobile.securitypay.pay";
//        sign = "CrXFEaX5noXjlW5haMhzmgyr34WBUKsIpV56B%2FxBrOEA6h3UfG6YOyErvtB8A8jb9GUzzrcCpaTqqM4jRwcnWOiNi4s1MeiFuVJl4W%2FWIXnhlDVub4np%2BZNH4vJXhs90mqHhSImkRD1BqllorB9Me%2FK1tLAnqhSaM6w1lSXP2Ws%3D";
//        "sign_type" = RSA;
//        subject = "5G\U6d41\U91cf\U5e73\U53f0";
//        "total_fee" = "2.67";
//    }
    
    
    
#warning 记得定义
//    Product *product = [[Product alloc] init];
//    product.price = [[dict objectForKey:@"total_fee"] floatValue];
//    product.subject = [dict objectForKey:@"subject"];
//    product.body = [dict objectForKey:@"body"];
//    product.orderId = [dict objectForKey:@"out_trade_no"];
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
//    NSString *partner = [dict objectForKey:@"partner"];
//    NSString *seller = [dict objectForKey:@"seller_id"];
//    #warning 记得获取私钥
//    NSString *privateKey = [dict objectForKey:@"sign"];
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
//    if ([partner length] == 0 ||
//        [seller length] == 0 ||
//        [privateKey length] == 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少partner或者seller或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.sellerID = seller;
//    order.outTradeNO =  product.orderId; //订单ID（由商家自行制定）
//    order.subject = product.subject; //商品标题
//    order.body = product.body; //商品描述
//    order.totalFee = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
//    order.notifyURL =  [dict objectForKey:@"notify_url"]; //回调URL
//    
//    order.service = [dict objectForKey:@"service"];
//    order.paymentType = [dict objectForKey:@"payment_type"];
//    order.inputCharset = [dict objectForKey:@"_input_charset"];
//    order.itBPay = [dict objectForKey:@"it_b_pay"];
//    order.showURL = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"GPhoneFlowiOSClient";
//
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
        [[AlipaySDK defaultService] payOrder:dict fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
//        }];
//    }
        }];
}

@end
