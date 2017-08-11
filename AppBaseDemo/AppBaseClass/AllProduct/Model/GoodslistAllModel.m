//
//  GoodslistAllModel.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "GoodslistAllModel.h"

@implementation GoodsCategories

@end
@implementation GoodsCategoryList
+ (NSDictionary *)objectClassInArray{
	return @{@"goodsCategories":@"GoodsCategories",
			 };
}


@end
@implementation GoodslistAllModel

+ (NSDictionary *)objectClassInArray{
	return @{@"GoodsCategoryList":@"GoodsCategoryList",
			 };
}

@end
