//
//  FillOrderSelectTableViewCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FillOrderSelectTableViewCell : UITableViewCell
/**
 <#Description#>
 */
@property (nonatomic ,copy) NSString * textString;

/**
 <#Description#>
 */
@property (nonatomic ,copy) void(^selectButtonBlock)(UIButton *sender);

/**
 <#Description#>
 */
@property (nonatomic ,strong) NSIndexPath * indexPath;
@end
