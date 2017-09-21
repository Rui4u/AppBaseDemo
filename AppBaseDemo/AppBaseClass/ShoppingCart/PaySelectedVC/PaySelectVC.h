//
//  PaySelectVC.h
//  GPhoneFlowiOSClient
//
//  Created by RKL on 16/9/15.
//  Copyright © 2016年 ZhentaiNing. All rights reserved.
//

#import "BaseViewController.h"
/**
 *  选择支付方式  支付宝&微信
 */
@interface PaySelectVC : BaseViewController
@property (nonatomic ,copy) NSString * orderNumber;
/**
 <#Description#>
 */
@property (nonatomic ,copy ) NSString * orderIdNumber;
@property (nonatomic ,copy) NSString * totolPrice;

@end
