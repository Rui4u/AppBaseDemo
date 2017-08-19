//
//  ProdcutDetailTopTitleView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProdcutDetailBottomView.h"
@interface ProdcutDetailBottomView ()


/**
 价钱
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (weak, nonatomic) IBOutlet UIButton *productCartButton;

@property (weak, nonatomic) IBOutlet UIButton *goProductCartButton;

@end
@implementation ProdcutDetailBottomView

- (IBAction)clcikGoProductCartButton:(UIButton *)sender {
    if (self.gotoProductCart) {
        self.gotoProductCart();
    }
	
}

- (void)setPriceText:(NSString *)priceText {
	_priceText = priceText;
	
	self.priceLabel.attributedText =
	[NSMutableAttributedString setAttributeString:priceText
											 font:15
										textcolor:[UIColor colorWithHexString:@"333333"]
									  secondcolor:[UIColor colorWithHexString:Main_Font_Red_Color]
									   secondfont:15];
	
}
- (void)setNumText:(NSString *)numText {
	_numText = numText;
	self.numberLabel.text = numText;
	if (numText.length >2) {
		self.numberLabel.text = @"99+";
		[self.numberLabel sizeToFit];
		self.LabelWidth.constant = self.numberLabel.width;
	}else {
		self.LabelWidth.constant = 15;
	}
	
}
@end
