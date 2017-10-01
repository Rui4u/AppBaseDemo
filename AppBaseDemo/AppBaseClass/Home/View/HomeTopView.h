//
//  HomeTopView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/7/28.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeDataModel;
@interface HomeTopView : UIView
@property (nonatomic ,strong ) HomeDataModel * homeDataModel;

@property (nonatomic ,copy ) void(^topSelected)(NSInteger index);

@property (nonatomic ,copy ) void(^clickHuodongSucceed)(NSString * huodongId);

@end
