//
//  HomeDataModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/4.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Header :NSObject
@property (nonatomic , copy) NSString              * errorMsg;
@property (nonatomic , copy) NSString              * serverTime;
@property (nonatomic , copy) NSString              * errorCode;

@end

@interface BottomBanner :NSObject
@property (nonatomic , assign) NSInteger              channelType;
@property (nonatomic , copy) NSString              * detail;
@property (nonatomic , copy) NSString              * imageUrl;

@end

@interface Guige :NSObject
@property (nonatomic , copy) NSString              * guigeId;
@property (nonatomic , copy) NSString              * totolPrice;
@property (nonatomic , copy) NSString              * averagePrice;

@end

@interface ProductList :NSObject
@property (nonatomic , copy) NSString              * productImageUrl;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , copy) NSString              * productId;
@property (nonatomic , copy) NSString              * companyName;
@property (nonatomic , strong) NSArray<Guige *>              * guige;

@end

@interface ProductInfoList :NSObject
@property (nonatomic , strong) NSArray<ProductList *>              * productList;
@property (nonatomic , copy) NSString              * protuctType;

@end

@interface BannerList :NSObject
@property (nonatomic , assign) NSInteger              channelType;
@property (nonatomic , copy) NSString              * detail;
@property (nonatomic , copy) NSString              * imageUrl;

@end

@interface Body :NSObject
@property (nonatomic , strong) BottomBanner              * bottomBanner;
@property (nonatomic , strong) NSArray<ProductInfoList *>              * productInfoList;
@property (nonatomic , strong) NSArray<BannerList *>              * bannerList;

@end

@interface HomeDataModel :NSObject
@property (nonatomic , strong) Header              * header;
@property (nonatomic , strong) Body              * body;
@end
