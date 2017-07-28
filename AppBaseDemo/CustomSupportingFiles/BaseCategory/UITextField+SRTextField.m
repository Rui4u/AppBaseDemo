//
//  UITextField+SRTextField.m
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 16/10/24.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "UITextField+SRTextField.h"
/**
 快速创建 UITextField
 */
@implementation UITextField (SRTextField)
+ (UITextField * ) quickCreateTextFieldWithFrame : (CGRect) frame
                               placeholderString : (NSString * ) textString
                                            font : (CGFloat) font
                                       textColor : (UIColor *)textColor

{
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    textField.textColor = [UIColor darkGrayColor];
    textField.font = [UIFont systemFontOfSize:font];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.returnKeyType = UIReturnKeyNext;
    textField.placeholder = textString;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.textColor = textColor;
    return textField;
}
#pragma mark - 关闭textfield的所有操作事件
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController])
    {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}@end
