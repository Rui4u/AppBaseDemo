//
//  SelectAddView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "SelectAddView.h"
#import "AddToCartKeyBoard.h"
#import "LoginViewRootController.h"
#import "NewCustomAlertView.h"
@interface SelectAddView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *reduceButton;
@property (weak, nonatomic) IBOutlet UIButton *disCountButton;


@property (nonatomic ,copy ) NSString * lastNumber;
@end
@implementation SelectAddView
- (void)awakeFromNib {
	[super awakeFromNib];
	self.reduceButton.hidden = YES;
	self.numberLabel.hidden = YES;
    _numberLabel.delegate = self;
    
    
}
- (IBAction)clickReduceButton:(id)sender {
	
	self.lastNumber = self.numberLabel.text;
    if ([self isNotLoginBool]) return;
	int i  = self.numberLabel.text.intValue;
	i--;
	if (i < 0) {
		return;
	}
    
	self.numberLabel.text = [NSString stringWithFormat:@"%d",i];
    [self didselectChangeNumber];
}
- (IBAction)clickAddButton:(id)sender {
	
	self.lastNumber = self.numberLabel.text;
	
    if ([self isNotLoginBool]) return;
    
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

- (void)setCarGoodsNum:(NSString *)carGoodsNum {
    _carGoodsNum = carGoodsNum;
    
    if (carGoodsNum.integerValue > 0) {
        self.reduceButton.hidden = NO;
        self.numberLabel.hidden = NO;
        self.addButton.hidden = NO;
        self.disCountButton.hidden = YES;
        
        
    }
    self.numberLabel.text = carGoodsNum;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

	
    if ([self isNotLoginBool]) return NO;
	
	self.lastNumber = self.numberLabel.text;
	
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
	
	if (self.numberLabel.text.intValue == 0) {
		
		UILabel * view = [UILabel creatLabelWithText:@"是否在购物车内删除该商品" FontOfSize:14 textColor:@"333333"];
		NewCustomAlertView * newCustomAlertView = [[NewCustomAlertView alloc] init];
		newCustomAlertView.alertViewWidth  = SCREEN_WIDTH - 24;
		newCustomAlertView.contentView = view;
		newCustomAlertView.contentViewHeight = 50 + 15;
		newCustomAlertView.buttonTitleArray  = @[@"取消",@"确定"];
		newCustomAlertView.buttonColorArray = @[@"333333",Main_Font_Green_Color];
		newCustomAlertView.titleLabelText = @"提示";
		[newCustomAlertView reloadData];
		
		newCustomAlertView.clickBlock = ^(NSInteger index) {
			
			if (index == 1) {
				self.reduceButton.hidden = YES;
				self.numberLabel.hidden = YES;
				if (self.isDiscount) {
					self.disCountButton.hidden = NO;
					self.addButton.hidden = YES;
				}
				
				CGRect rect=[_numberLabel convertRect: _numberLabel.bounds toView:APP_DELEGATE.window];
				rect = CGRectMake(rect.origin.x + _numberLabel.width/2, rect.origin.y + _numberLabel.height/2, rect.size.width, rect.size.height);
				
				if ([self.delegate respondsToSelector:@selector(changeNumberWith:withRect:)]) {
					
					[self.delegate changeNumberWith:self.numberLabel.text withRect:rect];
				}
				
			}else {
				self.numberLabel.text = self.lastNumber;

			}
		};
	}else {
		CGRect rect=[_numberLabel convertRect: _numberLabel.bounds toView:APP_DELEGATE.window];
		rect = CGRectMake(rect.origin.x + _numberLabel.width/2, rect.origin.y + _numberLabel.height/2, rect.size.width, rect.size.height);
		if ([self.delegate respondsToSelector:@selector(changeNumberWith:withRect:)]) {
			[self.delegate changeNumberWith:self.numberLabel.text withRect:rect];
		}
	}
	
	
    
    
}
- (BOOL ) isNotLoginBool {
    BOOL isNotlogin =NO;
    if (isNotLogin) {
		
		clearUserDefaults();

        [ [ShoppingCartManager getCurrentVC] presentViewController:[[LoginViewRootController alloc ]init] animated:YES completion:nil];
        isNotlogin  =YES;

    }else {
        isNotlogin  =NO;
    }
    return isNotlogin;
}

@end
