//
//  CustomPageView.m
//  HZAgentiOSClient
//
//  Created by sharui on 2016/11/16.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "CustomPageView.h"
@interface CustomPageView ()

/**
 滑动模块
 */
@property (nonatomic ,strong ) UIImageView * rotation;
@end
@implementation CustomPageView

- (instancetype)initWithNumber:(NSInteger )number
{
    self = [super init];
    if (self) {
        [self privateSetUpUIWithNumber:number];
    }
    return self;
}


- (void)privateSetUpUIWithNumber:(NSInteger )number {

    self.rotation = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_banner_rotation_switch"]];
    self.rotation.frame = CGRectMake(0, 0,self.rotation.width, self.rotation.height);
    self.width = number * (self.rotation.width + 5);
    self.height = self.rotation.height;
    
    for (int i = 0 ; i < number ; i ++) {
        
        UIImageView * background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_banner_rotation"]];
        background.frame = CGRectMake(i * (background.width + 5), 0, background.width, background.height);
        [self addSubview:background];
    }
    [self addSubview:self.rotation];
}

- (void) setRotationToNumber:(NSInteger) number {

    
    [UIView animateWithDuration:.3 animations:^{
    self.rotation.frame = CGRectMake(number * (self.rotation.width + 5), 0, self.rotation.width, self.rotation.height);
    }];
}

@end
