//
//  UIButton+SRButton.m
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 16/10/9.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "UIButton+SRButton.h"

@implementation UIButton (SRButton)



+(UIButton *)creatSelectButtonWithNormalImage:(NSString *)normailString
                                selectedImage:(NSString *)selectedString
                                        title:(NSString *)title
                                   titleColor:(NSString *)titleColor
                                     fontSize:(NSUInteger)foneSize
                                       target:(id)target
                                       action:(NSString *)action

{
    
    
    UIButton *btn = [UIButton quickCreateButtonWithFrame:CGRectZero title:title addTarget:target action:action];
    [btn setImage:[UIImage imageNamed:normailString]
         forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedString]
         forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorWithHexString:titleColor]
              forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:foneSize];
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn sizeToFit];
    
    
    return btn;
}


+ (UIButton * ) quickCreateButtonWithFrame:(CGRect)frame
                                     title:(NSString *)title
                                 addTarget:(id)target
                                    action:(NSString *)action
{
    UIButton * btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action: NSSelectorFromString(action) forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
}

/**
 *  创建圆角Button
 *
 *  @param frame     <#frame description#>
 *  @param image     <#image description#>
 *  @param imageRect <#imageRect description#>
 *
 *  @return <#return value description#>
 */
+ (UIButton * ) quickCreateRoundedButtonWithFrame : (CGRect ) frame
                                            image : (UIImage * ) image
                                        imageRect : (CGRect)imageRect
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [button.layer setBorderWidth:0.5]; //边框宽度
    [button.layer setBorderColor:COLOR_RGB(153, 153, 153).CGColor];//边框颜色
    
    UIImageView *brandImage = [[UIImageView alloc] initWithImage:image];
    brandImage.frame = imageRect;
    [button addSubview:brandImage];
    return button;
    
}
/**
 *  添加图片button
 *
 *  @param rect      <#rect description#>
 *  @param image     <#image description#>
 *  @param imageRect <#imageRect description#>
 *
 *  @return <#return value description#>
 */
+ (UIButton * ) quickCreateButtonWithImages:(CGRect)rect
                                      image:(UIImage*)image
                                  imageRect:(CGRect)imageRect
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    
    UIImageView *brandImage = [[UIImageView alloc] initWithImage:image];
    brandImage.frame = imageRect;
    [button addSubview:brandImage];
    return button;
    
}

+ (UIButton * ) creatAuthButtonWithUserInteractionEnabled:(BOOL)userInteractionEnabled
                                                    frame:(CGRect)frame
                                          backgroundColor:(NSString *)backgroundColor
                                                    title:(NSString *)title
                                               titleColor:(NSString *)titleColor
                                              borderWidth:(float)borderWidth
                                              borderColor:(NSString *)borderColor
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = userInteractionEnabled;
    button.frame = frame;
    [button setBackgroundColor:[UIColor colorWithHexString:backgroundColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:titleColor] forState:UIControlStateNormal];
    [button.layer setBorderWidth:borderWidth];
    button.layer.borderColor = [UIColor colorWithHexString:borderColor].CGColor;
    [button.layer setMasksToBounds:YES];
    return button;
}



- (void)setImageToRight
{
    NSDictionary *attribute = @{NSFontAttributeName:self.titleLabel.font};
    //获取文本的宽度
    CGFloat btnWidth = [self.titleLabel.text boundingRectWithSize:CGSizeMake(0, self.titleLabel.font.xHeight)
                                                         options:\
                        NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading
                                                      attributes:attribute
                                                         context:nil].size.width;
    
    
    //通过调节文本和图片的内边距到达目的
    self.imageEdgeInsets = UIEdgeInsetsMake(0, btnWidth, 0, -btnWidth);
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.image.size.width, 0, self.imageView.image.size.width)];
}

- (void)setImageToUp
{
    NSDictionary *attribute = @{NSFontAttributeName:self.titleLabel.font};
    //获取文本的宽度
    CGFloat btnHeight = [self.titleLabel.text boundingRectWithSize:CGSizeMake(0, self.titleLabel.font.xHeight)
                                                          options:\
                        NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading
                                                       attributes:attribute
                                                          context:nil].size.height;
    
    CGFloat btnWidth = [self.titleLabel.text boundingRectWithSize:CGSizeMake(0, self.titleLabel.font.xHeight)
                                                          options:\
                        NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading
                                                       attributes:attribute
                                                          context:nil].size.width;
    
    
    //通过调节文本和图片的内边距到达目的
    self.imageEdgeInsets = UIEdgeInsetsMake(- 8,(btnWidth )/2 ,btnHeight,-(btnWidth )/2);
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.image.size.height + 8, -self.imageView.image.size.width/2,0,self.imageView.image.size.width/2)];
}



+ (UIButton *_Nonnull) creatBottomButtonWithFrame:(CGRect)frame
                                  buttonColorType:(ButtonColor)buttonColorType
                                            title:(NSString *_Nonnull)title
                                       titleColor:(NSString *_Nonnull)titleColor
                                           target:(id _Nonnull)target
                                           action:(NSString *_Nonnull)action
{
    UIButton *btn = [UIButton quickCreateButtonWithFrame:frame title:title addTarget:target action:action];
    if (buttonColorType == ButtonColorBlue)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_submit_blue"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_submit_blue"] forState:UIControlStateHighlighted];
    }
    else if(buttonColorType == ButtonColorRed)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_submit_red"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_submit_red"] forState:UIControlStateHighlighted];
    }
    else if (buttonColorType == ButtonColorBlueBorder)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_application_button_blud"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_application_button_blud"] forState:UIControlStateHighlighted];
    }
    else if (buttonColorType == ButtonColorOrange)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_submit_orange"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_submit_orange"] forState:UIControlStateHighlighted];
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_submit_gray"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_submit_gray"] forState:UIControlStateHighlighted];
    }
    [btn setTitleColor:[UIColor colorWithHexString:titleColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:titleColor] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    

    return btn;
}


@end










