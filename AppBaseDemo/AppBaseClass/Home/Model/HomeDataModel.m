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
			 @"activityList":@"ActivityList",
			 @"ProductionInfoList" : @"ProductionInfoList",
			 @"bannerList":@"BannerList"
			 };
}
@end


@implementation ActivityList
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"activityID" : @"id"};
}
@end
@implementation Guige
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"guigeID" : @"id"};
}
@end
@implementation GoodsList
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"goodsListID" : @"id"};
}
+ (NSDictionary *)objectClassInArray{
	return @{
			 @"guige":@"Guige",
			 };
}
@end
@implementation ProductionInfoList
+ (NSDictionary *)objectClassInArray{
	return @{
			 @"goodsList":@"GoodsList",
			 };
}
@end
@implementation BannerList
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"bannerListID" : @"id"};
}
@end



