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
-(void)changeNumberWith:(NSString *)count;
@end
@interface SelectAddView : UIView
@property (nonatomic ,assign ) BOOL  isDiscount;

/**
 <#Description#>
 */
@property (nonatomic ,weak) id<SelectAddViewDelegate> delegate;
@end
