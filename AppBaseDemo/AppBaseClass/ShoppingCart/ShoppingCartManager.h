//
//  ShoppingCartManager.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/17.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Goods;

/**
 购物车单利
 */
@interface ShoppingCartManager : NSObject

@property (nonatomic , strong) NSArray<Goods *>* CarInfoList;

@property (nonatomic ,assign ) NSInteger selectNumber;
+ (instancetype)sharedManager;
@end
