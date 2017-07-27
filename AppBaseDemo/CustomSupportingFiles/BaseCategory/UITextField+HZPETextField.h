//
//  UITextField+HZPETextField.h
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 16/10/24.
//  Copyright © 2017年 sharui. All rights reserved.//

#import <UIKit/UIKit.h>

@interface UITextField (HZPETextField)
+ (UITextField * ) quickCreateTextFieldWithFrame : (CGRect) frame
                               placeholderString : (NSString * ) textString
                                            font : (CGFloat) font
                                       textColor : (UIColor *)textColor;
@end
