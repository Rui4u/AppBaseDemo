//
//  HomeProductListTableViewCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/5.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsList;

@protocol HomeProductListTableViewCellDelegate <NSObject>
@optional
- (void)changeProcutNumberBagWithCount:(NSString *)count
                         withIndexPath:(NSIndexPath *)indexPath
                          andTypeIndex:(NSInteger)typeIndex;

//选择打开规格
- (void)ClickSelectSpecificationWithIndexPath:(NSIndexPath *)indexPath;
- (void)addProduct;

@end
@interface HomeProductListTableViewCell : UITableViewCell
/**
 数据源
 */
@property (nonatomic ,strong) GoodsList * dataSourse;

/**
 <#Description#>
 */
@property (nonatomic ,weak) id <HomeProductListTableViewCellDelegate> delegate;

/**
 商品角标
 */
@property (nonatomic ,strong) NSIndexPath * indexPath;
@end
