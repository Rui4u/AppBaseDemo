//
//  OrderListViewController.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/18.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderListViewController : BaseViewController
/**
 1代发货  2代付款 3 已完成 空 全部
 */
@property (nonatomic ,strong) NSString * state;
@end
