//
//  CommonListViewController.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/22.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomViewController.h"
#import "GetSelectedProductModel.h"
/**
 常用清单
 */
@interface SearchListViewController : BaseViewController

/**
 数据源
 */
@property (nonatomic ,strong) NSMutableArray<Goods*> * goodsListInfoList;
@end
