//
//  AppProductMainCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/31.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AppProductMainCellView.h"

@implementation AppProductMainCellView

- (IBAction)clickProductButton:(UIButton *)sender {
	if ([self.delegate respondsToSelector:@selector(clickProductButtonWith:withSection:)]) {
		[self.delegate clickProductButtonWith:sender withSection:self.section];
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
