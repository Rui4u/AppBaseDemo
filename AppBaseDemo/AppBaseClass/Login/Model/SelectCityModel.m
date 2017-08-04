//
//  SelectCityModel.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/4.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "SelectCityModel.h"

@implementation SelectCityModel
+(NSDictionary *)mj_objectClassInArray {
    return @{@"cityList":@"CityList"};
}
@end

@implementation Info

@end
@implementation CityList
+(NSDictionary *)mj_objectClassInArray {
    return @{@"info":@"Info"};
}
@end

