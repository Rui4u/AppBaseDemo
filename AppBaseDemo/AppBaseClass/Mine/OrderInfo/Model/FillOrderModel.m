//
//  FillOrderModel.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "FillOrderModel.h"

@implementation FGoodsSpec
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"GoodsSpecId" : @"id"};
}
@end
@implementation CarInfo
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"carInfoId" : @"id"};
}
+ (NSDictionary *)objectClassInArray{
    return @{
             @"goodsSpec":@"FGoodsSpec",
             };
}

@end
@implementation CarImageInfo
+ (NSDictionary *)objectClassInArray{
    return @{
             @"carInfo":@"CarInfo",
             };
}
@end

@implementation FillOrderModel

@end
