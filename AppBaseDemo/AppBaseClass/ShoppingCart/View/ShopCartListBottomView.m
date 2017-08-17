//
//  ShopCartListBottomView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/16.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ShopCartListBottomView.h"
@interface ShopCartListBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *selectAllButton;
@end
@implementation ShopCartListBottomView
- (IBAction)clickSelectAll:(UIButton *)sender {
	sender.selected = !sender.selected;
	
	if ([self.delegate respondsToSelector:@selector(clickSelectAllWithButtonSelected:)]) {
		[self.delegate clickSelectAllWithButtonSelected:sender.selected];
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
