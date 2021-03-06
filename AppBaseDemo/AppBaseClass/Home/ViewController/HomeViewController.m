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
#import "NewCustomAlertView.h"
#import "OrderListViewController.h"
#import "ServerCenterViewController.h"
#import "CheackVersionBussiness.h"
#import "NewCustomAlertView.h"
#import "ActivityBussiness.h"
#import "ActivityViewController.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomeProductListTableViewCellDelegate,SelectTypeViewDelegate>
@property (nonatomic ,strong ) HomeTopView * topView;
@property (nonatomic ,strong ) SelectTypeView * selectTypeView;
/**
 数据源
 */
@property (nonatomic ,strong) HomeDataModel *dataSourse;
@property (nonatomic ,assign ) NSInteger count;
@property (nonatomic ,strong ) UIButton * rightButton;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}
- (void)CNRefreashHomeData {

    [self.backScrollView.mj_header beginRefreshing];
	[_rightButton setTitle:CITYNAME forState:UIControlStateNormal];
	 
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(CNRefreashHomeData)
                                                 name:CNRefreashHomeData
                                               object:nil];
    
    // Do any additional setup after loading the view.
	self.topView= [[HomeTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_AUTO(309))];
	__weak typeof(self) weakself = self;
	self.topView.topSelected = ^(NSInteger index) {
		if (index == 0) {
			APP_DELEGATE.customTabBar.tabBarView.selectedIndex = 1;
		}else if (index == 1) {
			APP_DELEGATE.customTabBar.tabBarView.selectedIndex = 2;
		}else if (index == 2) {
			//订单
			OrderListViewController * orderListViewController = [[OrderListViewController alloc] init];
			orderListViewController.state = @"1";
			[weakself.navigationController pushViewController:orderListViewController animated:YES];
			
			
		}
	};
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
	self.DraggingHeight = 10 ;
    [self initNavBarView:NAV_BAR_TYPE_ROOT_VIEW];
    

	self.backScrollView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullToRefresh)];
	[self.backScrollView.mj_header beginRefreshing];
	
	
	[self initSearchBarViewWithPlaceholder:@"鸡蛋"
							withSearchType:SearchType_Push];
    self.searchBar.searchBarBackgroundColor = [UIColor colorWithWhite:0 alpha:.3];

	
	_rightButton = ({
		UIButton * rightButton = [UIButton quickCreateButtonWithFrame:CGRectMake(SCREEN_WIDTH-AutoHeight(50)- 5, 20 + (44 - 30)/2, AutoHeight(50), 30)
																title:@"位置"
															addTarget:self
															   action:@"selectedLocation"];
		rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
		rightButton.layer.masksToBounds = YES;
		rightButton.layer.cornerRadius = 15;
		rightButton.backgroundColor = [UIColor colorWithWhite:0 alpha:.3];
		[rightButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
		rightButton;
	});
	[self.navBarView addSubview:_rightButton];
	

	UIButton * leftButton = [UIButton quickCreateButtonWithFrame:CGRectMake(15, 20 + (44 - 30)/2, 30, 30)
															title:@""
														addTarget:self
														   action:@"selectedSevire"];
	[leftButton setImage:[UIImage imageNamed:@"homeleftButton"] forState:UIControlStateNormal];
	leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
	leftButton.layer.masksToBounds = YES;
	leftButton.layer.cornerRadius = 15;
	leftButton.backgroundColor = [UIColor colorWithWhite:0 alpha:.3];
	[self.navBarView addSubview:leftButton];
	
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"%@",infoDictionary);
    
    
    self.topView.clickHuodongSucceed = ^(NSString *huodongId) {
        
        if (isNotLogin) {
            [self showLoginViewController:nil];
            [self.backScrollView.mj_header endRefreshing];
            return;
        }
        ActivityViewController * search = [[ActivityViewController alloc] init];
        search.huodongId = huodongId;
        [self.navigationController pushViewController:search animated:YES];
      
       
    };
    
    
    [CheackVersionBussiness requestCheackVersionWithVersionMumber:app_build completionSuccessHandler:^(NSDictionary *upadataInfo) {
        if ([upadataInfo objectForKey:@"isSucceed"]) {
//
            
            UILabel * view = [UILabel creatLabelWithText:@"有新版本更新,是否进入App Store进行更新" FontOfSize:14 textColor:@"333333"];
            NewCustomAlertView * newCustomAlertView = [[NewCustomAlertView alloc] init];
            newCustomAlertView.alertViewWidth  = SCREEN_WIDTH - 24;
            newCustomAlertView.contentView = view;
            newCustomAlertView.contentViewHeight = 50 + 15;
            newCustomAlertView.buttonTitleArray  = @[@"取消",@"确定"];
            newCustomAlertView.buttonColorArray = @[@"333333",Main_Font_Green_Color];
            newCustomAlertView.titleLabelText = @"提示";
            [newCustomAlertView reloadData];
            
            newCustomAlertView.clickBlock = ^(NSInteger index) {
                
                if (index == 1) {
                    
                    NSString * string = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@",@"1288390411"];//app id
                    NSURL * url = [NSURL URLWithString:string];
                    
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        if (iOS10Later) {
                            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                                NSLog(@"success = %d",success);
                            }];
                        }else{
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }
                    
                }else {
                    
                }
            };
        }else {
            
            
        }

    } completionFailHandler:^(NSString *failMessage) {
        
    } completionError:^(NSString *netWorkErrorMessage) {
        
    }];
}
- (void)selectedSevire {
	
	ServerCenterViewController * serverCenterViewController = [[ServerCenterViewController alloc] init
															   ];
	[self.navigationController pushViewController:serverCenterViewController animated:YES];
	
}

- (void)selectedLocation {
        if (isNotLogin) {
            [self showLoginViewController:nil];
            [self.backScrollView.mj_header endRefreshing];
            return;
        }
	
	UserLocationViewController * userLocationViewController = [[UserLocationViewController alloc] init];
	[self.navigationController pushViewController:userLocationViewController animated:YES];
	userLocationViewController.locationBlock = ^(NSDictionary *dict) {
		saveDataUserDefaultForValueKey([dict objectForKey:@"adCode"] , @"cityCode");
		[_rightButton setTitle:[dict objectForKey:@"city"] forState:UIControlStateNormal];
		[self.backScrollView.mj_header beginRefreshing];

	};
}
#pragma mark - 网络请求
- (void)pullToRefresh {
//
//    if (isNotLogin) {
//        [self showLoginViewController:nil];
//        [self.backScrollView.mj_header endRefreshing];
//        return;
//    }
//
    
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

	

    [ProductRemoveListBussiness requestProductRemoveListWithToken:TOKEN goodsId:self.dataSourse.ProductionInfoList[indexPath.section].goodsList[indexPath.row].goodsId completionSuccessHandler:^(BOOL succeed) {
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
    productDetailViewController.goodsId = self.dataSourse.ProductionInfoList[indexPath.section].goodsList[indexPath.row].goodsId;
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


	
    if(count.integerValue == 0){
        NSLog(@"删除");
		
		[[ShoppingCartManager sharedManager] removeobjectWith:selectGoods withGuiGeIndex:indexPath.row];

		NSMutableArray * goodListArray = [[NSMutableArray alloc] init];
		NSMutableDictionary * goodInfoDict = [[NSMutableDictionary alloc] init];
		NSMutableArray * goodsSpecArray = [[NSMutableArray alloc] init];
		NSMutableDictionary * goodsSpecDict = [[NSMutableDictionary alloc] init];
		
		
		goodsSpecDict = @{@"id":selectGuige.guigeID}.mutableCopy;
		[goodsSpecArray addObject:goodsSpecDict];
		[goodInfoDict  setValue:selectGoods.goodsId forKey:@"id"];
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
                                                                      goodsId:self.dataSourse.ProductionInfoList[typeIndex].goodsList[indexPath.section].goodsId
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
    
    	[CommonNotification postNotification:CNotificationShoppingCartNumberNotify userInfo:nil object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
