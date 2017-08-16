//
//  ShoppingCartGuiGeTableViewCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Goods;
@interface ShoppingCartGuiGeTableViewCell : UITableViewCell
/**
 <#Description#>
 */
@property (nonatomic ,strong) NSIndexPath *indexPath;

/**
 <#Description#>
 */
@property (nonatomic ,strong) Goods * dataSourse;

@property (nonatomic ,copy) void(^selectShoppingCartGuiGeBlock)(NSIndexPath *indexPath);

@end
