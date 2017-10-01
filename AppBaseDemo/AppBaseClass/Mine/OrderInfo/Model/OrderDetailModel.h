//
//  OrderDetailModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/18.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OrderDetailsGoodsSpec :NSObject
@property (nonatomic , copy) NSString              * goodsAmount;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * currentPrice;
@property (nonatomic , copy) NSString              * cashPledge;
@property (nonatomic , copy) NSString              * goodsPrice;

@end

@interface OrderDetailsGoods :NSObject
@property (nonatomic , copy) NSString              * totalWeight;
@property (nonatomic , copy) NSString              * goodsId;
@property (nonatomic , strong) NSArray<OrderDetailsGoodsSpec *>              * goodsSpec;
@property (nonatomic , copy) NSString              * fullName;
@property (nonatomic , copy) NSString              * image;

@end

@interface OrderDetails :NSObject
@property (nonatomic , copy) NSString              * storeAddress;
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * orderDetailsId;
@property (nonatomic , strong) NSArray<OrderDetailsGoods *>              * goods;
@property (nonatomic , copy) NSString              * paymentId;
@property (nonatomic , copy) NSString              * telPhone;
@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , copy) NSString              * orderStatus;
@property (nonatomic , copy) NSString              * totalPrice;
@property (nonatomic , copy) NSString              * trueName;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * yujiTime;
@property (nonatomic , copy) NSString              * okTime;


@end





@interface OrderDetailModel : NSObject
@property (nonatomic , strong) OrderDetails              * orderDetails;
@end
