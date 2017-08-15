//
//  AppProdcutSelectSpecificationCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/1.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Goods;
@protocol  AppProdcutSelectSpecificationCellDelegate<NSObject>

@optional

/**
 添加

 @param count <#count description#>
 @param indexPath <#indexPath description#>
 */
- (void)changeProcutNumberBagWithCount:(NSString *)count withIndexPath:(NSIndexPath *)indexPath withRect:(CGRect)rect;

/**
 打开关闭刷新

 @param indexPath <#indexPath description#>
 */
-(void)selectSpecificationWithIndexPath:(NSIndexPath *)indexPath;
@end


/**
 产品列表cell
 */
@interface AppProdcutSelectSpecificationCell : UITableViewCell
/**
 <#Description#>
 */
@property (nonatomic ,assign) NSIndexPath * indexPath;

/**
 数据源
 */
@property (nonatomic ,strong) Goods * dataSourse;

/**
 代理
 */
@property (nonatomic ,weak) id  delegate;
@end
