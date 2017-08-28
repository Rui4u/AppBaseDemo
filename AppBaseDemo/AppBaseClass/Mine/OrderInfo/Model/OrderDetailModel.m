//
//  OrderDetailModel.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/18.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailsGoodsSpec

@end
@implementation OrderDetailsGoods
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"goodsId" : @"id"};
}
+ (NSDictionary *)objectClassInArray{
	return @{
			 @"goodsSpec":@"OrderDetailsGoodsSpec"
			 };
}
@end
@implementation OrderDetails
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"orderDetailsId" : @"id"};
}
+ (NSDictionary *)objectClassInArray{
	return @{
			 @"goods":@"OrderDetailsGoods"
			 };
}
@end

@implementation OrderDetailModel

@end
