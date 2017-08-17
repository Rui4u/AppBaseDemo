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

@property (nonatomic , strong) NSMutableArray<Goods *>* CarInfoList;

@property (nonatomic ,assign ) NSInteger selectNumber;
+ (instancetype)sharedManager;

/**
 添加购物车商品

 @param goods <#goods description#>
 */
- (void)addobjectWith:(Goods *)goods withGuiGeIndex:(NSInteger) index;
- (void)removeobjectWith:(Goods *)goods withGuiGeIndex:(NSInteger) index;

@end
