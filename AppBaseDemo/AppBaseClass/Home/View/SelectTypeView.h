//
//  SelectTypeView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/7/31.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomScrollSelectView.h"
@protocol SelectTypeViewDelegate <NSObject>
- (void)didSelectWithProductTypeModel:(NSInteger)index;
@end
@interface SelectTypeView : UIView
@property (nonatomic ,weak ) id <SelectTypeViewDelegate> delegate;

/**
 数据源
 */
@property (nonatomic ,strong ) NSArray* dataSourse;
@property (nonatomic ,strong ) CustomScrollSelectView * customScrollSelectView;

@end
