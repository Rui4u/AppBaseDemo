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
- (IBAction)clickGoShopingCart:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(goToSettle)]) {
        [self.delegate goToSettle];
    }
}
- (IBAction)clickSelectAll:(UIButton *)sender {
	sender.selected = !sender.selected;
	
	if ([self.delegate respondsToSelector:@selector(clickSelectAllWithButtonSelected:)]) {
		[self.delegate clickSelectAllWithButtonSelected:sender.selected];
	}
}
- (void)setIsCalculation:(BOOL)isCalculation {
    _isCalculation = isCalculation;
    
    if (_isCalculation == YES) {
        _goShopCartButton.enabled = NO;
        [_goShopCartButton setTitle:@"计算中" forState:UIControlStateNormal];
        _goShopCartButton.backgroundColor = [UIColor colorWithHexString:Main_Button_Gary_Color];
        [_goShopCartButton setTitleColor:[UIColor colorWithHexString:Main_Font_Green_Color] forState:UIControlStateNormal];
    }else {
    
        _goShopCartButton.enabled = YES;
        [_goShopCartButton setTitle:@"去结算" forState:UIControlStateNormal];
        _goShopCartButton.backgroundColor = [UIColor colorWithHexString:Main_Font_Green_Color];
        [_goShopCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
