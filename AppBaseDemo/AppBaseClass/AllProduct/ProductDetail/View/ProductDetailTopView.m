//
//  ProductDetailTopView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProductDetailTopView.h"
#import "TopProductImageScrollView.h"
#import "ProductDetailTitleView.h" //title 和加入清单
#import "SelectAddView.h"
#import "ProductInfoView.h"
#import "ProductDetaiModel.h"
#import "ShoppingCartChangeNumBussiness.h"
@interface ProductDetailTopView()<ProductDetailTopViewDelegate,SelectAddViewDelegate,ProductImageScrollViewDelegate>
@property (nonatomic ,strong ) TopProductImageScrollView * bannerScrollView;//banner
@property (nonatomic ,strong ) ProductDetailTitleView * productDetailTitleView;//名称
@property (nonatomic ,strong ) UIView * specificationBgView; //选择规格

@property (nonatomic ,strong ) UIView * priceBgView; //价格
@property (nonatomic ,strong ) UILabel * advPrice;//均价
@property (nonatomic ,strong ) UILabel * priceDesLabel;//总价

@property (nonatomic ,strong ) ProductInfoView * productInfoView; //商品信息
@property (nonatomic ,strong ) UIButton * lastButton;
@property (nonatomic ,strong ) NSMutableArray * buttonArray;
/** 添加按钮*/
@property (nonatomic ,strong) SelectAddView * selectAddView;

@end
@implementation ProductDetailTopView

- (instancetype)initWithFrame:(CGRect)frame withGootDataSourse:(Goods *)goodsDataSourse
{
	self = [super initWithFrame:frame];
	if (self) {
        self.goodsDataSourse = goodsDataSourse;
		//banner
		[self setUpBannerUI];
		//title
		[self setUpProductTitleViewUI];
		//选择规格
		[self setUpSpecificationUI];
		//规格价格
		[self setUpPriceViewUI];
		//商品信息
		[self setUpProductInfoViewUI];
        
        [self layoutIfNeeded];
        [self selectButton:self.buttonArray[0]];


		self.height = _productInfoView.bottom + 10;
	}
	return self;
}

- (void) setUpProductTitleViewUI{
	_productDetailTitleView = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailTitleView" owner:self options:nil].firstObject;
	[self addSubview:_productDetailTitleView];
	
	if (_goodsDataSourse.brand == nil) {
		_goodsDataSourse.brand = @"";
	}else{
		_goodsDataSourse.brand = [NSString stringWithFormat:@"[%@]",_goodsDataSourse.brand];
	}
	if (_goodsDataSourse.feature == nil) {
		_goodsDataSourse.feature = @"";
	}
	
	
	[_productDetailTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.mas_left);
		make.right.equalTo(self.mas_right);
		make.top.equalTo(self.bannerScrollView.mas_bottom);
		make.height.mas_equalTo(44);
	}];
    
    _productDetailTitleView.titleLabel.text = [NSString stringWithFormat:@"%@%@ %@",_goodsDataSourse.brand,_goodsDataSourse.fullName,_goodsDataSourse.feature];
    
    if (![_goodsDataSourse.listId isEqualToString:@"0"]) { //已加入清单
        _productDetailTitleView.addProductListButton.selected = YES;
	}else {
		_productDetailTitleView.addProductListButton.selected = NO;
	}
    __weak typeof(self) weakSelf = self;
     _productDetailTitleView.clickAddProductListButton = ^(UIButton *sender) {
         weakSelf.clickAddProductListButton(sender);
     };
//
}
- (void)layoutSubviews {
	[super layoutSubviews];
	
}
- (void)setUpProductInfoViewUI {
	ProductInfoView * productInfoView = [[NSBundle mainBundle] loadNibNamed:@"ProductInfoView" owner:self options:nil].lastObject;
    productInfoView.anotherName.text = self.goodsDataSourse.goodsAlias;
    productInfoView.desLabel.text = self.goodsDataSourse.introduction;
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
		UILabel * priceDesLabel = [UILabel creatLabelWithText:@"" FontOfSize:16 textColor:Main_Font_Red_Color];
		priceDesLabel.frame = CGRectMake(10, 11, SCREEN_WIDTH, 16);
		priceDesLabel;
	});
	
	_advPrice = ({
		UILabel * advPrice = [UILabel creatLabelWithText:@"" FontOfSize:12 textColor:Main_Font_Gary_Color];
		self.advPrice = advPrice;
		advPrice.frame = CGRectMake(10, _priceDesLabel.bottom + 9, SCREEN_WIDTH, 12);
		advPrice;
		
	});
	
	_selectAddView = ({
		SelectAddView *selectAddView = [[NSBundle mainBundle] loadNibNamed:@"SelectAddView" owner:self options:nil].firstObject;
		selectAddView.delegate = self;
		selectAddView.isDiscount = NO;
		selectAddView.frame = CGRectMake(self.width - 100,(_priceBgView.height - 30)/2 , 100 , 30);
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
	[_priceBgView addSubview:_selectAddView];
	[_priceBgView addSubview:lineView];

	
}

-(void)setUpBannerUI{
	[self addSubview:self.bannerScrollView];
	NSArray * bannerArray = [self.goodsDataSourse.image componentsSeparatedByString:@","];
	self.bannerScrollView.dataSourse = bannerArray;
	[self.bannerScrollView.collectionView reloadData];
}

- (void)setUpSpecificationUI{
	
	

	_specificationBgView = ({
		UIView * specificationBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _bannerScrollView.bottom + 54, SCREEN_WIDTH, 105)];
		specificationBgView.backgroundColor = [UIColor whiteColor];
		specificationBgView;
	});
	[self addSubview:_specificationBgView];

	
	UILabel *titleSelect = [UILabel creatLabelWithText:@"选择规格" FontOfSize:12 textColor:Main_Font_Gary_Color];
	titleSelect.frame = CGRectMake(10, 0, SCREEN_WIDTH, 35);
	[_specificationBgView addSubview:titleSelect];
	
	NSArray <Guige *>* titleArray = self.goodsDataSourse.guige;
	CGFloat width = (_specificationBgView.width  - 50 )/4.0;
	CGFloat height = 33;

	NSInteger totalColumns = 4;
	_buttonArray = [NSMutableArray arrayWithCapacity:4];
	for (int index = 0 ; index < titleArray.count; index ++) {
		// 计算行号  和   列号
		int row = index / totalColumns;
		int col = index % totalColumns;
		UIButton * priceButton = [[UIButton alloc] initWithFrame:CGRectMake(col * (width + 10) + 10, row * (height +10) + titleSelect.bottom, width, height)];
		[self.buttonArray addObject:priceButton];
		[priceButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
		[priceButton setTitle:[NSString stringWithFormat:@"1*%@(%@斤)",self.goodsDataSourse.baseSpec,titleArray[index].totalWeight ] forState:UIControlStateNormal];
		[priceButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
		[priceButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateSelected];
		priceButton.titleLabel.font = [UIFont systemFontOfSize:12];
		priceButton.backgroundColor = [UIColor colorWithHexString:Main_Button_Gary_Color];

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
	sender.backgroundColor = [UIColor colorWithHexString:Main_Font_Green_Color];
	self.lastButton.backgroundColor = [UIColor colorWithHexString:Main_Button_Gary_Color];
    NSInteger tag = sender.tag - 1000;
    NSString * string = [NSString stringWithFormat:@"￥%@*%@(%@斤)",self.goodsDataSourse.guige[tag].currentPrice,self.goodsDataSourse.baseSpec,self.goodsDataSourse.guige[tag].totalWeight];
    self.priceDesLabel.text = string;
    self.advPrice.text = [NSString stringWithFormat:@"￥%@/斤",self.goodsDataSourse.guige[tag].avgPrice];
    
    _selectAddView.carGoodsNum = [NSString stringWithFormat:@"%tu",self.goodsDataSourse.guige[tag].carGoodNum.integerValue + self.goodsDataSourse.guige[tag].tempAddGoodsNum.integerValue];
  
	self.lastButton = sender;
	
}
#pragma mark - 顶部
- (void)clickAdverrismentWithUrl:(NSString *)url withUrlTitle:(NSString *)urlTitle {
	
	
}

-(void)changeNumberWith:(NSString *)count withRect:(CGRect)rect{
	
	if ([self.delegate respondsToSelector:@selector(changeNumberWith:withRect:withGuiGeIndex:)]) {
		[self.delegate changeNumberWith:count withRect:rect withGuiGeIndex:self.lastButton.tag - 1000];
	}
	

}
- (TopProductImageScrollView *)bannerScrollView {
	if (!_bannerScrollView) {
		
		_bannerScrollView = [[TopProductImageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoHeight(183))];
		_bannerScrollView.delegate = self;
	}
	return _bannerScrollView;
}

- (void)setGoodsDataSourse:(Goods *)goodsDataSourse {
    _goodsDataSourse = goodsDataSourse;

}

@end
