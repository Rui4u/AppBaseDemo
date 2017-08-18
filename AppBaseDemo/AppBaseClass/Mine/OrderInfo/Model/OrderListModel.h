//
//  OrderListModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/18.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GoodsSpec :NSObject
@property (nonatomic , copy) NSString              * goodsSpec;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * totalWeight;

@end

@interface OrderGoods :NSObject
@property (nonatomic , copy) NSString              * totalWeight;
@property (nonatomic , strong) NSArray<GoodsSpec *>              * goodsSpec;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * fullName;

@end

@interface OrderList :NSObject
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * orderListId;
@property (nonatomic , strong) NSArray<OrderGoods *>              * goods;
@property (nonatomic , copy) NSString              * goodList;
@property (nonatomic , copy) NSString              * totalPrice;
@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , copy) NSString              * orderStatus;

@end

@interface OrderListModel :NSObject
@property (nonatomic , strong) NSArray<OrderList *>              * orderList;

@end

