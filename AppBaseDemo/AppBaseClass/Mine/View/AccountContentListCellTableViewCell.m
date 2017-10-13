//
//  AccountContentListCellTableViewCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/10/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AccountContentListCellTableViewCell.h"

@implementation AccountContentListCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clickButton:(id)sender {
	
	if(self.submitButtonBlock) {
		
		self.submitButtonBlock(self.name.text,self.phone.text);
	}
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
