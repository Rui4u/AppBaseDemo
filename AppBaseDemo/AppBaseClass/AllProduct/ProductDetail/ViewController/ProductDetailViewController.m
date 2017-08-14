//
//  ProductDetailViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "CustomScrollSelectView.h" //顶部
#import "ProdcutDetailBottomView.h"//底部
#import "ProductDetailTopView.h"
#import "ProductSpecificationParameterView.h"
#import "ProcudtDetailedInformationView.h"
@interface ProductDetailViewController ()<CustomScrollSelectViewDelegate,UIScrollViewDelegate>
@property (nonatomic ,strong ) CustomScrollSelectView * customScrollSelectView; //顶部
@property (nonatomic ,strong ) ProdcutDetailBottomView * prodcutDetailBottomView; //购物车
@property (nonatomic ,strong ) ProductDetailTopView * productDetailTopView; //头部
@property (nonatomic ,strong ) ProcudtDetailedInformationView * procudtDetailedInformationView;
@property (nonatomic ,strong ) ProductSpecificationParameterView * productSpecificationParameterView;
@property (nonatomic ,strong ) UIScrollView * bgScrollView;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[self setBottomViewUI];
	
	[self setBgScrollViewUI];
	
	[self setNavUI];
	self.navBarView.hidden = YES;
	self.prodcutDetailBottomView.hidden = YES;
}

#pragma mark - 点击反馈
- (void)clickRightButton {


}

#pragma mark - 点击title代理
- (void)customScrollSelectView:(CustomScrollSelectView *)customScrollSelectView didSelectWithProductTypeModel:(NSInteger)index {
	
	
	
	
}
- (void)setBgScrollViewUI {
	[self.view addSubview:self.bgScrollView];
	
	[self setUPTopViewUI];
	[self.view setNeedsLayout];
	
	self.procudtDetailedInformationView = [[NSBundle mainBundle]loadNibNamed:@"ProcudtDetailedInformationView" owner:self
																								 options:nil].firstObject;
	[self.bgScrollView addSubview:self.procudtDetailedInformationView];
	
	
	self.productSpecificationParameterView = [[NSBundle mainBundle]loadNibNamed:@"ProductSpecificationParameterView" owner:self
																								 options:nil].firstObject;
	[self.bgScrollView addSubview:self.productSpecificationParameterView];
	
	self.procudtDetailedInformationView.frame = CGRectMake(0, CGRectGetMaxY(_productDetailTopView.frame) , SCREEN_WIDTH, 800);
	
	self.productSpecificationParameterView.frame = CGRectMake(0, self.procudtDetailedInformationView.bottom + 10, SCREEN_WIDTH, 800);

	self.bgScrollView.contentSize = CGSizeMake(0, self.productSpecificationParameterView.bottom + 20);
	
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];

}
- (void)setUPTopViewUI{
	_productDetailTopView = [[ProductDetailTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 800)];
	[self.bgScrollView addSubview:_productDetailTopView];
}
#pragma mark - 底部去购物车UI
- (void)setBottomViewUI {
	
	_prodcutDetailBottomView =({
		ProdcutDetailBottomView * prodcutDetailBottomView = [[NSBundle mainBundle] loadNibNamed:@"ProdcutDetailBottomView" owner:self options:nil].firstObject;
		prodcutDetailBottomView;
	});
	[self.view addSubview:_prodcutDetailBottomView];
	
	_prodcutDetailBottomView.numText = @"100";
	NSString * price = [NSString stringWithFormat:@"{价格：}{￥%@}",@"1231"];
	_prodcutDetailBottomView.priceText = price;

	[_prodcutDetailBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.view.mas_left);
		make.right.equalTo(self.view.mas_right);
		make.bottom.equalTo(self.view.mas_bottom);
		make.height.equalTo(@60);
	}];
}

#pragma mark - navbar
- (void)setNavUI {
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"去购物车"];
	
	_customScrollSelectView = ({
		CustomScrollSelectView * selectView= [[CustomScrollSelectView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, 48)];
		selectView.textColor = [UIColor blackColor];
		selectView.delegate = self;
		selectView.customTextAlignment = CustomTextAlignmentCenter;
		selectView.dataSourse = @[@"商品",@"详细信息",@"规格参数"];
		[selectView reloadeData];
		[selectView selectSwitchButtonAtIndex:0 withClick:NO];
		selectView;
	});
	[self.navBarView addSubview:_customScrollSelectView];
	
	UIButton * rightButton = [UIButton quickCreateButtonWithFrame:CGRectMake(SCREEN_WIDTH-AutoHeight(44) - 20, 20, AutoHeight(44), AutoHeight(44))
															title:@"反馈"
														addTarget:self
															  action:@"clickRightButton"];
	rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
	rightButton.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentRight;
	[rightButton setTitleColor:[UIColor colorWithHexString:Main_Font_Green_Color] forState:UIControlStateNormal];
	[self.navBarView addSubview:rightButton];
	
	self.navBarView.height = 64 + 48;

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
#pragma mark -lazyLoad
- (UIScrollView *)bgScrollView {
	if (_bgScrollView == nil) {
		_bgScrollView = [[UIScrollView alloc] init];
		_bgScrollView.showsVerticalScrollIndicator = NO;
		_bgScrollView.showsHorizontalScrollIndicator = NO;
		_bgScrollView.delegate = self;
		_bgScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 60);
	}
	return _bgScrollView;
}

@end
