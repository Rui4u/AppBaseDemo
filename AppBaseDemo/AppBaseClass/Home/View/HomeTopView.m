//
//  HomeTopView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/28.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "HomeTopView.h"
#import "TopAdvertisementView.h"

@interface HomeTopView()<AdvertisementViewDelegate>
@property (nonatomic ,strong ) TopAdvertisementView *bannerScrollView; //广告位
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

}

- (void)clickAdverrismentWithUrl:(NSString *)url withUrlTitle:(NSString *)urlTitle {


}
- (TopAdvertisementView *)bannerScrollView {
	if (!_bannerScrollView) {
		
		_bannerScrollView = [[TopAdvertisementView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoHeight(100))];
		_bannerScrollView.delegate = self;
	}
	return _bannerScrollView;
}
@end
