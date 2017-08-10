//
//  SelectSpecificationView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/5.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "SelectSpecificationView.h"

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
    [self addSubview:totolPriceLabel];
    
    UILabel * averagePrice = [UILabel creatLabelWithText:@"￥2.4/斤" FontOfSize:16 textColor:Main_Font_Red_Color];
    averagePrice.frame = CGRectMake(0, totolPriceLabel.bottom, self.width, 16);
    [self addSubview:averagePrice];
        
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
	addButton.frame = CGRectMake(self.width - 44 - 15,(self.height - 44)/2, 44, 44);
	
	[addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];

}
- (void)clickAddButton:(UIButton *)sender {
	if ([self.delegate respondsToSelector:@selector(selectSpecificationWithIndex:)]) {
		[self.delegate selectSpecificationWithIndex:self.index];
	}

}
@end
