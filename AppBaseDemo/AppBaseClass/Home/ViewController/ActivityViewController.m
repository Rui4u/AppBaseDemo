//
//  ActivityViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/10/1.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ActivityViewController.h"
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
#import "ActivityBussiness.h"
@interface ActivityViewController ()<UITableViewDelegate,UITableViewDataSource,HomeProductListTableViewCellDelegate,SelectTypeViewDelegate>
@property (nonatomic ,strong ) UITableView * tableViewList;
@property (nonatomic ,assign ) NSInteger count;


/**
 数据源
 */
@property (nonatomic ,strong) HomeDataModel * dataSourse;

@end

@implementation ActivityViewController

- (void)CNRefreashHomeData {
    [self.tableViewList.mj_header beginRefreshing];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    
    
    _tableViewList = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    
    _tableViewList.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableViewList.dataSource = self;
    _tableViewList.delegate = self;
    _tableViewList.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [self.view addSubview:_tableViewList];
    [self.tableViewList reloadData];
    
    [self.navBarView setTitle:@"活动"];
    
    
    [ActivityBussiness requestActivityWithToken:TOKEN
                                     activityId:self.huodongId
                       completionSuccessHandler:^(HomeDataModel *model)
     
     {
         self.dataSourse = model;
         [self.tableViewList reloadData];
     } completionFailHandler:^(NSString *failMessage) {
        
     } completionError:^(NSString *netWorkErrorMessage) {
        
     }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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

    return cell;
    
    
    
}
#pragma mark 删除清单
- (void)clickDeteleGoodsWith:(NSIndexPath *)indexPath {
    
    
    
    [ProductRemoveListBussiness requestProductRemoveListWithToken:TOKEN goodsId:self.dataSourse.ProductionInfoList[indexPath.section].goodsList[indexPath.row].goodsId completionSuccessHandler:^(BOOL succeed) {
        NSLog(@"删除清单成功");
        [self.dataSourse.ProductionInfoList[indexPath.section].goodsList removeObjectAtIndex:indexPath.row];
        
        [self.tableViewList reloadData];
        
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
    [(UITableView *)self.tableViewList scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.tableViewList.contentOffset = CGPointMake(0,0);
    
}


#pragma mark - 打开关闭规格
- (void)ClickSelectSpecificationWithIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableViewList reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
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


@end
