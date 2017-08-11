//
//  CommonSearchController.h
//  HZAgentiOSClient
//
//  Created by sharui on 2017/2/21.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "BaseViewController.h"

/**
 搜索公共页面
 */
@interface CommonSearchController : BaseViewController

/**
 搜索类型
 */
@property (nonatomic ,assign ) SearchType searchType;

//@property (nonatomic , assign) SearchFromVCType searchFromVC;

/**
 searchBar 提醒字
 */
@property (nonatomic ,copy ) NSString * searchBarPlaceholder;

/**
 产品类型 1：财富产品 2：世泽产品
 */
@property (nonatomic , copy) NSString * siteId;

/**
 产品id
 */
@property (nonatomic , copy) NSString * productId;

@end
