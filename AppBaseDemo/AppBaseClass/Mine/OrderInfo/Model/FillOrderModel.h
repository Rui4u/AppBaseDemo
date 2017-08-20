//
//  FillOrderModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FGoodsSpec :NSObject
@property (nonatomic , copy) NSString              * GoodsSpecId;
@property (nonatomic , copy) NSString              * discount;
@property (nonatomic , copy) NSString              * totalWeight;
@property (nonatomic , copy) NSString              * maxNum;
@property (nonatomic , copy) NSString              * oldPrice;
@property (nonatomic , copy) NSString              * carGoodNum;
@property (nonatomic , copy) NSString              * cashPledge;
@property (nonatomic , copy) NSString              * currentPrice;
@property (nonatomic , copy) NSString              * avgPrice;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * maxReduce;
@property (nonatomic , copy) NSString              * goodsId;
@property (nonatomic , copy) NSString              * specNum;

@end

@interface CarInfo :NSObject
@property (nonatomic , copy) NSString              * place;
@property (nonatomic , copy) NSString              * feature;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * baseSpec;
@property (nonatomic , copy) NSString              * brand;
@property (nonatomic , copy) NSString              * goodPrice;
@property (nonatomic , copy) NSString              * goodsFresh;
@property (nonatomic , copy) NSString              * goodsAlias;
@property (nonatomic , strong) NSArray<FGoodsSpec *>              * goodsSpec;
@property (nonatomic , copy) NSString              * productCategory;
@property (nonatomic , copy) NSString              * isTop;
@property (nonatomic , copy) NSString              * carInfoId;
@property (nonatomic , copy) NSString              * goodsBaseType;
@property (nonatomic , copy) NSString              * totalWeight;
@property (nonatomic , copy) NSString              * cityCode;
@property (nonatomic , copy) NSString              * introduction;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * isGift;
@property (nonatomic , copy) NSString              * producer;
@property (nonatomic , copy) NSString              * detailsImage;
@property (nonatomic , copy) NSString              * fullName;
@property (nonatomic , copy) NSString              * seoKeywords;

@end

@interface CarImageInfo :NSObject
@property (nonatomic , strong) NSArray<CarInfo *>              * carInfo;
@property (nonatomic , copy) NSString              * num;

@end

@interface FillOrderModel :NSObject
@property (nonatomic , strong) CarImageInfo              * carImageInfo;
@property (nonatomic , copy) NSString              * totalcashPeldge;
@property (nonatomic , copy) NSString              * totalcurrentPrice;
@property (nonatomic , copy) NSString              * totalPrice;

@end
