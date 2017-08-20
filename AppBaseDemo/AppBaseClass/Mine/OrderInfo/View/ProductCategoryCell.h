//
//  ProductCategoryCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarInfo;
@interface ProductCategoryCell : UITableViewCell
/**
 <#Description#>
 */
@property (nonatomic , strong) NSArray<CarInfo *>              * carInfo;
@end
