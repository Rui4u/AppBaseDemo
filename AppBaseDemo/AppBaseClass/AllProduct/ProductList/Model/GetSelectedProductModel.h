//
//  GetSelectedProductModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeDataModel.h"

@interface GetSelectedProductModel :NSObject
@property (nonatomic , strong) NSArray<GoodsList *>              * goodsListInfoList;
@property (nonatomic , copy) NSString              * isSucceed;

@end
