//
//  MyOrderListTableViewCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/18.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "MyOrderListTableViewCell.h"
#import "OrderListModel.h"
#import "NewCustomAlertView.h"
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
	
	if ([sender.titleLabel.text isEqualToString:@"取消进度"]) {
		
		UILabel * view = [UILabel creatLabelWithText:@"是否取消订单" FontOfSize:14 textColor:@"333333"];
		NewCustomAlertView * newCustomAlertView = [[NewCustomAlertView alloc] init];
		newCustomAlertView.alertViewWidth  = SCREEN_WIDTH - 24;
		newCustomAlertView.contentView = view;
		newCustomAlertView.contentViewHeight = 50 + 15;
		newCustomAlertView.buttonTitleArray  = @[@"取消",@"确定"];
		newCustomAlertView.buttonColorArray = @[@"333333",Main_Font_Green_Color];
		newCustomAlertView.titleLabelText = @"取消订单";
		[newCustomAlertView reloadData];
		
		newCustomAlertView.clickBlock = ^(NSInteger index) {
			
			if (index == 1) {
				if (self.cancelOrderBlock) {
					self.cancelOrderBlock(self.orderListInfo.orderListId);
				}
			}
		};
		
	}else if ([sender.titleLabel.text isEqualToString:@"去结算"]) {
		
		if (self.buyAgainBlock) {
			self.buyAgainBlock();
		}
	
	}
	
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
	self.leftButton.hidden = YES;
	
	_orderListInfo = orderListInfo;
	for (id view in self.categoryView.subviews) {
		
		[view removeFromSuperview];
	}
	
	self.orderTime.text = orderListInfo.addTime;
	NSString * statusStr;
	
	if (self.orderListInfo.orderStatus.intValue == 0) {
		statusStr = @"待配货";
		[self.rightButton setTitle:@"取消进度" forState:UIControlStateNormal];
	}else if (self.orderListInfo.orderStatus.intValue == 1) {
		statusStr = @"待发货";
		[self.rightButton setTitle:@"取消进度" forState:UIControlStateNormal];
	}else if (self.orderListInfo.orderStatus.intValue == 2) {
		statusStr = @"待收货";
        [self.rightButton setTitle:@"去结算" forState:UIControlStateNormal];
	}else if (self.orderListInfo.orderStatus.intValue == 3) {
		statusStr = @"已完成";
		[self.rightButton setTitle:@"订单已完成" forState:UIControlStateNormal];

	}else if (self.orderListInfo.orderStatus.intValue == 4) {
		statusStr = @"已取消";
		[self.rightButton setTitle:@"订单已取消" forState:UIControlStateNormal];
	}
	self.status.text = statusStr;
		
//	0待配货 1 待发货，2待收货，3已完成，4已取消
	
	
	
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
		imageView.contentMode = UIViewContentModeScaleAspectFill;
		imageView.layer.masksToBounds = YES;
		imageView.frame = CGRectMake(15 +(64.6) * i , 5, 54.5, 54.5);
		[self.categoryView addSubview:imageView];
        
        
        if (imageView.right > _categoryView.width) {
            imageView.hidden = YES;
        }else {
            imageView.hidden = NO;
        }
		[imageView sd_setImageWithURL:[NSURL URLWithString:goods.image] placeholderImage:[UIImage imageNamed:@"guess_bancai"]];
	}
}
@end
