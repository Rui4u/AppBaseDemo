//
//  ProductDetaiModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeDataModel.h"

@interface ProductDetaiModel :NSObject
@property (nonatomic , strong) Goods              * goods;
@property (nonatomic , copy) NSString              * isSucceed;

@end
