//
//  ProductDetailTopView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProductDetailTopView.h"
#import "TopAdvertisementView.h"
#import "ProductDetailTitleView.h" //title 和加入清单
#import "SelectAddView.h"
#import "ProductInfoView.h"
@interface ProductDetailTopView()<AdvertisementViewDelegate,SelectAddViewDelegate>
@property (nonatomic ,strong ) TopAdvertisementView * bannerScrollView;//banner
@property (nonatomic ,strong ) ProductDetailTitleView * productDetailTitleView;//名称
@property (nonatomic ,strong ) UIView * specificationBgView; //选择规格

@property (nonatomic ,strong ) UIView * priceBgView; //价格
@property (nonatomic ,strong ) UILabel * advPrice;//均价
@property (nonatomic ,strong ) UILabel * priceDesLabel;//总价

@property (nonatomic ,strong ) ProductInfoView * productInfoView; //商品信息
@property (nonatomic ,strong ) UIButton * lastButton;
@property (nonatomic ,strong ) NSMutableArray * buttonArray;

@end
@implementation ProductDetailTopView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setUpBannerUI];
		_productDetailTitleView = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailTitleView" owner:self options:nil].firstObject;
		[self addSubview:_productDetailTitleView];

		
		[_productDetailTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self.mas_left);
			make.right.equalTo(self.mas_right);
			make.top.equalTo(self.bannerScrollView.mas_bottom);
			make.height.mas_equalTo(44);
		}];
		
		[self setUpSpecificationUI];
		[self setUpPriceViewUI];
		[self setUpProductInfoViewUI];
		
		[self layoutIfNeeded];
		self.height = _productInfoView.bottom + 10;
	}
	return self;
}
- (void)layoutSubviews {
	[super layoutSubviews];
	
}
- (void)setUpProductInfoViewUI {
	ProductInfoView * productInfoView = [[NSBundle mainBundle] loadNibNamed:@"ProductInfoView" owner:self options:nil].lastObject;
	productInfoView.backgroundColor = [UIColor whiteColor];
	self.productInfoView = productInfoView;
	[self  setNeedsLayout];
	
	[self addSubview:productInfoView];
	
	[productInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.mas_left);
		make.right.equalTo(self.mas_right);
		make.top.equalTo(_priceBgView.mas_bottom);
		make.height.mas_equalTo(88);
	}];
}

- (void)setUpPriceViewUI {
	
	_priceBgView = ({
		UIView * priceBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _specificationBgView.bottom , SCREEN_WIDTH, 60)];
		priceBgView.backgroundColor = [UIColor whiteColor];
		priceBgView;
	});
	
	
	_priceDesLabel = ({
		UILabel * priceDesLabel = [UILabel creatLabelWithText:@"￥12.3/袋(10斤)" FontOfSize:16 textColor:Main_Font_Red_Color];
		priceDesLabel.frame = CGRectMake(10, 11, SCREEN_WIDTH, 16);
		priceDesLabel;
	});
	
	_advPrice = ({
		UILabel * advPrice = [UILabel creatLabelWithText:@"￥12.3/斤" FontOfSize:12 textColor:Main_Font_Gary_Color];
		self.advPrice = advPrice;
		advPrice.frame = CGRectMake(10, _priceDesLabel.bottom + 9, SCREEN_WIDTH, 12);
		advPrice;
		
	});
	
	SelectAddView * selectAddView = ({
		SelectAddView *selectAddView = [[NSBundle mainBundle] loadNibNamed:@"SelectAddView" owner:self options:nil].firstObject;
		selectAddView.delegate = self;
		selectAddView.isDiscount = NO;
		selectAddView.frame = CGRectMake(self.width - 90 - 10,(_priceBgView.height - 30)/2 , 90 , 30);
		selectAddView;
	});
	
	UIView *lineView = ({
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, _priceBgView.height- .5, SCREEN_WIDTH - 10, .5)];
		view.backgroundColor = [UIColor colorWithHexString:Main_Line_Gary_Color];
		view;
	});
	
	[self addSubview:_priceBgView];
	[_priceBgView addSubview:_priceDesLabel];
	[_priceBgView addSubview:_advPrice];
	[_priceBgView addSubview:selectAddView];
	[_priceBgView addSubview:lineView];

	
}

-(void)setUpBannerUI{
	[self addSubview:self.bannerScrollView];
}

- (void)setUpSpecificationUI{
	
	

	_specificationBgView = ({
		UIView * specificationBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _bannerScrollView.bottom + 88, SCREEN_WIDTH, 105)];
		specificationBgView.backgroundColor = [UIColor whiteColor];
		specificationBgView;
	});
	[self addSubview:_specificationBgView];

	
	UILabel *titleSelect = [UILabel creatLabelWithText:@"选择规格" FontOfSize:12 textColor:Main_Font_Gary_Color];
	titleSelect.frame = CGRectMake(10, 0, SCREEN_WIDTH, 35);
	[_specificationBgView addSubview:titleSelect];
	
	NSArray * titleArray = @[@"开始购买",@"常用清单",@"活动中心",@"我的订单"];
	CGFloat width = (_specificationBgView.width  - 50 )/4.0;
	CGFloat height = 33;

	NSInteger totalColumns = 4;
	_buttonArray = [NSMutableArray arrayWithCapacity:4];
	for (int index = 0 ; index < titleArray.count; index ++) {
		// 计算行号  和   列号
		int row = index / totalColumns;
		int col = index % totalColumns;
		UIButton * priceButton = [[UIButton alloc] initWithFrame:CGRectMake(col * (width + 10) + 10, row * height + titleSelect.bottom, width, height)];
		[self.buttonArray addObject:priceButton];
		[priceButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
		[priceButton setTitle:titleArray[index] forState:UIControlStateNormal];
		[priceButton setTitleColor:[UIColor colorWithHexString:Main_Button_Gary_Color] forState:UIControlStateNormal];
		[priceButton setTitleColor:[UIColor colorWithHexString:Main_Font_Green_Color] forState:UIControlStateSelected];
		priceButton.titleLabel.font = [UIFont systemFontOfSize:12];
		priceButton.backgroundColor = [UIColor randomOfColor];
		priceButton.tag = 1000 + index;
		[_specificationBgView addSubview:priceButton];
		_specificationBgView.height = priceButton.bottom + 10;
	}
	
	UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, _specificationBgView.height- .5, SCREEN_WIDTH - 10, .5)];
	lineView.backgroundColor = [UIColor colorWithHexString:Main_Line_Gary_Color];
	[_specificationBgView addSubview:lineView];
	

}

- (void)selectButton:(UIButton *)sender {
	self.lastButton.selected = NO;
	sender.selected = YES;
	if ([self.delegate respondsToSelector:@selector(clickPriceButtonWithIndex:)]) {
		[self.delegate clickPriceButtonWithIndex:sender.tag - 1000];
	}
	self.lastButton = sender;
	
}
#pragma mark - 顶部
- (void)clickAdverrismentWithUrl:(NSString *)url withUrlTitle:(NSString *)urlTitle {
	
	
}

-(void)changeNumberWith:(NSString *)count{
	
}
- (TopAdvertisementView *)bannerScrollView {
	if (!_bannerScrollView) {
		
		_bannerScrollView = [[TopAdvertisementView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoHeight(183))];
		_bannerScrollView.delegate = self;
	}
	return _bannerScrollView;
}

@end
