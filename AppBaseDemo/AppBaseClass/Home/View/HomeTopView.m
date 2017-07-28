//
//  HomeTopView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/28.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "HomeTopView.h"
#import "TopAdvertisementView.h"
#import "RecommendProductView.h"
@interface HomeTopView()<AdvertisementViewDelegate>
@property (nonatomic ,strong ) TopAdvertisementView *bannerScrollView; //广告位
@property (nonatomic ,strong ) UIView * headLineView;  //标题View
@property (nonatomic ,strong ) UIView * recommendProductBgView;  //推荐产品View
@end
@implementation HomeTopView

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self privateSetUpUI];
		
	}
	return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self privateSetUpUI];
		
	}
	return self;
}

- (void)privateSetUpUI {

	[self addSubview:self.bannerScrollView];
	self.bannerScrollView.bannerListArray = @[@1,@2,@3,@4];
	[self.bannerScrollView.collectionView reloadData];

	[self setUpHeadLineView];
	[self setUpRecommendProductView];
	[self setUpBoomView];
}

- (void)setUpBoomView {

	UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.recommendProductBgView.frame), SCREEN_WIDTH, 110)];
	button.backgroundColor = [UIColor randomOfColor];
	[self addSubview:button];
	self.height =CGRectGetMaxY(button.frame);
}

- (void)setUpRecommendProductView {

	NSArray * titleArray = @[@"开始购买",@"常用清单",@"活动中心",@"我的订单"];
	CGFloat width = SCREEN_WIDTH/2.0;
	CGFloat height = SCREEN_WIDTH/4.0;
	UIView * recommendProductBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headLineView.frame), SCREEN_WIDTH, height * ceil(titleArray.count/2))];
	self.recommendProductBgView = recommendProductBgView;
	[self addSubview:recommendProductBgView];
	
	NSInteger totalColumns = 2;
	
	for (int index = 0 ; index < titleArray.count; index ++) {
		// 计算行号  和   列号
		int row = index / totalColumns;
		int col = index % totalColumns;
		UIView * view = [[RecommendProductView alloc] initWithFrame:CGRectMake(col * width, row * height, width, height)];
		view.backgroundColor = [UIColor randomOfColor];
		[self.recommendProductBgView addSubview:view];
	}
	
}

- (void)setUpHeadLineView {
	NSArray * titleArray = @[@"开始购买",@"常用清单",@"活动中心",@"我的订单"];
	CGFloat width = SCREEN_WIDTH/4.0;
	CGFloat height = SCREEN_WIDTH/4.0;
	UIView * headLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerScrollView.frame), SCREEN_WIDTH, height)];
	self.headLineView = headLineView;
	[self addSubview:headLineView];
	
	for (int i = 0 ; i < titleArray.count; i ++) {
		
		UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
		view.backgroundColor = [UIColor randomOfColor];
		[headLineView addSubview:view];
	}
}


- (TopAdvertisementView *)bannerScrollView {
	if (!_bannerScrollView) {
		
		_bannerScrollView = [[TopAdvertisementView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoHeight(100))];
		_bannerScrollView.delegate = self;
	}
	return _bannerScrollView;
}

- (void)clickAdverrismentWithUrl:(NSString *)url withUrlTitle:(NSString *)urlTitle {
	
	
}
@end
