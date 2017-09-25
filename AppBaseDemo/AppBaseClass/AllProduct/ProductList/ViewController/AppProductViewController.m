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
#import "GetAppProductListBusiness.h"
#import "GoodslistAllModel.h"
#import "GetSelectGoodsListBussiness.h"
#import "GetSelectedProductModel.h"
#import "ShoppingCartChangeNumBussiness.h"
#import "ProductDetailViewController.h"
#import "AddToShoppingCartAnimation.h"
#import "DeleteCartBusiness.h"
@interface AppProductViewController ()<UITableViewDelegate,UITableViewDataSource,AppProductMainCellViewDelegate,CustomScrollSelectViewDelegate,AppProdcutSelectSpecificationCellDelegate>
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

/**
 产品列表
 */
@property (nonatomic ,strong)  NSArray<Goods *> * goodsListInfoList;

@property (nonatomic ,assign ) NSInteger count;
@end

@implementation AppProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initNavBarView:NAV_BAR_TYPE_ROOT_VIEW];
    
	[self initSearchBarViewWithPlaceholder:@"鸡蛋" withSearchType:SearchType_Push];
	self.customScrollSelectView = [[CustomScrollSelectView alloc]
                                   initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, 48)];
	[self.view addSubview:self.customScrollSelectView];
	self.customScrollSelectView.textColor = [UIColor blackColor];
	self.customScrollSelectView.delegate = self;
	[self.customScrollSelectView reloadeData];


	[self GetAppProductListBusinessData];
	[self.view addSubview:self.mainTableView];
	[self.view addSubview:self.leftTimeQuantumTableView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(GetAppProductListBusinessData)
                                                 name:CNReLoadeAllProductList
                                               object:nil];
    
}

- (void)GetAppProductListBusinessData {
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
    }else {
        self.goodsListInfoList = nil;
        [self.mainTableView reloadData];
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
										   completionSuccessHandler:^(GetSelectedProductModel *getSelectedProductModel)
    {
	
        self.goodsListInfoList = getSelectedProductModel.goodsListInfoList;
        [self.mainTableView reloadData];
     
	} completionFailHandler:^(NSString *failMessage) {
	
	} completionError:^(NSString *netWorkErrorMessage) {
	
	
	}];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if(tableView == self.mainTableView) {
		return self.goodsListInfoList.count;
	}else {
		return 1;
	}
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if(tableView == self.mainTableView) {
        
		if (self.goodsListInfoList[section].isOpen) {
            if (self.goodsListInfoList[section].guige.count > 1) return self.goodsListInfoList[section].guige.count;
            else return 0;
		}else {
			return 0;
		}
        
	} else {
		return self.leftCategories.count;
		}
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == _leftTimeQuantumTableView) {
		return 45;
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
            cell = [[AppProdcutSelectSpecificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AppProdcutSelectSpecificationCellID];
        }
        cell.indexPath = indexPath;
        cell.delegate = self;
        cell.dataSourse = self.goodsListInfoList[indexPath.section];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		return cell;
	}

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if (tableView == self.mainTableView) {
		AppProductMainCellView * appProductMainCellView = [[[NSBundle mainBundle] loadNibNamed:@"AppProductMainCellView" owner:self options:nil] lastObject];
		appProductMainCellView.delegate = self;
		appProductMainCellView.section = section;
        appProductMainCellView.dataSourse = self.goodsListInfoList[section];
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
        [appProductMainCellView addGestureRecognizer:tapGesture];
		return appProductMainCellView;
	}
	return nil;
	
}
- (void)event:(UITapGestureRecognizer *)gesture {
    
    ProductDetailViewController * productDetailViewController = [[ProductDetailViewController alloc] init];
    productDetailViewController.goodsId = self.goodsListInfoList[((AppProductMainCellView *)gesture.view).section].goodsId;
    productDetailViewController.guigeId = self.goodsListInfoList[((AppProductMainCellView *)gesture.view).section].guige[0].guigeID;
    [self.navigationController pushViewController:productDetailViewController animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (tableView == self.mainTableView) {
		return 100;
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
		cell.nameLabel.textColor = [UIColor colorWithHexString:Main_Font_Green_Color];
		cell.contentView.backgroundColor = [UIColor whiteColor];
		
		self.lastCell.nameLabel.textColor = [UIColor colorWithHexString:@"7a7a7a"];
		self.lastCell.contentView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
		self.lastCell = cell;
		[self didselectedMonthForRequestCommissionDataWithIndex:indexPath.row];
	}else
	{
        
        ProductDetailViewController * productDetailViewController = [[ProductDetailViewController alloc] init];
        productDetailViewController.goodsId = self.goodsListInfoList[indexPath.section].goodsId;
        productDetailViewController.guigeId = self.goodsListInfoList[indexPath.section].guige[indexPath.row].guigeID;
        [self.navigationController pushViewController:productDetailViewController animated:YES];
	}
}

#pragma mark - 选规格
- (void)clickOpenOrCloseButton:(UIButton *)sender withIndex:(NSInteger)section {
    self.goodsListInfoList[section].open = !self.goodsListInfoList[section].open;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    self.mainIndexPath = indexPath;
    NSRange rang = NSMakeRange(indexPath.section, 1);
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:rang];
    [self.mainTableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];

}


#pragma mark - 选择无规格产品
- (void)clickProductButtonWith:(UIButton *)sender withSection:(NSInteger)section withCount:(NSString *)count withRect:(CGRect)rect{

    [self changeProcutNumberBagWithCount:count withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] withRect:rect];
    
}
#pragma mark - 选择有规格产品

-(void)changeProcutNumberBagWithCount:(NSString *)count withIndexPath:(NSIndexPath *)indexPath withRect:(CGRect)rect{
    
    Goods * selectGoods = self.goodsListInfoList[indexPath.section];
    Guige *selectGuige = selectGoods.guige[indexPath.row];
    selectGuige.carGoodNum = count;
    selectGuige.selected = YES;
    
    
    [[ShoppingCartManager sharedManager] addobjectWith:selectGoods withGuiGeIndex:indexPath.row];

    
    
        if(count.integerValue == 0){
            
            [[ShoppingCartManager sharedManager] removeobjectWith:selectGoods withGuiGeIndex:indexPath.row];

		//删除
			NSMutableArray * goodListArray = [[NSMutableArray alloc] init];
			NSMutableDictionary * goodInfoDict = [[NSMutableDictionary alloc] init];
			NSMutableArray * goodsSpecArray = [[NSMutableArray alloc] init];
			NSMutableDictionary * goodsSpecDict = [[NSMutableDictionary alloc] init];
			
			
			goodsSpecDict = @{@"id":self.goodsListInfoList[indexPath.section].guige[indexPath.row].guigeID}.mutableCopy;
			[goodsSpecArray addObject:goodsSpecDict];
			[goodInfoDict  setValue:self.goodsListInfoList[indexPath.section].goodsId forKey:@"id"];
			[goodInfoDict  setValue:goodsSpecArray forKey:@"goodsSpec"];
			
			[goodListArray addObject:goodInfoDict];
			
			[DeleteCartBusiness requestDeleteCartWithToken:TOKEN goodsList:goodListArray completionSuccessHandler:^(NSString *getSelectedProductModel) {
				
			} completionFailHandler:^(NSString *failMessage) {
				[self showToastWithMessage:failMessage showTime:1];
			} completionError:^(NSString *netWorkErrorMessage) {
				[self showToastWithMessage:netWorkErrorMessage showTime:1];
			}];
        }else {
            NSLog(@"个数:%@, 角标%@",count,indexPath);
			
			if (count.integerValue > self.count) {
				
				[[AddToShoppingCartAnimation sharedAnimation] animationWith:self.view andPoint:rect.origin andEndPoint:CGPointMake(SCREEN_WIDTH/4 * 3 - SCREEN_WIDTH/8 + 10, SCREEN_HEIGHT - 44)];
			}
			self.count = count.integerValue;
            
            [ShoppingCartChangeNumBussiness requestShoppingCartChangeNumWithToken:TOKEN
                                                                          goodsId:self.goodsListInfoList[indexPath.section].goodsId
                                                                           specId:self.goodsListInfoList[indexPath.section].guige[indexPath.row].guigeID                                                                              num:count
                                                         completionSuccessHandler:^(NSString *succeed)
             {
                 
             } completionFailHandler:^(NSString *failMessage) {
                 
             } completionError:^(NSString *netWorkErrorMessage) {
                 
             }];
        }
    
        [CommonNotification postNotification:CNotificationShoppingCartNumberNotify userInfo:nil object:nil];
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
		_mainTableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
		_mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
	}
	
	return _mainTableView;
}

@end
