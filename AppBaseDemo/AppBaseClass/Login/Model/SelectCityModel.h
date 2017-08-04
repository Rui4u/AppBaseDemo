//
//  SelectCityModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/4.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Info :NSObject
@property (nonatomic , copy) NSString              * adCode;
@property (nonatomic , copy) NSString              * cityCode;
@property (nonatomic , copy) NSString              * cityPinyin;
@property (nonatomic , copy) NSString              * cityCaption;
@property (nonatomic , assign) NSInteger              cityOrder;
@property (nonatomic , assign) NSInteger              parentLevel;
@property (nonatomic , copy) NSString              * cityHot;
@property (nonatomic , copy) NSString              * cityAttribute;
@property (nonatomic , assign) NSInteger              cityState;
@property (nonatomic , copy) NSString              * cityDesc;
@property (nonatomic , copy) NSString              * parentCode;

@end

@interface CityList :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray<Info *>              * info;

@end


@interface SelectCityModel :NSObject
@property (nonatomic , strong) NSArray<CityList *>              * cityList;
@property (nonatomic , copy) NSString              * isSucceed;

@end



