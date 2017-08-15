//
//  SelectAddView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectAddViewDelegate <NSObject>
@optional
-(void)changeNumberWith:(NSString *)count withRect:(CGRect) rect;
@end
@interface SelectAddView : UIView
@property (nonatomic ,assign ) BOOL  isDiscount;

@property (nonatomic ,copy ) NSString * carGoodsNum;
/**
 <#Description#>
 */
@property (nonatomic ,weak) id<SelectAddViewDelegate> delegate;
@end
