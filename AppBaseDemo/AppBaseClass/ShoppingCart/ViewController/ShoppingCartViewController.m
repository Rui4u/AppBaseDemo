//
//  ShoppingCartViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartGuiGeTableViewCell.h"
#import "ShoppingCartGoodsTableViewCell.h"
#import "ShoppingCartListBussiness.h"
#import "ShoppingCartListModel.h"
#import "ShopCartListBottomView.h"
@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong ) UITableView * mainTableView;

/**
 <#Description#>
 */
@property (nonatomic ,strong) ShoppingCartListModel *shoppingCartListModel;

/**
 ShopCartListBottomView *shopCartListBottomView
 */
@property (nonatomic ,strong) ShopCartListBottomView *shopCartListBottomView ;
@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTableView];
    [self initNavBarView:NAV_BAR_TYPE_ROOT_VIEW];
    [self.navBarView setTitle:@"购物车"];

    self.mainTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullToRefresh)];
    [self.mainTableView.mj_header beginRefreshing];

    _shopCartListBottomView = ({
        ShopCartListBottomView *shopCartListBottomView =[[NSBundle mainBundle] loadNibNamed:@"ShopCartListBottomView" owner:self options:nil].lastObject;
        shopCartListBottomView;
    });
    
    [self.view addSubview:_shopCartListBottomView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _shopCartListBottomView.frame = CGRectMake(0, _mainTableView.bottom, SCREEN_WIDTH, 50);
}
- (void)pullToRefresh {

    [ShoppingCartListBussiness requestShoppingCartListWithToken:TOKEN completionSuccessHandler:^(ShoppingCartListModel *shoppingCartListModel) {
        self.shoppingCartListModel = shoppingCartListModel;
        [self.mainTableView reloadData];
        [self.mainTableView.mj_header endRefreshing];
    } completionFailHandler:^(NSString *failMessage) {
        
    } completionError:^(NSString *netWorkErrorMessage) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 72;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _shoppingCartListModel.CarInfoList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shoppingCartListModel.CarInfoList[section].guige.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString * const ShoppingCartGuiGeTableViewCellID = @"ShoppingCartGuiGeTableViewCell";
    
    ShoppingCartGuiGeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCartGuiGeTableViewCellID];;
    if (cell == nil) {
    
        cell= (ShoppingCartGuiGeTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"ShoppingCartGuiGeTableViewCell" owner:self options:nil]  lastObject];

    }
    cell.indexPath = indexPath;;
    cell.dataSourse = _shoppingCartListModel.CarInfoList[indexPath.section];
    
    __weak typeof(self) weakSelf = self;
    cell.selectShoppingCartGuiGeBlock = ^(NSIndexPath *indexPath) {
        
        NSInteger totolNum = 0;
        CGFloat totolNumPrice = 0;
        BOOL selectAll = YES;
        for (Guige * guige in weakSelf.shoppingCartListModel.CarInfoList[indexPath.section].guige ) {
            if (guige.isSelected == NO) {
                selectAll = NO;
            }else {
                totolNum += guige.carGoodNum.integerValue;
                totolNumPrice += (guige.carGoodNum.integerValue *guige.currentPrice.floatValue);
            }
        }
        
        weakSelf.shoppingCartListModel.CarInfoList[indexPath.section].selectNum = [NSString stringWithFormat:@"%ld",totolNum];
        weakSelf.shoppingCartListModel.CarInfoList[indexPath.section].totolPriceNum = [NSString stringWithFormat:@"%.2f",totolNumPrice];
        if (selectAll) { //产品全选
            weakSelf.shoppingCartListModel.CarInfoList[indexPath.section].selected = YES;
        }else {
            weakSelf.shoppingCartListModel.CarInfoList[indexPath.section].selected = NO;
        }
        [weakSelf.mainTableView reloadData];
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ShoppingCartGoodsTableViewCell * shoppingCartGoodsTableViewCell=  [[[NSBundle  mainBundle]  loadNibNamed:@"ShoppingCartGoodsTableViewCell" owner:self options:nil]  lastObject];
    shoppingCartGoodsTableViewCell.dataSourse = _shoppingCartListModel.CarInfoList[section];
    
    shoppingCartGoodsTableViewCell.selectShoppingCartGoodsBlock = ^(NSIndexPath *indexPath) {
      
        [self.mainTableView reloadData];
    };
    return shoppingCartGoodsTableViewCell;
    
}


- (UITableView *)mainTableView {
    
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NAV_BAR_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - NAV_BAR_HEIGHT - 49 - 50) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _mainTableView;
}



@end
