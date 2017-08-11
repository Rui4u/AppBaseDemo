//
//  SRCustomLabel.m
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 2016/10/19.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "SRCustomLabel.h"
@interface SRCustomLabel()
@property (nonatomic ,assign ) bool textInsetsBool;
@end
@implementation SRCustomLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;

    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    
    if (self.textInsetsBool){
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
    }else {
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
    }
    
}



- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignments) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

- (void)setTextInsets:(UIEdgeInsets)textInsets {
    _textInsets = textInsets;
    self.textInsetsBool = YES;
}
- (void)setSpacing:(NSInteger)spacing {

    NSMutableAttributedString *attributedString  = self.attributedText.mutableCopy;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}
@end
