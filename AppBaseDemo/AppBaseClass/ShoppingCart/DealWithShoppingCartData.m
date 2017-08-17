//
//  DealWithShoppingCartData.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/17.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "DealWithShoppingCartData.h"

@implementation DealWithShoppingCartData

+ (NSArray *)dealWithShoppingCartDataWith:(NSArray <Goods * >* )cartList {

	NSMutableArray * array = [NSMutableArray array];
	
	for (Goods * goods in cartList) {
		
		NSMutableDictionary * dict = [NSMutableDictionary dictionary];
		
		NSMutableArray * guigeArray = [NSMutableArray array];

		for (Guige *guige in goods.guige) {
			if (guige.selected) {
				NSMutableDictionary * dict = [NSMutableDictionary dictionary];
				[dict setObject:guige.guigeID forKey:@"id"];
				[dict setObject:guige.carGoodNum forKey:@"specNum"];
				[guigeArray addObject:dict];
			}
		}
		if (guigeArray.count > 0) {
			[dict setObject:@"id" forKey:goods.goodsID];
			[dict setObject:guigeArray forKey:@"goodsSpec"];
		}
		
	}
	
	return array.copy;
}

	


@end