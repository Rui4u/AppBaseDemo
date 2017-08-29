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
 订单状态 0 待配货 1 待发货，2待收货，3已完成，4已取消  //外面传进来 全部+1  因为前面还有全部 全部是0
 */
@property (nonatomic ,strong) NSString * state;
@end
