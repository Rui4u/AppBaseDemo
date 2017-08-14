//
//  ProductDetailTopView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProductDetailTopViewDelegate <NSObject>
- (void)clickPriceButtonWithIndex:(NSInteger) index;
@end
@interface ProductDetailTopView : UIView

@property (nonatomic ,weak ) id<ProductDetailTopViewDelegate> delegate;
@property (nonatomic ,assign ) CGFloat viewHeight;
@end
