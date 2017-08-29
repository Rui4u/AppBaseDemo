//
//  FillOrderSelectTableViewCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "FillOrderSelectTableViewCell.h"
@interface FillOrderSelectTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end
@implementation FillOrderSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
	_selectButton.selected = YES;
    // Initialization code
}
- (IBAction)clickSelectButton:(UIButton *)sender {
    if (self.selectButtonBlock) {
        self.selectButtonBlock(sender);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTextString:(NSString *)textString {
    _titleLabel.text = textString;

}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _selectButton.tag = indexPath.row + 100;

}
@end
