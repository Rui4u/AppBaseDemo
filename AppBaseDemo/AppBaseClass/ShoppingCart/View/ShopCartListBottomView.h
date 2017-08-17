//
//  ShopCartListBottomView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/16.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShopCartListBottomViewDelegate<NSObject>

- (void)clickSelectAllWithButtonSelected:(BOOL)selected;
@end
@interface ShopCartListBottomView : UIView
@property (nonatomic ,weak ) id <ShopCartListBottomViewDelegate> delegate;
@end
