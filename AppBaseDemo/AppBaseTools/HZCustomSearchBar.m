//
//  HZCustomSearchBar.m
//  HZAgentiOSClient
//
//  Created by RKL on 17/8/1.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "HZCustomSearchBar.h"

@interface HZCustomSearchBar()<UITextFieldDelegate>

/**
 输入框
 */
@property (nonatomic , strong) UITextField * textField;

@end


@implementation HZCustomSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self privateBuildUI:frame];
        [self addTarget:self action:@selector(HZCustomSearchBarClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - 构建UI
- (void) privateBuildUI:(CGRect)frame
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (CGRectGetHeight(frame)-17)/2, 17, 17)];
    imageView.image = [UIImage imageNamed:@"search_bar"];
    [self addSubview:imageView];
    
    self.textField = [UITextField quickCreateTextFieldWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+7.5, 0, CGRectGetWidth(frame)-32.5, CGRectGetHeight(frame))
                                              placeholderString:self.placeholder
                                                           font:13
                                                      textColor:[UIColor colorWithHexString:@"ffffff"]];

//    [self.textField setValue:[UIColor colorWithHexString:@"8d8d8e"] forKeyPath:@"_placeholderLabel.textColor"];
//    [self.textField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    self.textField.enabled = NO;
    [self addSubview:self.textField];
}


- (void)setSearchBarBackgroundColor:(UIColor *)searchBarBackgroundColor
{
    _searchBarBackgroundColor = searchBarBackgroundColor;
    self.backgroundColor = searchBarBackgroundColor;

}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"8d8d8e"]}];
}

- (void)HZCustomSearchBarClick
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing)])
    {
        [self.delegate searchBarShouldBeginEditing];
    }
}


@end



















