//
//  FillOrderUserInfoCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "FillOrderUserInfoCell.h"
#import "FillOrderModel.h"

@interface FillOrderUserInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@end
@implementation FillOrderUserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setStore:(Store *)store {

    _store = store;
    _userName.text = store.managerName;
    _adressLabel.text = store.storeAddress;
    _phoneNumber.text = store.storeTelephone;


}
@end
