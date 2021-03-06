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
- (void)removeobjectWith:(Goods *)goods withGuiGeIndex:(NSInteger) index {
	
	Goods *	tempGoods = goods.copy;
	
	for (int i = 0 ; i < self.CarInfoList.count; i++) {
		
		Goods * hasGood = self.CarInfoList[i];
		//如果包含这个商品
		if ([hasGood.goodsId isEqualToString:tempGoods.goodsId]) {
			
			for ( int j = 0 ;j <hasGood.guige.count ; j ++ ) {
				Guige * hasGuiGe = hasGood.guige[j];
				Guige * guiGe = tempGoods.guige[index];
				if ([hasGuiGe.guigeID isEqualToString:guiGe.guigeID]) {
					NSMutableArray *temp = hasGood.guige.mutableCopy;
					[temp removeObject:tempGoods.guige[index]];
					hasGood.guige = temp.copy;
				}
			}if (hasGood.guige.count == 0) {
				[self.CarInfoList removeObject:hasGood];
			}
		}
	}

}
- (void)addobjectWith:(Goods *)goods withGuiGeIndex:(NSInteger) index{
	
	Goods *	tempGoods = goods.copy;
	BOOL hasGoodBool = NO;
	BOOL hasGuiGeBool = NO;
	for (int i = 0 ; i < self.CarInfoList.count; i++) {
		
		Goods * hasGood = self.CarInfoList[i];
		//如果包含这个商品
		if ([hasGood.goodsId isEqualToString:tempGoods.goodsId]) {
			
			for ( int j = 0 ;j <hasGood.guige.count ; j ++ ) {
				Guige * hasGuiGe = hasGood.guige[j];
				Guige * guiGe = tempGoods.guige[index];
				if ([hasGuiGe.guigeID isEqualToString:guiGe.guigeID]) {
					hasGuiGeBool = YES;
					hasGuiGe.carGoodNum = guiGe.carGoodNum;
					hasGuiGe.selected = YES;
				}
			}
			if (!hasGuiGeBool) {
				NSMutableArray *temp = hasGood.guige.mutableCopy;
				goods.guige[index].selected = YES;
				[temp addObject:tempGoods.guige[index]];
				hasGood.guige = temp.copy;
			}
			hasGoodBool = YES;
			break;
		}
	}
	
	if (!hasGoodBool) {
		goods.guige[index].selected = YES;
		tempGoods.guige = @[goods.guige[index]];
		[self.CarInfoList addObject:tempGoods];
	}

}
- (NSMutableArray<Goods *> *)CarInfoList {

	if (_CarInfoList == nil) {
		_CarInfoList = [[NSMutableArray alloc] init];
	}
	return _CarInfoList;
}



//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isEqual:APP_DELEGATE.rootViewController]) {
        // 根视图为UITabBarController
        
        RootViewController *rootVC1 = (RootViewController *)rootVC;
        currentVC = [self getCurrentVCFrom:rootVC1.mainTabBar.selectedViewController];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
@end
