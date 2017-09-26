//
//  OrderDetailTableViewCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/23.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "OrderDetailTableViewCell.h"
#import "OrderDetailModel.h"
@interface OrderDetailTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *priceIamge;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *productDes;

@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;

@property (nonatomic ,strong ) UIView * bottomView;
@end
@implementation OrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	[self.contentView addSubview:self.bottomView];
	self.priceIamge.contentMode = UIViewContentModeScaleAspectFill;
	self.priceIamge.layer.masksToBounds = YES;
	
	self.imageVIew.contentMode = UIViewContentModeScaleAspectFill;
	self.imageVIew.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGood:(OrderDetailsGoods *)good {
	_good = good;
	
	self.productName.text = good.fullName;
	self.productDes.text = [NSString stringWithFormat:@"￥%@元/%@          X%@" ,good.goodsSpec.firstObject.currentPrice,good.goodsSpec.firstObject.spec,good.goodsSpec.firstObject.goodsAmount];
	[self.imageVIew sd_setImageWithURL:[NSURL URLWithString:good.image] placeholderImage:[UIImage imageNamed:@"guess_bancai"]];
	self.imageVIew.contentMode = UIViewContentModeScaleAspectFill;
	self.imageVIew.layer.masksToBounds = YES;
	for (UIView *view in self.bottomView.subviews) {
		[view removeFromSuperview];
	}
	
	for (int i = 1 ;i <good.goodsSpec.count; i ++) {
		
		UILabel * label = [UILabel creatLabelWithText:[NSString stringWithFormat:@"￥%@元/%@          X%@" ,good.goodsSpec[i].currentPrice,good.goodsSpec[i].spec,good.goodsSpec[i].goodsAmount] FontOfSize:12 textColor:@"3333333"];
		label.textAlignment = NSTextAlignmentRight;
		label.frame = CGRectMake(0, self.productDes.bottom + 25 * (i - 1), SCREEN_WIDTH - 30, 25);
		[self.bottomView addSubview:label];
	}
	
}
- (UIView *)bottomView {
	
	if (_bottomView == nil) {
		_bottomView = [[UIView alloc] init];
	}
	return _bottomView;
}
@end
