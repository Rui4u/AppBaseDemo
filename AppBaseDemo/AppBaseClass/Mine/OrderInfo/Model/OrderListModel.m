//
//  OrderListModel.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/18.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "OrderListModel.h"

@implementation GoodsSpec

@end
@implementation OrderGoods

+ (NSDictionary *)objectClassInArray{
	return @{
			 @"goodsSpec":@"GoodsSpec"
			 };
}
@end
@implementation OrderList
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"orderListId" : @"id"};
}

+ (NSDictionary *)objectClassInArray{
	return @{
			 @"goods":@"OrderGoods"
			 };
}
@end

@implementation OrderListModel

+ (NSDictionary *)objectClassInArray{
	return @{
			 @"orderList":@"OrderList"
			 };
}
@end
