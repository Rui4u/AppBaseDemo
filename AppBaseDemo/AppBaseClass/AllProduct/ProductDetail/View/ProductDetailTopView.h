//
//  ProductDetailTopView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Goods;
@protocol ProductDetailTopViewDelegate <NSObject>
-(void)changeNumberWith:(NSString *)count withRect:(CGRect)rect withGuiGeIndex:(NSInteger )index;

@end
@interface ProductDetailTopView : UIView

@property (nonatomic ,weak ) id<ProductDetailTopViewDelegate> delegate;
@property (nonatomic ,assign ) CGFloat viewHeight;
/**
 <#Description#>
 */
@property (nonatomic ,strong) Goods * goodsDataSourse;
- (instancetype)initWithFrame:(CGRect)frame withGootDataSourse:(Goods *)goodsDataSourse;

@property (nonatomic ,copy )void(^clickAddProductListButton)(UIButton *sender);

@end
