//
//  AppProductMainCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/7/31.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AppProductMainCellViewDelegate <NSObject>

/**
 点击button代理

 @param sender <#sender description#>
 */
- (void)clickProductButtonWith:(UIButton *)sender withSection:(NSInteger) section;
@end
@interface AppProductMainCellView : UIView

@property (nonatomic ,assign )  NSInteger section;
@property (nonatomic ,weak ) id <AppProductMainCellViewDelegate> delegate;
@end
