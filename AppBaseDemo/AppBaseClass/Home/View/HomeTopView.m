//
//  HomeTopView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/28.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "HomeTopView.h"
#import "HomeDataModel.h"
#import "TopAdvertisementView.h"
#import "RecommendProductView.h"
#import "LCVerticalBadgeBtn.h"
@interface HomeTopView()<AdvertisementViewDelegate>
@property (nonatomic ,strong ) TopAdvertisementView *bannerScrollView; //广告位
@property (nonatomic ,strong ) UIView * headLineView;  //标题View
@property (nonatomic ,strong ) UIView * recommendProductBgView;  //推荐产品View
@property (nonatomic ,strong ) UIButton * bottomAdv;
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

	[self setUpHeadLineView];
//	[self setUpRecommendProductView];
	[self setUpBoomView];
}

- (void)setUpBoomView {

	self.bottomAdv = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headLineView.frame) + 8, SCREEN_WIDTH, 110)];
	[self addSubview:self.bottomAdv];
	self.height =CGRectGetMaxY(self.bottomAdv.frame);
	[self.bottomAdv sd_setBackgroundImageWithURL:[NSURL URLWithString:self.homeDataModel.activityList.firstObject.activityImg] forState:UIControlStateNormal];
}



- (void)setUpHeadLineView {
	NSArray * titleArray = @[@"开始购买",@"常用清单",@"我的订单"];
	CGFloat width = SCREEN_WIDTH/titleArray.count;
	CGFloat height = SCREEN_WIDTH/4.0;
	UIView * headLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerScrollView.frame), SCREEN_WIDTH, height)];
    headLineView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
	self.headLineView = headLineView;
	[self addSubview:headLineView];
	
	for (int i = 0 ; i < titleArray.count; i ++) {
		
		LCVerticalBadgeBtn * view = [[LCVerticalBadgeBtn alloc] init];
		view.tag = i;
		[view addTarget:self action:@selector(selectGoToVC:) forControlEvents:UIControlEventTouchUpInside];
		[view setImage:[UIImage imageNamed:@"homeLoginTemp"] forState:UIControlStateNormal];
		[view setTitle:titleArray[i] forState:UIControlStateNormal];
		view.titleLabel.font = [UIFont systemFontOfSize:12];
		[view setTitleColor:[UIColor colorWithHexString:Main_Font_Black_Color] forState:UIControlStateNormal];
		view.frame = CGRectMake(i * width, 0, width, height);
		[headLineView addSubview:view];
	}
}
- (void)selectGoToVC:(UIButton *)sener{
	
	if (self.topSelected) {
		self.topSelected(sener.tag);
	}
	
	
}

- (TopAdvertisementView *)bannerScrollView {
	if (!_bannerScrollView) {
		
		_bannerScrollView = [[TopAdvertisementView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoHeight(130))];
		_bannerScrollView.delegate = self;
	}
	return _bannerScrollView;
}

- (void)clickAdverrismentWithUrl:(NSString *)url withUrlTitle:(NSString *)urlTitle {
	
	
}

- (void)setHomeDataModel:(HomeDataModel *)homeDataModel {
	_homeDataModel = homeDataModel;

	self.bannerScrollView.bannerListArray = homeDataModel.bannerList;
	[self.bannerScrollView.collectionView reloadData];
	NSString * iamgeUrl = homeDataModel.activityList.firstObject.activityImg;
	[self.bottomAdv sd_setBackgroundImageWithURL:[NSURL URLWithString:iamgeUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"picNomail2"]] ;
}





//- (void)setUpRecommendProductView {
//
//	NSArray * titleArray = @[@"开始购买",@"常用清单",@"活动中心",@"我的订单"];
//	CGFloat width = SCREEN_WIDTH/2.0;
//	CGFloat height = SCREEN_WIDTH/4.0;
//	UIView * recommendProductBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headLineView.frame), SCREEN_WIDTH, height * ceil(titleArray.count/2))];
//	self.recommendProductBgView = recommendProductBgView;
//	[self addSubview:recommendProductBgView];
//
//	NSInteger totalColumns = 2;
//
//	for (int index = 0 ; index < titleArray.count; index ++) {
//		// 计算行号  和   列号
//		int row = index / totalColumns;
//		int col = index % totalColumns;
//		UIView * view = [[RecommendProductView alloc] initWithFrame:CGRectMake(col * width, row * height, width, height)];
//		view.backgroundColor = [UIColor randomOfColor];
//		[self.recommendProductBgView addSubview:view];
//	}
//
//}
@end
