//
//  ShoppingCartGoodsTableViewCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Goods;
@interface ShoppingCartGoodsTableViewCell : UITableViewCell

/**
 <#Description#>
 */
@property (nonatomic ,strong) Goods * dataSourse;

/**
 <#Description#>
 */
@property (nonatomic ,strong) NSIndexPath * indexPath;

/**
 <#Description#>
 */
@property (nonatomic ,copy) void(^selectShoppingCartGoodsBlock)(NSIndexPath *indexPath);

- (void)selectAllOrCancelWith:(BOOL)selectAll;
@end
