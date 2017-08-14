//
//  MyCommissionsWaitSettledLeftCell.m
//  HZAgentiOSClient
//
//  Created by sharui on 2017/4/10.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "AppProductViewControllerLeftCell.h"

@implementation AppProductViewControllerLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
		[self privateSetUpUI];
	}
	
	return self;
}

- (void)privateSetUpUI {
	self.contentView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
	
	self.nameLabel = [UILabel creatLabelWithText:@"" FontOfSize:14 textColor:@"7a7a7a"];
	self.nameLabel.textAlignment = NSTextAlignmentCenter;
	[self.contentView addSubview:self.nameLabel];
	[self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
	
    UIView * lineView  = [[UIView alloc] init];
	lineView.backgroundColor = [UIColor colorWithHexString:Main_Line_Gary_Color];
	[self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
