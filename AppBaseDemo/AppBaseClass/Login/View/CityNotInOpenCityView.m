//
//  CityNotInOpenCityView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/9.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "CityNotInOpenCityView.h"
@interface CityNotInOpenCityView ()

@property (weak, nonatomic) IBOutlet UIButton *selectCity;
@property (weak, nonatomic) IBOutlet UIButton *backHome;

@end
@implementation CityNotInOpenCityView


- (IBAction)clickSelectCity:(UIButton *)sender {
	if ([self.deleagte respondsToSelector:@selector(clickCityNotInOpenCityViewForSelectCityView)]) {
		[self.deleagte clickCityNotInOpenCityViewForSelectCityView];
	}
}
- (IBAction)clickBackHome:(UIButton *)sender {
	if ([self.deleagte respondsToSelector:@selector(clickCityNotInOpenCityViewForBackHome)]) {
		[self.deleagte clickCityNotInOpenCityViewForBackHome];
	}
}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//	
//	for (UIView * view in self.subviews) {
//		  CGPoint chatP = [self convertPoint:point toView:view];
//		if ([view pointInside:chatP withEvent:event]) {
//			return view;
//		}
//	}
//	return [super hitTest:point withEvent:event];
//}

@end
