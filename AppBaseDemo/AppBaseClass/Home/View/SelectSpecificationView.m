//
//  SelectSpecificationView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/5.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "SelectSpecificationView.h"
#import "SelectAddView.h"
@interface SelectSpecificationView ()
@property (nonatomic ,strong ) SelectAddView * selectAddView;
@end

@implementation SelectSpecificationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    UILabel * totolPriceLabel = [UILabel creatLabelWithText:@"￥25.6/袋(6斤)" FontOfSize:12 textColor:@"333333"];
    totolPriceLabel.frame = CGRectMake(0, 0, self.width, 35);
	self.totolPriceLabel = totolPriceLabel;
    [self addSubview:totolPriceLabel];
    

	UIImageView * imageView = [[UIImageView alloc] initWithImage:nil];
	imageView.backgroundColor = [UIColor randomOfColor];
	imageView.frame = CGRectMake(0, totolPriceLabel.bottom, 16, 16);
	self.disCountView = imageView;
	[self addSubview:self.disCountView];
	
	UILabel * averagePrice = [UILabel creatLabelWithText:@"￥2.4/斤" FontOfSize:16 textColor:Main_Font_Red_Color];
	self.averagePrice = averagePrice;
	averagePrice.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 5, totolPriceLabel.bottom, self.width, 16);
	[self addSubview:averagePrice];
	
	
	SelectAddView * selectAddView = [[NSBundle mainBundle] loadNibNamed:@"SelectAddView" owner:self options:nil].firstObject;
	self.selectAddView = selectAddView;
	selectAddView.frame = CGRectMake(self.width - 90 - 15,(self.height - 24)/2, 90 , 24);
	[self addSubview:selectAddView];
	
//    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
//	addButton.frame = CGRectMake(self.width - 44 - 15,(self.height - 44)/2, 44, 44);
//	
//	[addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:addButton];

}
- (void)clickAddButton:(UIButton *)sender {
	if ([self.delegate respondsToSelector:@selector(selectSpecificationWithIndex:)]) {
		[self.delegate selectSpecificationWithIndex:self.index];
	}

}
- (void)setShowDisCountView:(BOOL)showDisCountView {
	_showDisCountView = showDisCountView;
	
	if (_showDisCountView == YES) {
		self.disCountView.frame = CGRectMake(0, self.totolPriceLabel.bottom, 16, 16);
		self.averagePrice.frame = CGRectMake(CGRectGetMaxX(self.disCountView.frame) + 5, self.totolPriceLabel.bottom, self.width, 16);
	}else {
		self.averagePrice.frame = CGRectMake(0, self.totolPriceLabel.bottom, self.width, 16);
		
	}
	self.disCountView.hidden = !_showDisCountView;
	self.selectAddView.isDiscount = showDisCountView;
}
@end
