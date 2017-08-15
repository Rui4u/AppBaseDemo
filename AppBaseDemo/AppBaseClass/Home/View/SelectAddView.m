//
//  SelectAddView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "SelectAddView.h"
#import "AddToCartKeyBoard.h"
@interface SelectAddView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *reduceButton;
@property (weak, nonatomic) IBOutlet UIButton *disCountButton;

@end
@implementation SelectAddView
- (void)awakeFromNib {
	[super awakeFromNib];
	self.reduceButton.hidden = YES;
	self.numberLabel.hidden = YES;
    _numberLabel.delegate = self;
    
    
}
- (IBAction)clickReduceButton:(id)sender {
	
	int i  = self.numberLabel.text.intValue;
	i--;
	if (i == 0) {
		self.reduceButton.hidden = YES;
		self.numberLabel.hidden = YES;
		if (self.isDiscount) {
			self.disCountButton.hidden = NO;
			self.addButton.hidden = YES;
		}
	}
	if (i < 0) {
		return;
	}
    
	self.numberLabel.text = [NSString stringWithFormat:@"%d",i];
    
    [self didselectChangeNumber];
}
- (IBAction)clickAddButton:(id)sender {
	
	int i = self.numberLabel.text.intValue;
	i++;
	if (i > 999) {
		return;
	}
	
	self.numberLabel.text = [NSString stringWithFormat:@"%d",i];
    
    [self didselectChangeNumber];
    
	if (i >= 1) {
		self.reduceButton.hidden = NO;
		self.numberLabel.hidden = NO;
		self.disCountButton.hidden = YES;
		self.addButton.hidden = NO;
	}
	
}
- (void)setIsDiscount:(BOOL )isDiscount {
	_isDiscount = isDiscount;
	if (_isDiscount == YES) {
		self.addButton.hidden = YES;
		self.disCountButton.hidden = NO;
	}else {
		self.addButton.hidden = NO;
		self.disCountButton.hidden = YES;
	}

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    AddToCartKeyBoard * addToCartKeyBoard = [[NSBundle mainBundle] loadNibNamed:@"AddToCartKeyBoard" owner:self options:nil].lastObject;
    addToCartKeyBoard.frame = APP_DELEGATE.window.bounds;
    [APP_DELEGATE.window addSubview:addToCartKeyBoard];
    
    __weak typeof(self) weakself = self;
    addToCartKeyBoard.sureBoardBlack = ^(NSString * num){
        _numberLabel.text = num;
        [weakself didselectChangeNumber];
        
    };
    return NO;
}
- (void)didselectChangeNumber {
    CGRect rect=[_numberLabel convertRect: _numberLabel.bounds toView:APP_DELEGATE.window];
	rect = CGRectMake(rect.origin.x + _numberLabel.width/2, rect.origin.y + _numberLabel.height/2, rect.size.width, rect.size.height);
    if ([self.delegate respondsToSelector:@selector(changeNumberWith:withRect:)]) {
        [self.delegate changeNumberWith:self.numberLabel.text withRect:rect];
    }
    
    
}
- (void)setCarGoodsNum:(NSString *)carGoodsNum {
	_carGoodsNum = carGoodsNum;
	
	if (carGoodsNum.integerValue > 0) {
		self.reduceButton.hidden = NO;
		self.numberLabel.hidden = NO;
		
	}else {
		self.reduceButton.hidden = YES;
		self.numberLabel.hidden = YES;
	}
	self.numberLabel.text = carGoodsNum;
}

@end
