//
//  NewProductDemandBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class NewProductDemandModel;


typedef void (^NewProductDemandSuccessBlock)(NSArray <NewProductDemandModel *> *modelArray);
typedef void (^NewProductDemandFailBlock) (NSString * failMessage);
typedef void (^NewProductDemandErrorBlcok)(NSString * netWorkErrorMessage);

/**
 新品需求 需要添加菜品的页面
 */
@interface NewProductDemandBussiness : BaseBussiness

+ (void) requestNewProductDemandWithToken : (NSString* ) token
				 completionSuccessHandler : (NewProductDemandSuccessBlock) completionHandler
					completionFailHandler : (NewProductDemandFailBlock) completionFailHandler
					completionError : (NewProductDemandErrorBlcok) completionError;


@end
