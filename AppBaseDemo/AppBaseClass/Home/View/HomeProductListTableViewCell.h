//
//  HomeProductListTableViewCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/5.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Goods;

@protocol HomeProductListTableViewCellDelegate <NSObject>
@optional
- (void)changeProcutNumberBagWithCount:(NSString *)count
                         withIndexPath:(NSIndexPath *)indexPath
                          andTypeIndex:(NSInteger)typeIndex
                              withRect:(CGRect)rect;
//点击进入详情
- (void)clickGoToProductDetailWith:(NSIndexPath *)indexPath andGuiGeIndex:(NSInteger)index;
//删除产品清单
- (void)clickDeteleGoodsWith:(NSIndexPath *)indexPath;
//选择打开规格
- (void)ClickSelectSpecificationWithIndexPath:(NSIndexPath *)indexPath;

@end
@interface HomeProductListTableViewCell : UITableViewCell
/**
 数据源
 */
@property (nonatomic ,strong) Goods * dataSourse;

/**
 <#Description#>
 */
@property (nonatomic ,weak) id <HomeProductListTableViewCellDelegate> delegate;

/**
 商品角标
 */
@property (nonatomic ,strong) NSIndexPath * indexPath;
@end
