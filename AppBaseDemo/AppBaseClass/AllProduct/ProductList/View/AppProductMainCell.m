//
//  AppProductMainCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/31.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AppProductMainCell.h"
#import "GetSelectedProductModel.h"
#import "AppProductMainCellView.h"
@interface AppProductMainCell ()
@property (nonatomic , strong)AppProductMainCellView * appProductMainCellView;
@end

@implementation AppProductMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
	
		AppProductMainCellView * appProductMainCellView = [[[NSBundle mainBundle] loadNibNamed:@"AppProductMainCellView" owner:self options:nil] lastObject];
        self.appProductMainCellView = appProductMainCellView;
		appProductMainCellView.frame = self.bounds;
		[self.contentView addSubview:appProductMainCellView];
	}
	return self;
}

- (void)setDataSourse:(GoodsList *)dataSourse {

    
    self.appProductMainCellView.dataSourse = dataSourse;
}

@end
