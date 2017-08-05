//
//  HomeProductListTableViewCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/5.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductList;

@protocol HomeProductListTableViewCellDelegate <NSObject>
- (void)ClickSelectSpecificationWithIndexPath:(NSIndexPath *)indexPath;

@end
@interface HomeProductListTableViewCell : UITableViewCell
/**
 数据源
 */
@property (nonatomic ,strong) ProductList * dataSourse;

/**
 <#Description#>
 */
@property (nonatomic ,weak) id <HomeProductListTableViewCellDelegate> delegate;

/**
 <#Description#>
 */
@property (nonatomic ,strong) NSIndexPath * indexPath;
@end
