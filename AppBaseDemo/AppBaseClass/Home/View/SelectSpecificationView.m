//
//  SelectSpecificationView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/5.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "SelectSpecificationView.h"
#import "SelectAddView.h"
@interface SelectSpecificationView ()<SelectAddViewDelegate>
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
    
    UILabel * totolPriceLabel = [UILabel creatLabelWithText:@"￥25.6/袋(6斤)" FontOfSize:12 textColor:Main_Font_SecondBlack_Color];
    totolPriceLabel.frame = CGRectMake(0, 12, self.width, 12);
	self.totolPriceLabel = totolPriceLabel;
    [self addSubview:totolPriceLabel];
    

	UIImageView * imageView = [[UIImageView alloc] initWithImage:nil];
	imageView.backgroundColor = [UIColor randomOfColor];
	imageView.frame = CGRectMake(0, totolPriceLabel.bottom + 12, 16, 16);
	self.disCountView = imageView;
	[self addSubview:self.disCountView];
	
	UILabel * averagePrice = [UILabel creatLabelWithText:@"￥2.4/斤" FontOfSize:12 textColor:Main_Font_Gary_Color];
	self.averagePrice = averagePrice;
	averagePrice.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 3, imageView.y, self.width, 16);
	[self addSubview:averagePrice];
	
	
	SelectAddView * selectAddView = [[NSBundle mainBundle] loadNibNamed:@"SelectAddView" owner:self options:nil].firstObject;
	self.selectAddView = selectAddView;
    selectAddView.delegate = self;
	selectAddView.frame = CGRectMake(self.width - 90 - 10,imageView.bottom - 30 , 90 , 30);
	[self addSubview:selectAddView];

}

#pragma mark - 购物车
- (void)changeNumberWith:(NSString *)count withRect:(CGRect)rect{
    [self.delegate changeProcutNumberBagWith:count with:self.index withRect:rect];
}



- (void)setShowDisCountView:(BOOL)showDisCountView {
	_showDisCountView = showDisCountView;
	
	if (_showDisCountView == YES) {
        self.disCountView.x = 0;
        self.averagePrice.x = CGRectGetMaxX(self.disCountView.frame) + 3;
	}else {
        self.averagePrice.x = 0;
		
	}
	self.disCountView.hidden = !_showDisCountView;
	self.selectAddView.isDiscount = showDisCountView;
}
@end
