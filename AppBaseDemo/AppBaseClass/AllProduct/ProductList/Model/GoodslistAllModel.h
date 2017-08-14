//
//  GoodslistAllModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GoodsCategories :NSObject
@property (nonatomic , copy) NSString              * categoryState;
@property (nonatomic , copy) NSString              * parentId;
@property (nonatomic , copy) NSString              * categoryId;
@property (nonatomic , copy) NSString              * categoryOrder;
@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , copy) NSString              * categoryName;

@end

@interface GoodsCategoryList :NSObject
@property (nonatomic , copy) NSString              * parentId;
@property (nonatomic , copy) NSString              * categoryOrder;
@property (nonatomic , copy) NSString              * categoryId;
@property (nonatomic , strong) NSArray<GoodsCategories *>              * goodsCategories;
@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , copy) NSString              * categoryState;
@property (nonatomic , copy) NSString              * categoryName;

@end

/**
 商品类目模型
 */
@interface GoodslistAllModel :NSObject
@property (nonatomic , strong) NSArray<GoodsCategoryList *>              * GoodsCategoryList;
@property (nonatomic ,copy ) NSString * isSucceed;
@end

