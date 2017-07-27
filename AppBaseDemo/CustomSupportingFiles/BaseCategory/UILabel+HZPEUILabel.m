//
//  UILabel+HZPEUILabel.m
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 16/10/24.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "UILabel+HZPEUILabel.h"
#import <CoreText/CoreText.h>
@implementation UILabel (HZPEUILabel)

+ (instancetype)creatLabelWithText:(NSString *)text FontOfSize:(CGFloat)sizeOfFloat textColor:(NSString *)colorWithString{

    UILabel *label = [[self alloc] init];
    label.text = text;
    if (IS_IPHONE_5)
    {
       label.font = [UIFont systemFontOfSize:12];
    }
    else
    {
         label.font = [UIFont systemFontOfSize:sizeOfFloat];
    }
    label.textColor = [UIColor colorWithHexString:colorWithString];
    [label sizeToFit];
    return label;
}

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

- (void)changeAlignmentRightandLeft {
    
    CGRect textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil];
    
    CGFloat margin = (self.frame.size.width - textSize.size.width) / (self.text.length - 1);
    
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributeString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    self.attributedText = attributeString;
    
}


@end
