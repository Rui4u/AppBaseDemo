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
@interface ProductDetailViewController ()<CustomScrollSelectViewDelegate>
@property (nonatomic ,strong ) CustomScrollSelectView * customScrollSelectView;
@property (nonatomic ,strong ) ProdcutDetailBottomView * prodcutDetailBottomView; //购物车
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
	[super viewDidLoad];
//	[self setNavUI];
//	[self setBottomViewUI];
}

#pragma mark - 点击反馈
- (void)clickRightButton {


}

#pragma mark - 点击title代理
- (void)customScrollSelectView:(CustomScrollSelectView *)customScrollSelectView didSelectWithProductTypeModel:(NSInteger)index {
	
	
	
	
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
