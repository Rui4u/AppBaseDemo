//
//  AppProductViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/31.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AppProductViewController.h"
#import "CustomScrollSelectView.h"
#import "AppProductViewControllerLeftCell.h"
#import "AppProductMainCell.h"
#import "AppProdcutSelectSpecificationCell.h"
#import "AppProductMainCellView.h"
#import "AppProductModel.h"
#import "LoginViewRootController.h"
#import "GetAppProductListBusiness.h"
#import "GoodslistAllModel.h"
#import "GetSelectGoodsListBussiness.h"

@interface AppProductViewController ()<UITableViewDelegate,UITableViewDataSource,AppProductMainCellViewDelegate,CustomScrollSelectViewDelegate>
/**
 左侧时间tableview
 */
@property (nonatomic ,strong ) UITableView *leftTimeQuantumTableView;

@property (nonatomic ,strong ) UITableView * mainTableView;

@property (nonatomic ,strong ) CustomScrollSelectView * customScrollSelectView;

/**
 上一个左侧cell
 */
@property (nonatomic ,strong ) AppProductViewControllerLeftCell * lastCell;

@property (nonatomic ,strong ) NSMutableArray<AppProductModel *> * productDataSourse;


/**
 商品标题
 */
@property (nonatomic ,strong ) NSArray <GoodsCategoryList *> *goodsCategoryList;
/**
 商品左侧标题
 */
@property (nonatomic ,strong ) NSArray <GoodsCategories *> *leftCategories;
/**
 记录刷新的indexpath
 */
@property (nonatomic ,assign ) NSIndexPath * mainIndexPath;

@end

@implementation AppProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initNavBarView:NAV_BAR_TYPE_ROOT_VIEW];
	
	
	self.customScrollSelectView = [[CustomScrollSelectView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, 48)];
	[self.view addSubview:self.customScrollSelectView];
	self.customScrollSelectView.textColor = [UIColor blackColor];
	self.customScrollSelectView.delegate = self;
	[self.customScrollSelectView reloadeData];


	[self GetAppProductListBusiness];
	[self.view addSubview:self.mainTableView];
	[self.view addSubview:self.leftTimeQuantumTableView];
}

- (void)GetAppProductListBusiness {
	[GetAppProductListBusiness requestGetAppProductListWithToken:TOKEN completionSuccessHandler:^(GoodslistAllModel *goodslistAllModel) {
		
		NSMutableArray * array = [NSMutableArray arrayWithCapacity:10];
		self.goodsCategoryList = goodslistAllModel.GoodsCategoryList;
		//获取标题
		for (GoodsCategoryList * list in goodslistAllModel.GoodsCategoryList) {
			[array addObject:list.categoryName];
		}
		
		self.customScrollSelectView.dataSourse = array;
		[self.customScrollSelectView reloadeData];
		[self.customScrollSelectView selectSwitchButtonAtIndex:0 withClick:YES];

	} completionFailHandler:^(NSString *failMessage) {
		[self showToastWithMessage:failMessage showTime:1];
	} completionError:^(NSString *netWorkErrorMessage) {
		[self showToastWithMessage:netWorkErrorMessage showTime:1];
		
	}];

}

#pragma mark - 代理
- (void)customScrollSelectView:(CustomScrollSelectView *)customScrollSelectView didSelectWithProductTypeModel:(NSInteger)index {

	
	self.leftCategories = self.goodsCategoryList[index].goodsCategories;
	[self.leftTimeQuantumTableView reloadData];
	if (self.leftCategories.count > 0) {
		[self tableView:self.leftTimeQuantumTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	}
	


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didselectedMonthForRequestCommissionDataWithIndex:(NSInteger) index {
	NSLog(@"左侧请求");
	[GetSelectGoodsListBussiness requestGetSelectGoodsListWithToken:TOKEN
														   parented:self.leftCategories[index].parentId
													  categoryIdTwo:self.leftCategories[index].categoryId
										   completionSuccessHandler:^(GetSelectedProductModel *getSelectedProductModel) {
	
	
	} completionFailHandler:^(NSString *failMessage) {
	
	} completionError:^(NSString *netWorkErrorMessage) {
	
	
	}];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if(tableView == self.mainTableView) {
		return self.productDataSourse.count;
	}else {
		return 1;
	}
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if(tableView == self.mainTableView) {
		if (self.productDataSourse[section].isOpen) {
			
			return self.productDataSourse[section].moreSpecificationArray.count;
		}else {
			return 0;
		}
	} else {
		return self.leftCategories.count;
		}
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == _leftTimeQuantumTableView) {
		return 44;
	}else {
		return 70;
	}

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == _leftTimeQuantumTableView ) {
		
		static NSString * const AppProductViewControllerLeftCellID = @"AppProductViewControllerLeftCellID";
		
		AppProductViewControllerLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:AppProductViewControllerLeftCellID];;
		if (cell == nil) {
			cell = [[AppProductViewControllerLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AppProductViewControllerLeftCellID];
		}
		
		cell.nameLabel.text = self.leftCategories[indexPath.row].categoryName;
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		return cell;
		
	}else {

		
		
		static NSString * const AppProdcutSelectSpecificationCellID = @"AppProdcutSelectSpecificationCellID";
		
		AppProdcutSelectSpecificationCell * cell = [tableView dequeueReusableCellWithIdentifier:AppProdcutSelectSpecificationCellID];;
		if (cell == nil) {
			cell = [[NSBundle mainBundle]loadNibNamed:@"AppProdcutSelectSpecificationCell" owner:nil options:nil].lastObject;
		}
		
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		return cell;
	}

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if (tableView == self.mainTableView) {
		AppProductMainCellView * appProductMainCellView = [[[NSBundle mainBundle] loadNibNamed:@"AppProductMainCellView" owner:self options:nil] lastObject];
		appProductMainCellView.delegate = self;
		appProductMainCellView.section = section;
		return appProductMainCellView;
	}
	return nil;
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (tableView == self.mainTableView) {
		return 150;
	}else {
		return 0;
	}
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return .1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if (tableView == _leftTimeQuantumTableView )
	{
		AppProductViewControllerLeftCell* cell = [tableView cellForRowAtIndexPath:indexPath];
		cell.nameLabel.textColor = [UIColor colorWithHexString:@"1ebfe5"];
		cell.contentView.backgroundColor = [UIColor whiteColor];
		
		if ([self.lastCell isEqual:cell]) {
			return;
		}
		
		self.lastCell.nameLabel.textColor = [UIColor colorWithHexString:@"7a7a7a"];
		self.lastCell.contentView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
		self.lastCell = cell;
		[self didselectedMonthForRequestCommissionDataWithIndex:indexPath.row];
	}else
	{
		
	}
}


- (void)clickProductButtonWith:(UIButton *)sender withSection:(NSInteger)section{

	self.productDataSourse[section].open = !self.productDataSourse[section].open;
	NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
	self.mainIndexPath = indexPath;
	NSRange rang = NSMakeRange(indexPath.section, 1);
	NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:rang];
	[self.mainTableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];

//	[self.mainTableView reloadData];
	
	
}

#pragma mark - 懒加载
- (UITableView *)leftTimeQuantumTableView {
	
	if (!_leftTimeQuantumTableView) {
		_leftTimeQuantumTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.customScrollSelectView.frame), 80, SCREEN_HEIGHT - (CGRectGetMaxY(self.customScrollSelectView.frame)) - 49) style:UITableViewStylePlain];
		_leftTimeQuantumTableView.delegate = self;
		_leftTimeQuantumTableView.dataSource = self;
		_leftTimeQuantumTableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
		[_leftTimeQuantumTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	}
	return _leftTimeQuantumTableView;
}

- (UITableView *)mainTableView {
	
	if (!_mainTableView) {
		_mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.leftTimeQuantumTableView.width,CGRectGetMaxY(self.customScrollSelectView.frame), SCREEN_WIDTH - self.leftTimeQuantumTableView.width, SCREEN_HEIGHT - CGRectGetMaxY(self.customScrollSelectView.frame) - 49) style:UITableViewStyleGrouped];
		_mainTableView.delegate = self;
		_mainTableView.dataSource = self;
		_mainTableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
		_mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
	}
	
	return _mainTableView;
}
- (NSMutableArray<AppProductModel *> *)productDataSourse {
	if (_productDataSourse == nil) {
		_productDataSourse = [[NSMutableArray alloc] init];
		for (int i = 0; i < 5; i ++) {
			AppProductModel * model = [[AppProductModel alloc] init];
			model.open = NO;
			[_productDataSourse addObject:model];
		}
	}
	return _productDataSourse;
}

@end
