//
//  ProductDetaiModel.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProductDetaiModel.h"

@implementation Goods
+ (NSDictionary *)objectClassInArray{
    return @{
             @"guige":@"Guige",
             };
}
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"goodsId" : @"id"};
}
@end
@implementation ProductDetaiModel

@end
