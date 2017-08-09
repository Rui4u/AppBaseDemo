//
//  CityNotInOpenCityView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/9.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "CityNotInOpenCityView.h"

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


@end
