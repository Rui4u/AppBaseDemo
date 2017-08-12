//
//  AppProdcutSelectSpecificationCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/1.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsList;
@protocol  AppProdcutSelectSpecificationCellDelegate<NSObject>

@optional

/**
 添加

 @param count <#count description#>
 @param indexPath <#indexPath description#>
 */
- (void)changeProcutNumberBagWithCount:(NSString *)count withIndexPath:(NSIndexPath *)indexPath;

/**
 打开关闭刷新

 @param indexPath <#indexPath description#>
 */
-(void)selectSpecificationWithIndexPath:(NSIndexPath *)indexPath;
@end
@interface AppProdcutSelectSpecificationCell : UITableViewCell
/**
 <#Description#>
 */
@property (nonatomic ,assign) NSIndexPath * indexPath;

/**
 数据源
 */
@property (nonatomic ,strong) GoodsList * dataSourse;

/**
 代理
 */
@property (nonatomic ,weak) id  delegate;
@end
