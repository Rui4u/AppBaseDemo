//
//  ShoppingCartManager.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/17.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ShoppingCartManager.h"
#import "HomeDataModel.h"
@interface  ShoppingCartManager()
@end
@implementation ShoppingCartManager
+ (instancetype)sharedManager {
	static id temp;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		temp = [[self alloc] init];
	});
	return temp;
}

- (NSInteger )selectNumber {
	NSInteger temp = 0;
	
	for (Goods *good in [ShoppingCartManager sharedManager].CarInfoList) {
		
		for (Guige * guige in good.guige) {
			if (guige.selected == YES) {
				temp = temp + guige.carGoodNum.integerValue;
			}
		}
	}

	return temp;
}
@end
