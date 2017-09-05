//
//  OrderDetailViewController.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/23.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderDetailViewController : BaseViewController
@property (nonatomic ,copy ) NSString * orderId;

@property (nonatomic ,copy ) void(^cancelBlock)();
@end
