

//
//  ProductDetailTitleView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProductDetailTitleView.h"

@implementation ProductDetailTitleView
- (IBAction)clickAddToProductList:(UIButton *)sender {
	
	if (self.clickAddProductListButton) {
		self.clickAddProductListButton(@"1");
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
