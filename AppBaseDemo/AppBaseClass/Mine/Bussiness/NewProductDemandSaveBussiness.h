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

+ (void) requestNewProductDemandSaveWithToken : (NSString* ) token
				 completionSuccessHandler : (NewProductDemandSaveSuccessBlock) completionHandler
					completionFailHandler : (NewProductDemandSaveFailBlock) completionFailHandler
						  completionError : (NewProductDemandSaveErrorBlcok) completionError;


@end
