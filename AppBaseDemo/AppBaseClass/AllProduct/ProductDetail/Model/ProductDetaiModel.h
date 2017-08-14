//
//  ProductDetaiModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeDataModel.h"

@interface Goods :NSObject
@property (nonatomic , copy) NSString              * feature;
@property (nonatomic , copy) NSString              * specId;
@property (nonatomic , copy) NSString              * modifyDate;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * listId;
@property (nonatomic , strong) NSArray<Guige *>              * guige;
@property (nonatomic , copy) NSString              * baseSpec;
@property (nonatomic , copy) NSString              * goodsState;
@property (nonatomic , copy) NSString              * discount;
@property (nonatomic , copy) NSString              * avgPrice;
@property (nonatomic , copy) NSString              * goodsFresh;
@property (nonatomic , copy) NSString              * goodsAlias;
@property (nonatomic , copy) NSString              * oldPrice;
@property (nonatomic , copy) NSString              * productCategory;
@property (nonatomic , copy) NSString              * isTop;
@property (nonatomic , copy) NSString              * goodsId;
@property (nonatomic , copy) NSString              * goodsBaseType;
@property (nonatomic , copy) NSString              * goodsNum;
@property (nonatomic , copy) NSString              * currentPrice;
@property (nonatomic , copy) NSString              * cityCode;
@property (nonatomic , copy) NSString              * totalWeight;
@property (nonatomic , copy) NSString              * introduction;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * isGift;
@property (nonatomic , copy) NSString              * fullName;
@property (nonatomic , copy) NSString              * seoKeywords;

@end

@interface ProductDetaiModel :NSObject
@property (nonatomic , strong) Goods              * goods;
@property (nonatomic , copy) NSString              * isSucceed;

@end
