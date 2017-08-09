//
//  CityNotInOpenCityView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/9.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CityNotInOpenCityViewDelegate<NSObject>

/**
 选择城市
 */
- (void)clickCityNotInOpenCityViewForSelectCityView;

/**
 返回首页
 
 */
- (void)clickCityNotInOpenCityViewForBackHome;
@end
@interface CityNotInOpenCityView : UIView
@property (nonatomic ,weak ) id<CityNotInOpenCityViewDelegate>  deleagte;
@end
