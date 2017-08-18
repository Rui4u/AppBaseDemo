//
//  MyOrderListTableViewCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/18.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "MyOrderListTableViewCell.h"
#import "OrderListModel.h"
@interface MyOrderListTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *productNumber;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
@implementation MyOrderListTableViewCell
- (IBAction)clickButton:(UIButton *)sender {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setOrderListInfo:(OrderList *)orderListInfo {

	for (id view in self.categoryView.subviews) {
		
		[view removeFromSuperview];
	}
	
	self.orderTime.text = orderListInfo.addTime;
	self.status.text = self.orderListInfo.orderStatus;
	
	_productNumber.attributedText =
	[NSMutableAttributedString setAttributeString: [NSString stringWithFormat:@"共{%ld}类商品",orderListInfo.goods.count]
											 font:12
										textcolor:[UIColor colorWithHexString:Main_Font_Red_Color]
									  secondcolor:[UIColor colorWithHexString:Main_Font_Black_Color]
									   secondfont:12];


	
	self.moneyLabel.attributedText =
	[NSMutableAttributedString setAttributeString:[NSString stringWithFormat:@"{￥%@}{含运费￥0.00}",orderListInfo.totalPrice]
											 font:12
										textcolor:[UIColor colorWithHexString:Main_Font_Red_Color]
									  secondcolor:[UIColor colorWithHexString:Main_Font_Black_Color]
									   secondfont:12];
	
	for (int i = 0 ; i <orderListInfo.goods.count ; i ++ ) {
		
		OrderGoods *goods = orderListInfo.goods[i];
		
		UIImageView * imageView = [[UIImageView alloc] init];
		imageView.frame = CGRectMake(15 +(64.6) * i , 5, 54.5, 54.5);
		[self.categoryView addSubview:imageView];
		[imageView sd_setImageWithURL:[NSURL URLWithString:goods.image] placeholderImage:nil];
	}
}
@end
