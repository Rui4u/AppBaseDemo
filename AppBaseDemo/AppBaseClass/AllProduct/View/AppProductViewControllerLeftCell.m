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
	self.nameLabel.frame = CGRectMake(0,0,80, 50);
	
	UIView * lineView  = [[UIView alloc] initWithFrame:CGRectMake( 0, 49, 80, .5)];
	lineView.backgroundColor = [UIColor colorWithHexString:@"d5d5d5"];
	[self.contentView addSubview:lineView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
