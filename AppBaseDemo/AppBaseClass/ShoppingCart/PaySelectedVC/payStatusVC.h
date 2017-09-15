//
//  payStatusVC.h
//  GPhoneFlowiOSClient
//
//  Created by Livia on 16/9/12.
//  Copyright © 2016年 ZhentaiNing. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, PayStatus) {
    payStatusSuccessd,
    payStatusFail,
    payStatusCancel
};
@interface payStatusVC : BaseViewController
@property (nonatomic ,assign)PayStatus payStatus;
@end
