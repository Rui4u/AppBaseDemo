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
#import "DealWithShoppingCartData.h"
#import "CountPriceBussiness.h"
#import "CountPriceModel.h"
#import "FillOrderViewController.h"
#import "ShoppingCartChangeNumBussiness.h"
#import "DeleteCartBusiness.h"
@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource,ShoppingCartGuiGeTableViewCellDelegate,ShopCartListBottomViewDelegate>
@property (nonatomic ,strong ) UITableView * mainTableView;


/**
 ShopCartListBottomView *shopCartListBottomView
 */
@property (nonatomic ,strong) ShopCartListBottomView *shopCartListBottomView ;

/**
 <#Description#>
 */
@property (nonatomic ,strong) NSArray * calculationArray;
@end

@implementation ShoppingCartViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mainTableView.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTableView];
    [self initNavBarView:self.navBarType];
    [self.navBarView setTitle:@"购物车"];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pullToRefresh)
                                                 name:CNReLoadeShoppingCart
                                               object:nil];
    
    self.mainTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullToRefresh)];

    _shopCartListBottomView = ({
        ShopCartListBottomView *shopCartListBottomView =[[NSBundle mainBundle] loadNibNamed:@"ShopCartListBottomView" owner:self options:nil].lastObject;
		shopCartListBottomView.delegate = self;
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
		[ShoppingCartManager sharedManager].CarInfoList = shoppingCartListModel.CarInfoList.mutableCopy;
        [self customReloadeData];
        [self.mainTableView.mj_header endRefreshing];
    } completionFailHandler:^(NSString *failMessage) {
        
    } completionError:^(NSString *netWorkErrorMessage) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ShoppingCartGuiGeTableViewCellchangeNumberWith:(NSString *)count withRect:(CGRect) rect withIndexPath:(NSIndexPath *)indexPath{
    
    
    
   
	 ShoppingCartGuiGeTableViewCell * cell = (ShoppingCartGuiGeTableViewCell *)[self.mainTableView cellForRowAtIndexPath:indexPath];
	
    if ([count isEqualToString:@"0"]) {
        
        
        
        
        Goods * selectGoods = [ShoppingCartManager sharedManager].CarInfoList[indexPath.section];
        Guige * selectGuige = selectGoods.guige[indexPath.row];
        
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
        
        //删除
        [[ShoppingCartManager sharedManager]removeobjectWith:[ShoppingCartManager sharedManager].CarInfoList[indexPath.section] withGuiGeIndex:indexPath.row];
        [self customReloadeData];

    }else {
    
        if(!cell.guigeSelectButton.selected) {
            [cell clickGuigeSelectButton:cell.guigeSelectButton];
        }else {
            [self detailSelectdWith:indexPath withTypeBlock:self];
        }
        
        [ShoppingCartChangeNumBussiness requestShoppingCartChangeNumWithToken:TOKEN
                                                                      goodsId:[ShoppingCartManager sharedManager].CarInfoList[indexPath.section].goodsId
                                                                       specId:[ShoppingCartManager sharedManager].CarInfoList[indexPath.section].guige[indexPath.row].guigeID
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
#pragma  mark - 去结算
- (void)goToSettle {

	if(_calculationArray.count == 0){
		[self showToastWithMessage:@"请选择商品" showTime:1];
		return;
	}
	
    FillOrderViewController * fillOrderViewController = [[FillOrderViewController alloc] init];
    fillOrderViewController.calculationArray = _calculationArray;
    [self.navigationController pushViewController:fillOrderViewController animated:YES];
    
}

- (void)clickSelectAllWithButtonSelected:(BOOL)selected {
    
    for (Goods *good in [ShoppingCartManager sharedManager].CarInfoList) {
        good.selected = selected;
        for (Guige * guige in good.guige) {
            guige.selected = selected;
        }
    }
    [self customReloadeData];
    
    NSLog(@"请求接口");
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 72;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ShoppingCartManager sharedManager].CarInfoList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ShoppingCartManager sharedManager].CarInfoList[section].guige.count;
}

- (void)detailSelectdWith:(NSIndexPath *)indexPath withTypeBlock:(ShoppingCartViewController *) weakSelf{
	
	NSInteger totolNum = 0;
	CGFloat totolNumPrice = 0;
	BOOL selectAll = YES;
	for (Guige * guige in [ShoppingCartManager sharedManager].CarInfoList[indexPath.section].guige ) {
		if (guige.isSelected == NO) {
			selectAll = NO;
		}else {
			totolNum += guige.carGoodNum.integerValue;
			totolNumPrice += (guige.carGoodNum.integerValue *guige.currentPrice.floatValue);
		}
	}
    
	
	[ShoppingCartManager sharedManager].CarInfoList[indexPath.section].selectNum = [NSString stringWithFormat:@"%ld",totolNum];
	[ShoppingCartManager sharedManager].CarInfoList[indexPath.section].totolPriceNum = [NSString stringWithFormat:@"%.2f",totolNumPrice];
	if (selectAll) { //产品全选
		[ShoppingCartManager sharedManager].CarInfoList[indexPath.section].selected = YES;
	}else {
		[ShoppingCartManager sharedManager].CarInfoList[indexPath.section].selected = NO;
	}
	[weakSelf customReloadeData];
	NSLog(@"请求接口");
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString * const ShoppingCartGuiGeTableViewCellID = @"ShoppingCartGuiGeTableViewCell";
    
    ShoppingCartGuiGeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCartGuiGeTableViewCellID];;
    if (cell == nil) {
    
        cell= (ShoppingCartGuiGeTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"ShoppingCartGuiGeTableViewCell" owner:self options:nil]  lastObject];

    }
    cell.indexPath = indexPath;;
	__weak typeof(self) weakSelf = self;
    cell.dataSourse = [ShoppingCartManager sharedManager].CarInfoList[indexPath.section];
	cell.delegate = self;
    cell.selectShoppingCartGuiGeBlock = ^(NSIndexPath *indexPath) {
		[self detailSelectdWith:indexPath withTypeBlock:weakSelf];
        
            };
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	
	ShoppingCartGoodsTableViewCell *header = (ShoppingCartGoodsTableViewCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShoppingCartGoodsTableViewCellID"];
	if (header == nil) {
		header =  [[[NSBundle  mainBundle]  loadNibNamed:@"ShoppingCartGoodsTableViewCell" owner:self options:nil]  lastObject];
		
	}

    header.dataSourse = [ShoppingCartManager sharedManager].CarInfoList[section];
    
    header.selectShoppingCartGoodsBlock = ^(NSIndexPath *indexPath) {
      
        [self customReloadeData];
		NSLog(@"请求接口");
    };
    return header;
    
}



- (UITableView *)mainTableView {
    
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NAV_BAR_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - NAV_BAR_HEIGHT - 49 - 50) style:UITableViewStyleGrouped];
        
        if (self.navBarType == NAV_BAR_TYPE_SECOND_LEVEL_VIEW) {
         _mainTableView.frame =  CGRectMake(0,NAV_BAR_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - NAV_BAR_HEIGHT - 50);
        }
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _mainTableView;
}

- (void)customReloadeData {

    [CommonNotification postNotification:CNotificationShoppingCartNumberNotify userInfo:nil object:nil];
    [self.mainTableView reloadData];
    
    
    NSArray * array = [DealWithShoppingCartData dealWithShoppingCartDataWith:[ShoppingCartManager sharedManager].CarInfoList];
    self.calculationArray = array;
    if (array.count == 0) {
        [self showToastWithMessage:@"请选择要结算的商品" showTime:1];
        
        _shopCartListBottomView.totalPrice.attributedText =
        [NSMutableAttributedString setAttributeString:[NSString stringWithFormat:@"总价:{￥0.00}"]
                                                 font:12
                                            textcolor:[UIColor colorWithHexString:Main_Font_Red_Color]
                                          secondcolor:[UIColor colorWithHexString:Main_Font_Black_Color]
                                           secondfont:12];
        _shopCartListBottomView.totalPrice.textAlignment = NSTextAlignmentRight;
        
        _shopCartListBottomView.depositLabel.text = [NSString stringWithFormat:@"含押金:￥0.00"];
		[self deleteSelected];
		return;
    }
    
    _shopCartListBottomView.isCalculation = YES;


    [CountPriceBussiness requestCountPriceWithToken:TOKEN status:@"1" goodsList:array completionSuccessHandler:^(CountPriceModel *getSelectedProductModel) {

            
    _shopCartListBottomView.isCalculation = NO;
        _shopCartListBottomView.totalPrice.attributedText =
        [NSMutableAttributedString setAttributeString:[NSString stringWithFormat:@"总价:{￥%@}",getSelectedProductModel.totalcurrentPrice]
                                                 font:12
                                            textcolor:[UIColor colorWithHexString:Main_Font_Red_Color]
                                          secondcolor:[UIColor colorWithHexString:Main_Font_Black_Color]
                                           secondfont:12];
        _shopCartListBottomView.totalPrice.textAlignment = NSTextAlignmentRight;
        
        _shopCartListBottomView.depositLabel.text = [NSString stringWithFormat:@"含押金:￥%@",getSelectedProductModel.totalcashPeldge];
        
        [ShoppingCartManager sharedManager].totolPrice = getSelectedProductModel.totalcurrentPrice;
    } completionFailHandler:^(NSString *failMessage) {
        _shopCartListBottomView.isCalculation = NO;
        [self showToastWithMessage:failMessage showTime:1];
        
	} completionError:^(NSString *netWorkErrorMessage) {
		_shopCartListBottomView.isCalculation = NO;
        [self showToastWithMessage:netWorkErrorMessage showTime:1];
	}];
	
	[self deleteSelected];
	
	
}
- (void)deleteSelected {
	
	NSArray *deleteArray = [DealWithShoppingCartData deleteDealWithShoppingCartDataWith:[ShoppingCartManager sharedManager].CarInfoList];

	[CountPriceBussiness requestCountPriceWithToken:TOKEN status:@"0" goodsList:deleteArray completionSuccessHandler:^(CountPriceModel *getSelectedProductModel) {
		
	} completionFailHandler:^(NSString *failMessage) {
		_shopCartListBottomView.isCalculation = NO;
		[self showToastWithMessage:failMessage showTime:1];
		
	} completionError:^(NSString *netWorkErrorMessage) {
		_shopCartListBottomView.isCalculation = NO;
		[self showToastWithMessage:netWorkErrorMessage showTime:1];
	}];
	
	


}
@end
