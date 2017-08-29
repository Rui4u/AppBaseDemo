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
@end
@implementation OrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGood:(OrderDetailsGoods *)good {
	_good = good;
	
	self.productName.text = good.fullName;
	self.productDes.text = [NSString stringWithFormat:@"￥%@*%@",good.goodsSpec.firstObject.spec,good.goodsSpec.firstObject.goodsAmount];
	[self.imageVIew sd_setImageWithURL:[NSURL URLWithString:good.image] placeholderImage:nil];


}
@end
