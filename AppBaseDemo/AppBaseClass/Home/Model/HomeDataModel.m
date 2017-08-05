//
//  HomeDataModel.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/4.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "HomeDataModel.h"

@implementation HomeDataModel
+ (NSDictionary *)objectClassInArray{
    return @{
             @"bottomBanner":@"BottomBanner",
             @"productInfoList" : @"ProductInfoList",
             @"bannerList":@"BannerList"
             };
}
@end

@implementation Header
@end

@implementation BottomBanner

@end
@implementation Guige

@end
@implementation ProductList


+ (NSDictionary *)objectClassInArray{
    return @{
             @"guige":@"Guige",
             };
}
@end
@implementation ProductInfoList
+ (NSDictionary *)objectClassInArray{
    return @{
             @"productList" : @"ProductList",
             
             };
}
@end
@implementation BannerList

@end


