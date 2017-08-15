//
//  ShoppingCartGoodsTableViewCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ShoppingCartGoodsTableViewCell.h"

@interface ShoppingCartGoodsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *goodTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *goodSelectButton;
@property (weak, nonatomic) IBOutlet UILabel *selectNumber;
@property (weak, nonatomic) IBOutlet UILabel *totolPrice;
@property (weak, nonatomic) IBOutlet UIImageView *goodPic;

@end
@implementation ShoppingCartGoodsTableViewCell
- (IBAction)clickGoodSelectButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
