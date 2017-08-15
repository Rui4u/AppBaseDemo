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
#import "ProductDetailBussiness.h"
#import  "ProductDetaiModel.h"
#import "AddToShoppingCartAnimation.h"
#import  "ProductDetailGuiGeInfo.h"
#import "AddToShoppingCartAnimation.h"
#import "ShoppingCartChangeNumBussiness.h"

@interface ProductDetailViewController () <ProductDetailTopViewDelegate,CustomScrollSelectViewDelegate,UIScrollViewDelegate>
@property (nonatomic ,strong ) CustomScrollSelectView * customScrollSelectView; //顶部
@property (nonatomic ,strong ) ProdcutDetailBottomView * prodcutDetailBottomView; //购物车
@property (nonatomic ,strong ) ProductDetailTopView * productDetailTopView; //头部
@property (nonatomic ,strong ) ProcudtDetailedInformationView * procudtDetailedInformationView;
@property (nonatomic ,strong ) ProductSpecificationParameterView * productSpecificationParameterView;
@property (nonatomic ,strong ) UIScrollView * bgScrollView;
/**
 <#Description#>
 */
@property (nonatomic ,strong) Goods * goodsDataSourse;
/**
 <#Description#>
 */
@property (nonatomic ,assign) BOOL canScroll;

/**
 记录上一个 判断是否需要出现红点
 */
@property (nonatomic ,assign ) NSInteger count;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    [self setNavUI];
    [self setBottomViewUI];

    [self pullToRefresh];

}

- (void)pullToRefresh {

    [ProductDetailBussiness requestProductDetailWithToken:TOKEN goodsId:self.goodsId completionSuccessHandler:^(ProductDetaiModel *productModel) {
        
        self.goodsDataSourse = productModel.goods;
        [self reloadeData];
        [self.bgScrollView.mj_header endRefreshing];
        
    } completionFailHandler:^(NSString *failMessage) {
        [self showToastWithMessage:failMessage showTime:1];
        [self.bgScrollView.mj_header endRefreshing];
    } completionError:^(NSString *netWorkErrorMessage) {
        [self showToastWithMessage:netWorkErrorMessage showTime:1];
        [self.bgScrollView.mj_header endRefreshing];
    }];

}
- (void)reloadeData {
    
    [self setBgScrollViewUI];
    [self.view bringSubviewToFront:self.navBarView];
    [self.view bringSubviewToFront:_prodcutDetailBottomView];
    
    self.navBarView.alpha = 0;
}

-(void)changeNumberWith:(NSString *)count withRect:(CGRect)rect withGuiGeIndex:(NSInteger)index{
	
	if (count.integerValue > self.count) {
		

		CGRect endRect = [_prodcutDetailBottomView.numberLabel convertRect: _prodcutDetailBottomView.numberLabel.bounds toView:APP_DELEGATE.window];
		
		[[AddToShoppingCartAnimation sharedAnimation] animationWith:self.view andPoint:rect.origin andEndPoint:CGPointMake(endRect.origin.x +endRect.size.width, endRect.origin.y)];
	}
	self.count = count.integerValue;
	[ShoppingCartChangeNumBussiness requestShoppingCartChangeNumWithToken:TOKEN
																  goodsId:self.goodsDataSourse.goodsId
																   specId:self.goodsDataSourse.guige[index].guigeID                                                               num:count
												 completionSuccessHandler:^(NSString *succeed)
	 {
		 
	 } completionFailHandler:^(NSString *failMessage) {
		 
	 } completionError:^(NSString *netWorkErrorMessage) {
		 
	 }];
}
#pragma mark - 点击反馈
- (void)clickRightButton {


}

#pragma mark - 点击title代理
- (void)customScrollSelectView:(CustomScrollSelectView *)customScrollSelectView didSelectWithProductTypeModel:(NSInteger)index {
    
    self.canScroll = NO;
    if (index == 0) {
        [self.bgScrollView setContentOffset:CGPointMake(0, -1) animated:YES];
    }else if (index == 1) {
        [self.bgScrollView setContentOffset:CGPointMake(0, self.productDetailTopView.height - self.navBarView.height)animated:YES];
    }else if (index == 2) {
        [self.bgScrollView setContentOffset:CGPointMake(0,self.procudtDetailedInformationView.bottom - self.bgScrollView.height + 100) animated:YES];
    }
	
	
}
- (void)setBgScrollViewUI {
	[self.view addSubview:self.bgScrollView];
	
	[self setUPTopViewUI];
	[self.view setNeedsLayout];
	
	
	self.procudtDetailedInformationView = [[NSBundle mainBundle]loadNibNamed:@"ProcudtDetailedInformationView"
																	   owner:self
																	 options:nil].firstObject;
	[self.bgScrollView addSubview:self.procudtDetailedInformationView];
	CGFloat tempHeight = 50;
	NSArray * detailInfoImage = [self.goodsDataSourse.detailsImage componentsSeparatedByString:@","];
	for (int i = 0; i <detailInfoImage.count; i++) {
		
		UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50 + i * (AutoHeight(200) + 10), SCREEN_WIDTH, AutoHeight(300))];
		[imageView sd_setImageWithURL:[NSURL URLWithString:detailInfoImage[i]] placeholderImage:nil];
		[_procudtDetailedInformationView addSubview:imageView];
		tempHeight = imageView.bottom;
	}
	self.procudtDetailedInformationView.frame = CGRectMake(0, CGRectGetMaxY(_productDetailTopView.frame) , SCREEN_WIDTH, tempHeight);

	
	
	
	self.productSpecificationParameterView = [[NSBundle mainBundle]loadNibNamed:@"ProductSpecificationParameterView"
																		  owner:self
																		options:nil].firstObject;
	
	
	[self.bgScrollView addSubview:self.productSpecificationParameterView];
	NSMutableArray * tempArray = [NSMutableArray arrayWithCapacity:1];

	
	if (self.goodsDataSourse.brand != nil && ![self.goodsDataSourse.brand isEqualToString:@""]) {
	[tempArray addObject:@{	@"text":self.goodsDataSourse.brand,
						   @"title":@"品牌"
							}];
	}

	[tempArray addObject:@{	@"text":[NSString stringWithFormat:@"%@(%@斤)",self.goodsDataSourse.baseSpec,self.goodsDataSourse.guige.firstObject.totalWeight],
								@"title":@"规格"
								}];
	
	if (self.goodsDataSourse.feature != nil) {
		[tempArray addObject:@{	@"text":self.goodsDataSourse.feature,
								@"title":@"等级"
								}];
	}
	if (self.goodsDataSourse.baseSpec != nil) {
		[tempArray addObject:@{	@"text":self.goodsDataSourse.baseSpec,
								@"title":@"包装"
								}];
	}
	if (self.goodsDataSourse.place != nil) {
		[tempArray addObject:@{	@"text":self.goodsDataSourse.place,
								@"title":@"生产地"
								}];
	}
	if (self.goodsDataSourse.producer != nil) {
		[tempArray addObject:@{	@"text":self.goodsDataSourse.producer,
								@"title":@"生产商"
								}];
	}
	
	
	
	for (int i= 0; i <tempArray.count; i ++) {
		ProductDetailGuiGeInfo * productDetailGuiGeInfo = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailGuiGeInfo" owner:self options:nil].firstObject;
		productDetailGuiGeInfo.frame = CGRectMake(0, 50 + i * 40, SCREEN_WIDTH, 40);
		productDetailGuiGeInfo.guigeTitle.text = tempArray[i][@"title"];
		productDetailGuiGeInfo.guigeTextLabel.text = tempArray[i][@"text"];
		tempHeight = productDetailGuiGeInfo.bottom + 10;
		[self.productSpecificationParameterView addSubview:productDetailGuiGeInfo];
	}
	
	self.productSpecificationParameterView.frame = CGRectMake(0, self.procudtDetailedInformationView.bottom + 10, SCREEN_WIDTH, tempHeight);
	
	self.bgScrollView.contentSize = CGSizeMake(0, self.productSpecificationParameterView.bottom + 20);
	
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];

}
- (void)setUPTopViewUI{
	
	_productDetailTopView = [[ProductDetailTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 800) withGootDataSourse:self.goodsDataSourse];
	_productDetailTopView.delegate = self;
	[self.bgScrollView addSubview:_productDetailTopView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 22, 50, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    
    [backButton setImage:[UIImage imageNamed:@"icon_fanhui"]
                  forState:UIControlStateNormal];
    
    [backButton addTarget:self
                     action:@selector(backButtonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
    [_productDetailTopView addSubview:backButton];
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

- (void)backButtonPressed:(UIButton *)sender {
    [self back];
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
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    self.canScroll = YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.navBarView.alpha = scrollView.contentOffset.y/120;

    if (self.canScroll) {
        
        if (self.bgScrollView.contentOffset.y > self.productDetailTopView.height - self.navBarView.height) {
            NSLog(@"%f",self.procudtDetailedInformationView.bottom - self.bgScrollView.height);
            if (self.bgScrollView.contentOffset.y > self.procudtDetailedInformationView.bottom - self.bgScrollView.height) {
                [self.customScrollSelectView selectSwitchButtonAtIndex:2 withClick:NO];
            }else {
                [self.customScrollSelectView selectSwitchButtonAtIndex:1 withClick:NO];
            }
        }else {
            [self.customScrollSelectView selectSwitchButtonAtIndex:0 withClick:NO];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    self.canScroll = YES;
}
- (void)dealloc {

}
@end
