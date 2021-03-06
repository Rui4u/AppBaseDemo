//
//  HomeDataModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/4.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityList :NSObject
@property (nonatomic , copy) NSString              * activityClass;
@property (nonatomic , copy) NSString              * activityImg;
@property (nonatomic , copy) NSString              * activityID;
@property (nonatomic , copy) NSString              * introduce;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * state;

@end

@interface Guige :NSObject<NSMutableCopying,NSCopying>

@property (nonatomic ,assign,getter=isSelected)BOOL selected;  //购物车是否选择

@property (nonatomic ,copy ) NSString *				carGoodState;
@property (nonatomic , copy) NSString              * oldPrice;
@property (nonatomic , copy) NSString              * currentPrice;
@property (nonatomic , copy) NSString              * guigeID;
@property (nonatomic , copy) NSString              * totalWeight;
@property (nonatomic , copy) NSString              * discount;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * avgPrice;
@property (nonatomic ,copy ) NSString			   * carGoodNum;
@property (nonatomic ,copy ) NSString			   * tempAddGoodsNum;
@property (nonatomic ,copy ) NSString			   * tempAddPrice;

/**
 <#Description#>
 */
@property (nonatomic ,copy) NSString * showState;
@end

@interface Goods :NSObject<NSMutableCopying,NSCopying>
@property (nonatomic ,assign) NSInteger height;
@property (nonatomic ,assign,getter=isSelected)BOOL selected;  //购物车是否选择
@property (nonatomic ,assign , getter=isOpen) BOOL open; //列表是否打开规格
@property (nonatomic ,copy)  NSString              *selectNum; //已选择数量
@property (nonatomic ,copy)  NSString              *totolPriceNum; //已选择数量
@property (nonatomic ,copy ) NSString			   * image;
@property (nonatomic , copy) NSString              * feature;
@property (nonatomic , copy) NSString              * place;
@property (nonatomic , copy) NSString              * specId;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * categoryName;
@property (nonatomic , strong) NSArray<Guige *>              * guige;
@property (nonatomic , copy) NSString              * baseSpec;
@property (nonatomic , copy) NSString              * brand;
@property (nonatomic , copy) NSString              * goodsFresh;
@property (nonatomic , copy) NSString              * discount;
@property (nonatomic , copy) NSString              * avgPrice;
@property (nonatomic , copy) NSString              * goodsAlias;
@property (nonatomic , copy) NSString              * oldPrice;
@property (nonatomic , copy) NSString              * productCategory;
@property (nonatomic , copy) NSString              * goodsBaseName;
@property (nonatomic , copy) NSString              * isTop;
@property (nonatomic , copy) NSString              * goodsId;
@property (nonatomic , copy) NSString              * categoryIdOne;
@property (nonatomic , copy) NSString              * goodsBaseType;
@property (nonatomic , copy) NSString              * categoryIdTwo;
@property (nonatomic , copy) NSString              * totalWeight;
@property (nonatomic , copy) NSString              * currentPrice;
@property (nonatomic , copy) NSString              * cityCode;
@property (nonatomic , copy) NSString              * introduction;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * isGift;
@property (nonatomic , copy) NSString              * producer;
@property (nonatomic , copy) NSString              * fullName;
@property (nonatomic , copy) NSString              * seoKeywords;
@property (nonatomic , copy) NSString              * modifyDate;
@property (nonatomic , copy) NSString              * listId;
@property (nonatomic , copy) NSString              * goodsState;
@property (nonatomic , copy) NSString              * goodsNum;
@property (nonatomic , copy) NSString              * detailsImage;
@property (nonatomic , copy) NSString              * goodSpecId;
@property (nonatomic , copy) NSString              * carGoodNum;
@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , copy) NSString              * goodsID;

@end

@interface ProductionInfoList :NSObject
@property (nonatomic , strong) NSMutableArray<Goods *>              * goodsList;
@property (nonatomic , copy) NSString              * goodsBaseType;

@end

@interface BannerList :NSObject
@property (nonatomic , copy) NSString              * introduce;
@property (nonatomic , copy) NSString              * BannerListID;
@property (nonatomic , copy) NSString              * state;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , copy) NSString              * clickUrl;

@end

@interface HomeDataModel :NSObject
@property (nonatomic , strong) NSArray<ActivityList *>              * activityList;
@property (nonatomic , strong) NSMutableArray<ProductionInfoList *>              * ProductionInfoList;
@property (nonatomic , strong) NSArray<BannerList *>              * bannerList;
@end
