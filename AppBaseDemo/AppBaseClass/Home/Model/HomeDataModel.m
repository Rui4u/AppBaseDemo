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

- (id)copyWithZone:(NSZone *)zone {
	Guige *instance = [[Guige alloc] init];
	if (instance) {
		instance.selected = self.selected;
		
		
		instance.oldPrice = [self.oldPrice copyWithZone:zone];
		instance.currentPrice = [self.currentPrice copyWithZone:zone];
		instance.totalWeight = [self.totalWeight copyWithZone:zone];
		instance.guigeID = [self.guigeID copyWithZone:zone];
		
		instance.spec = [self.spec copyWithZone:zone];
		instance.discount = [self.discount copyWithZone:zone];
		instance.avgPrice = [self.avgPrice copyWithZone:zone];
		instance.carGoodNum = [self.carGoodNum copyWithZone:zone];
		
		instance.tempAddGoodsNum = [self.tempAddGoodsNum copyWithZone:zone];
		instance.tempAddPrice = [self.tempAddPrice copyWithZone:zone];
		
	}
	return instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {

	
		Guige *instance = [[Guige alloc] init];
		if (instance) {
			instance.selected = self.selected;
			
			
			instance.oldPrice = [self.oldPrice mutableCopyWithZone:zone];
			
			instance.currentPrice = [self.currentPrice mutableCopyWithZone:zone];
			instance.totalWeight = [self.totalWeight mutableCopyWithZone:zone];
			instance.guigeID = [self.guigeID mutableCopyWithZone:zone];
			
			instance.spec = [self.spec mutableCopyWithZone:zone];
			instance.discount = [self.discount mutableCopyWithZone:zone];
			instance.avgPrice = [self.avgPrice mutableCopyWithZone:zone];
			instance.carGoodNum = [self.carGoodNum mutableCopyWithZone:zone];
			
			instance.tempAddGoodsNum = [self.tempAddGoodsNum mutableCopyWithZone:zone];
			instance.tempAddPrice = [self.tempAddPrice copyWithZone:zone];
			
		}
		return instance;

}
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"guigeID" : @"id"};
}

@end
@implementation Goods 

- (id)copyWithZone:(NSZone *)zone {
	Goods *instance = [[Goods alloc] init];
	if (instance) {
		instance.height = self.height;
		instance.selected = self.selected;
		instance.open = self.open;
		instance.selectNum = [self.selectNum copyWithZone:zone];
		instance.totolPriceNum = [self.totolPriceNum copyWithZone:zone];
		instance.image = [self.image copyWithZone:zone];
		instance.feature = [self.feature copyWithZone:zone];

		instance.specId = [self.specId copyWithZone:zone];
		instance.spec = [self.spec copyWithZone:zone];
		instance.categoryName = [self.categoryName copyWithZone:zone];
		instance.feature = [self.feature copyWithZone:zone];
		
		instance.guige = [self.guige copyWithZone:zone];
		instance.baseSpec = [self.baseSpec copyWithZone:zone];
		instance.brand = [self.brand copyWithZone:zone];
		instance.goodsFresh = [self.goodsFresh copyWithZone:zone];

		instance.discount = [self.discount copyWithZone:zone];
		instance.avgPrice = [self.avgPrice copyWithZone:zone];
		instance.goodsAlias = [self.goodsAlias copyWithZone:zone];
		instance.oldPrice = [self.oldPrice copyWithZone:zone];

		instance.productCategory = [self.productCategory copyWithZone:zone];
		instance.goodsBaseName = [self.goodsBaseName copyWithZone:zone];
		instance.isTop = [self.isTop copyWithZone:zone];
		instance.goodsID = [self.goodsID copyWithZone:zone];
	
		instance.categoryIdOne = [self.categoryIdOne copyWithZone:zone];
		instance.goodsBaseType = [self.goodsBaseType copyWithZone:zone];
		instance.categoryIdTwo = [self.categoryIdTwo copyWithZone:zone];
		instance.totalWeight = [self.totalWeight copyWithZone:zone];
		
		instance.currentPrice = [self.currentPrice copyWithZone:zone];
		instance.cityCode = [self.cityCode copyWithZone:zone];
		instance.introduction = [self.introduction copyWithZone:zone];
		instance.createDate = [self.createDate copyWithZone:zone];
		
		instance.isGift = [self.isGift copyWithZone:zone];
		instance.producer = [self.producer copyWithZone:zone];
		instance.seoKeywords = [self.seoKeywords copyWithZone:zone];
		instance.fullName = [self.fullName copyWithZone:zone];
		
		instance.modifyDate = [self.modifyDate copyWithZone:zone];
		instance.listId = [self.listId copyWithZone:zone];
		instance.goodsState = [self.goodsState copyWithZone:zone];
		instance.goodsNum = [self.goodsNum copyWithZone:zone];
		
		instance.addTime = [self.addTime copyWithZone:zone];
		instance.carGoodNum = [self.carGoodNum copyWithZone:zone];
		instance.detailsImage = [self.detailsImage copyWithZone:zone];
		instance.goodSpecId = [self.goodSpecId copyWithZone:zone];
	}
	return instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
	Goods *instance = [[Goods alloc] init];
	if (instance) {
		instance.height = self.height;
		instance.selected = self.selected;
		instance.open = self.open;
		instance.selectNum = [self.selectNum mutableCopyWithZone:zone];
		instance.totolPriceNum = [self.totolPriceNum mutableCopyWithZone:zone];
		instance.image = [self.image mutableCopyWithZone:zone];
		instance.feature = [self.feature mutableCopyWithZone:zone];
		
		instance.specId = [self.specId mutableCopyWithZone:zone];
		instance.spec = [self.spec mutableCopyWithZone:zone];
		instance.categoryName = [self.categoryName mutableCopyWithZone:zone];
		instance.feature = [self.feature mutableCopyWithZone:zone];
		
		instance.guige = [self.guige mutableCopyWithZone:zone];
		instance.baseSpec = [self.baseSpec mutableCopyWithZone:zone];
		instance.brand = [self.brand mutableCopyWithZone:zone];
		instance.goodsFresh = [self.goodsFresh mutableCopyWithZone:zone];
		
		instance.discount = [self.discount mutableCopyWithZone:zone];
		instance.avgPrice = [self.avgPrice mutableCopyWithZone:zone];
		instance.goodsAlias = [self.goodsAlias mutableCopyWithZone:zone];
		instance.oldPrice = [self.oldPrice mutableCopyWithZone:zone];
		
		instance.productCategory = [self.productCategory mutableCopyWithZone:zone];
		instance.goodsBaseName = [self.goodsBaseName mutableCopyWithZone:zone];
		instance.isTop = [self.isTop mutableCopyWithZone:zone];
		instance.goodsID = [self.goodsID mutableCopyWithZone:zone];
		
		instance.categoryIdOne = [self.categoryIdOne mutableCopyWithZone:zone];
		instance.goodsBaseType = [self.goodsBaseType mutableCopyWithZone:zone];
		instance.categoryIdTwo = [self.categoryIdTwo mutableCopyWithZone:zone];
		instance.totalWeight = [self.totalWeight mutableCopyWithZone:zone];
		
		instance.currentPrice = [self.currentPrice mutableCopyWithZone:zone];
		instance.cityCode = [self.cityCode mutableCopyWithZone:zone];
		instance.introduction = [self.introduction mutableCopyWithZone:zone];
		instance.createDate = [self.createDate mutableCopyWithZone:zone];
		
		instance.isGift = [self.isGift mutableCopyWithZone:zone];
		instance.producer = [self.producer mutableCopyWithZone:zone];
		instance.seoKeywords = [self.seoKeywords mutableCopyWithZone:zone];
		instance.fullName = [self.fullName mutableCopyWithZone:zone];
		
		instance.modifyDate = [self.modifyDate mutableCopyWithZone:zone];
		instance.listId = [self.listId mutableCopyWithZone:zone];
		instance.goodsState = [self.goodsState mutableCopyWithZone:zone];
		instance.goodsNum = [self.goodsNum mutableCopyWithZone:zone];
		
		instance.addTime = [self.addTime mutableCopyWithZone:zone];
		instance.carGoodNum = [self.carGoodNum mutableCopyWithZone:zone];
		instance.detailsImage = [self.detailsImage mutableCopyWithZone:zone];
		instance.goodSpecId = [self.goodSpecId mutableCopyWithZone:zone];

	}
	return instance;
}


+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"goodsID" : @"id"};
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
			 @"goodsList":@"Goods",
			 };
}
@end
@implementation BannerList
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"bannerListID" : @"id"};
}
@end



