//
//  AddToCartKeyBoard.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AddToCartKeyBoard.h"
@interface AddToCartKeyBoard ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end
@implementation AddToCartKeyBoard

- (void)awakeFromNib {
    [super awakeFromNib];
    _inputTextField.delegate = self;
}

- (IBAction)bgButton:(UIButton *)sender {
    
    [UIView animateWithDuration:.3 animations:^{
        [self removeFromSuperview];
    }];
}


- (IBAction)clickKeyBoard:(UIButton *)sender {
    
   
    if ([sender.titleLabel.text isEqualToString:@"确定"]) {
        if (self.sureBoardBlack) {
            self.sureBoardBlack(self.inputTextField.text);
            [UIView animateWithDuration:.3 animations:^{
                [self removeFromSuperview];
            }];
        }
    }else if ([sender.titleLabel.text isEqualToString:@"取消"]) {
       self.inputTextField.text = @"";
        [UIView animateWithDuration:.3 animations:^{
            [self removeFromSuperview];
        }];
    }else {
        if (self.inputTextField.text.length >= 3) { //最大三位
      [BaseViewController showToastWithMessage:@"超过最大购买位数" showTime:1];
            return;
        }
        self.inputTextField.text = [NSString stringWithFormat:@"%d",[NSString stringWithFormat:@"%@%@",self.inputTextField.text,sender.titleLabel.text].intValue];
        self.inputTextField.clearButtonMode = UITextFieldViewModeAlways;
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}
   
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
