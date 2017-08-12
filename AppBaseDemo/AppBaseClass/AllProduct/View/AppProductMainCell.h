//
//  AppProductMainCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/7/31.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsList;
@interface AppProductMainCell : UITableViewCell
/**
 数据源
 */
@property (nonatomic ,strong) GoodsList * dataSourse;

@end
