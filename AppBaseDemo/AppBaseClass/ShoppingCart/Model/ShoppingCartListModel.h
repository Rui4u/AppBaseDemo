//
//  ShoppingCartListModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/16.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeDataModel.h"

@interface ShoppingCartListModel :NSObject
@property (nonatomic , strong) NSArray<Goods *>              * CarInfoList;
@property (nonatomic , copy) NSString              * carGoodsNum;

@end

