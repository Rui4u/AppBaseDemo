//
//  HomeViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/28.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTopView.h"
#import "SelectTypeView.h"
#import "LoginViewRootController.h"
#import <MJExtension.h>
#import "HomeDataModel.h"
#import "HomeProductListTableViewCell.h"
#import "UserLocationViewController.h"
#import "GetHomeBusiness.h"
#import "ShoppingCartChangeNumBussiness.h"
#import "ProductDetailViewController.h"
#import "AddToShoppingCartAnimation.h"
#import "DeleteCartBusiness.h"
#import "ProductRemoveListBussiness.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomeProductListTableViewCellDelegate,SelectTypeViewDelegate>
@property (nonatomic ,strong ) HomeTopView * topView;
@property (nonatomic ,strong ) SelectTypeView * selectTypeView;
/**
 数据源
 */
@property (nonatomic ,strong) HomeDataModel *dataSourse;
@property (nonatomic ,assign ) NSInteger count;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.topView= [[HomeTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_AUTO(259))];
	self.rearTopView = self.topView;



	UITableView * tableViewList = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 0) style:UITableViewStyleGrouped];
    
	tableViewList.separatorStyle = UITableViewCellSelectionStyleNone;
	tableViewList.dataSource = self;
	self.frontScrollView = tableViewList;
	
	self.selectTypeView = [[SelectTypeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 74)];
	self.selectTypeView.delegate = self;
	self.selectTypeView.backgroundColor = [UIColor whiteColor];
	self.frontTopView = self.selectTypeView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableViewList.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
	[self setUpSuperViewViewControllerUI];
	self.DraggingHeight = 20 ;
    [self initNavBarView:NAV_BAR_TYPE_ROOT_VIEW];
    

	self.backScrollView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullToRefresh)];
	[self.backScrollView.mj_header beginRefreshing];
	
	
	[self initSearchBarViewWithPlaceholder:@"鸡蛋"
							withSearchType:SearchType_AgentName|SearchType_ShopName];
    self.searchBar.searchBarBackgroundColor = [UIColor colorWithWhite:0 alpha:.3];

}
#pragma mark - 网络请求
- (void)pullToRefresh {

    if (isNotLogin) {
        [self showLoginViewController:^(BOOL loginStatus) {
			[self.backScrollView.mj_header beginRefreshing];
		}];
        [self.backScrollView.mj_header endRefreshing];
        return;
    }
    
	[GetHomeBusiness requestGetHomeWithToken:TOKEN completionSuccessHandler:^(HomeDataModel *homeDataModel)
	 {
		 self.dataSourse = homeDataModel;
		 self.topView.homeDataModel = homeDataModel;
		 [(UITableView *)self.frontScrollView reloadData];
		 [self.backScrollView.mj_header endRefreshing];
			NSMutableArray * selectTitle = [NSMutableArray arrayWithCapacity:3];
		 for (ProductionInfoList *infoList in self.dataSourse.ProductionInfoList) {
			 [selectTitle addObject:infoList.goodsBaseType];
		 }
		 self.selectTypeView.dataSourse = selectTitle;
		 
	 } completionFailHandler:^(NSString *failMessage) {
		 [self showToastWithMessage:failMessage showTime:1];
		 [self.backScrollView.mj_header endRefreshing];

	 } completionError:^(NSString *netWorkErrorMessage) {
		 [self.backScrollView.mj_header endRefreshing];
		 [self showToastWithMessage:netWorkErrorMessage showTime:1];
	 }];

}
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	UserLocationViewController * vc = [[UserLocationViewController alloc] init];
	[self presentViewController:vc animated:YES completion:nil];

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	SRCustomLabel * label = [SRCustomLabel creatLabelWithText: self.dataSourse.ProductionInfoList[section].goodsBaseType FontOfSize:12 textColor:Main_Font_Black_Color];
	label.textInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    label.backgroundColor = [UIColor colorWithHexString:Main_BackGround_Color];
    
	return label;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSourse.ProductionInfoList[section].goodsList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return .1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourse.ProductionInfoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataSourse.ProductionInfoList[indexPath.section].goodsList[indexPath.row].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const HomeProductListTableViewCellID = @"HomeProductListTableViewCellID";
    
    HomeProductListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:HomeProductListTableViewCellID];;
    if (cell == nil) {
        cell = [[HomeProductListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeProductListTableViewCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    cell.indexPath = indexPath;
    cell.dataSourse = self.dataSourse.ProductionInfoList[indexPath.section].goodsList[indexPath.row];
	[self.selectTypeView.customScrollSelectView selectSwitchButtonAtIndex:indexPath.section withClick:NO];
    return cell;
	
	

}
#pragma mark 删除清单
- (void)clickDeteleGoodsWith:(NSIndexPath *)indexPath {

    [ProductRemoveListBussiness requestProductRemoveListWithToken:TOKEN goodsId:self.dataSourse.ProductionInfoList[indexPath.section].goodsList[indexPath.row].goodsID completionSuccessHandler:^(BOOL succeed) {
        NSLog(@"删除清单成功");
    [self.dataSourse.ProductionInfoList[indexPath.section].goodsList removeObjectAtIndex:indexPath.row];
    
    [(UITableView *)self.frontScrollView reloadData];
        
    } completionFailHandler:^(NSString *failMessage) {
        [self showToastWithMessage:failMessage showTime:1];
    } completionError:^(NSString *netWorkErrorMessage) {
        [self showToastWithMessage:netWorkErrorMessage showTime:1];
    }];

}

#pragma mark - 去详情
- (void)clickGoToProductDetailWith:(NSIndexPath *)indexPath andGuiGeIndex:(NSInteger)index {
    
    ProductDetailViewController * productDetailViewController = [[ProductDetailViewController alloc] init];
    productDetailViewController.goodsId = self.dataSourse.ProductionInfoList[indexPath.section].goodsList[indexPath.row].goodsID;
    productDetailViewController.guigeId = self.dataSourse.ProductionInfoList[indexPath.section].goodsList[indexPath.row].guige[index].guigeID;
    [self.navigationController pushViewController:productDetailViewController animated:YES];


}

#pragma mark -选择产品类型
- (void)didSelectWithProductTypeModel:(NSInteger)index {
	
	NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:index];
	[(UITableView *)self.frontScrollView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
	self.backScrollView.contentOffset = CGPointMake(0, self.topView.height);

}
#pragma mark - 打开关闭规格
- (void)ClickSelectSpecificationWithIndexPath:(NSIndexPath *)indexPath {
    
    [(UITableView *)self.frontScrollView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    if (scrollView == self.backScrollView) {

        self.navBarView.backgroundColor = [UIColor colorWithWhite:1 alpha:scrollView.contentOffset.y/60.0];
    }
	
}

#pragma mark - 点击添加删除购物车
-(void)changeProcutNumberBagWithCount:(NSString *)count withIndexPath:(NSIndexPath *)indexPath andTypeIndex:(NSInteger)typeIndex withRect:(CGRect)rect{
    
    
    Goods * selectGoods = self.dataSourse.ProductionInfoList[typeIndex].goodsList[indexPath.section];
    Guige * selectGuige = selectGoods.guige[indexPath.row];
    
	selectGuige.carGoodNum = count;
	selectGuige.selected = YES;

	
	[[ShoppingCartManager sharedManager] addobjectWith:selectGoods withGuiGeIndex:indexPath.row];
	[CommonNotification postNotification:CNotificationShoppingCartNumberNotify userInfo:nil object:nil];

	
    if(count.integerValue == 0){
        NSLog(@"删除");
		
		[[ShoppingCartManager sharedManager] removeobjectWith:selectGoods withGuiGeIndex:indexPath.row];

		NSMutableArray * goodListArray = [[NSMutableArray alloc] init];
		NSMutableDictionary * goodInfoDict = [[NSMutableDictionary alloc] init];
		NSMutableArray * goodsSpecArray = [[NSMutableArray alloc] init];
		NSMutableDictionary * goodsSpecDict = [[NSMutableDictionary alloc] init];
		
		
		goodsSpecDict = @{@"id":selectGuige.guigeID}.mutableCopy;
		[goodsSpecArray addObject:goodsSpecDict];
		[goodInfoDict  setValue:selectGoods.goodsID forKey:@"id"];
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
                                                                      goodsId:self.dataSourse.ProductionInfoList[typeIndex].goodsList[indexPath.section].goodsID
                                                                       specId:self.dataSourse.ProductionInfoList[typeIndex].goodsList[indexPath.section].guige[indexPath.row].guigeID
                                                                          num:count
                                                     completionSuccessHandler:^(NSString *succeed)
        {
			
        } completionFailHandler:^(NSString *failMessage) {
            [self showToastWithMessage:failMessage showTime:1];
        } completionError:^(NSString *netWorkErrorMessage) {
            [self showToastWithMessage:netWorkErrorMessage showTime:1];
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
