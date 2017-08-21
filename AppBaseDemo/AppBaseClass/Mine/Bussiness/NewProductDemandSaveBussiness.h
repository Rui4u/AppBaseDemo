//
//  NewProductDemandSaveBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class NewProductDemandSaveModel;


typedef void (^NewProductDemandSaveSuccessBlock)(BOOL succeed);
typedef void (^NewProductDemandSaveFailBlock) (NSString * failMessage);
typedef void (^NewProductDemandSaveErrorBlcok)(NSString * netWorkErrorMessage);

/**
 新品需求 需要添加菜品的页面
 */
@interface NewProductDemandSaveBussiness : BaseBussiness

//goodsName  商品名称
//goodsCategoryId  选择分类
//goodsSpec  商品规格
//upplier	供货商
//price  参考价格
//telephone  联系方式
//remark   备注

+ (void) requestNewProductDemandSaveWithToken : (NSString* ) token
									 goodsName:(NSString *)goodsName
							   goodsCategoryId:(NSString *)goodsCategoryId
									 goodsSpec:(NSString *)goodsSpec
									   upplier:(NSString *)upplier
										 price:(NSString *)price
									 telephone:(NSString *)telephone
										remark:(NSString *)remark
				 completionSuccessHandler : (NewProductDemandSaveSuccessBlock) completionHandler
					completionFailHandler : (NewProductDemandSaveFailBlock) completionFailHandler
						  completionError : (NewProductDemandSaveErrorBlcok) completionError;


@end
