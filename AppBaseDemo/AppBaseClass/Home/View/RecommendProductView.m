//
//  RecommendProductView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/28.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "RecommendProductView.h"

@implementation RecommendProductView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setUpUI];
	}
	return self;
}

- (void)setUpUI {

	UIButton * button = [[UIButton alloc] initWithFrame:self.bounds];
	button.backgroundColor = [UIColor randomOfColor];
	[self addSubview:button];
	
	UIImageView * iconView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 30 -5, 0, 30, 30)];
	iconView.backgroundColor = [UIColor randomOfColor];
	[self addSubview:iconView];
	
	UILabel *priceLabel = [UILabel creatLabelWithText:@"13" FontOfSize:12 textColor:@"ffffff"];
	priceLabel.frame = iconView.bounds;
	priceLabel.textAlignment = NSTextAlignmentCenter;
	[iconView addSubview:priceLabel];
}
@end
