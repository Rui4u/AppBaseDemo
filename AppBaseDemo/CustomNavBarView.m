//
//  CustomNavBarView.m
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/10/9.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "CustomNavBarView.h"

@interface CustomNavBarView (/*PrivateAPI */)

- (void) privateBackBtnPressed : (UIButton * ) uiButton ;

@end

@implementation CustomNavBarView

#pragma mark - Public method
- (id)initWithFrame:(CGRect)frame type:(NAV_BAR_TYPE)type
{
    self = [self initWithFrame:frame];
    if (self)
    {
        
        self.bType = type;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor colorWithHexString:@"323137"];
        float offset = SYSTEM_DEV_IOS_7 ? 20 : 0;
        
        
        switch (self.bType)
        {
            case NAV_BAR_TYPE_ROOT_VIEW:
            {
                
                
            }
                break;
            case NAV_BAR_TYPE_SECOND_LEVEL_VIEW_CLOSE:
            {
                self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, offset, 100, 44)];
                self.backBtn.backgroundColor = [UIColor clearColor];
                
                [self.backBtn addTarget:self
                                 action:@selector(privateBackBtnPressed:)
                       forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:self.backBtn];
                
                UIImageView * backImageView = [[UIImageView alloc] init];
                backImageView.image = [UIImage imageNamed:@"icon_fanhui"];
                backImageView.frame = CGRectMake(10, 15, 9, 14.5);
                [self.backBtn addSubview:backImageView];
                
                UILabel * backLabel = [UILabel creatLabelWithText:@"关闭"
                                                       FontOfSize:15
                                                        textColor:@"ffffff"];
                backLabel.frame = CGRectMake(28, 13, 50, 18);
                [self.backBtn addSubview:backLabel];
                
                
            }
                break;
            case NAV_BAR_TYPE_SECOND_LEVEL_VIEW:
            {
                
                self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, offset, 50, 44)];
                self.backBtn.backgroundColor = [UIColor clearColor];
                
                [self.backBtn setImage:[UIImage imageNamed:@"icon_fanhui"]
                              forState:UIControlStateNormal];
                
                [self.backBtn addTarget:self
                                 action:@selector(privateBackBtnPressed:)
                       forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:self.backBtn];
                
            }
                break;
        }
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
    }
    return self;
    
}

- (void)setTitle:(NSString *)title
{
	

	self.titleLabel.frame = CGRectMake(60, 20, SCREEN_WIDTH - 120, 44);
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = title;
    
    
}


#pragma mark - PrivateAPI method
- (void) privateBackBtnPressed : (UIButton * ) uiButton
{
    if ([self.delegate respondsToSelector:@selector(back)])
    {
        [self.delegate back];
    }

}

@end
