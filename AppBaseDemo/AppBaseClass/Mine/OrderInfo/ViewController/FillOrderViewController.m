//
//  FillOrderViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "FillOrderViewController.h"
#import "FillOrderUserInfoCell.h"
#import "ProductCategoryCell.h"
#import "FillOrderSelectTableViewCell.h"
#import "FillOrderNomailCell.h"
#import "FillOrderBussiness.h"
#import "FillOrderModel.h"
#import "FillOrderBottomView.h"
#import "DoOrderBussiness.h"
#import "DealWithShoppingCartData.h"
@interface FillOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *mainTableView;

/**
 <#Description#>
 */
@property (nonatomic ,strong) FillOrderModel *getFillOrderModel;

/**
 ui
 */
@property (nonatomic ,strong) UIButton * lastsButton;
@end

@implementation FillOrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.mainTableView];
    
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    [self.navBarView setTitle:@"完善信息"];
    
    FillOrderBottomView * fillOrderBottomView  = [[[NSBundle mainBundle] loadNibNamed:@"FillOrderBottomView" owner:self options:nil] lastObject];
    fillOrderBottomView.frame =CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    [self.view addSubview:fillOrderBottomView];
	
	fillOrderBottomView.submitButtonBlock = ^{
		
		
		NSArray * array = [DealWithShoppingCartData dealWithShoppingCartDataWith:[ShoppingCartManager sharedManager].CarInfoList];
		
		[DoOrderBussiness requestDoOrderWithToken:TOKEN addressId:self.getFillOrderModel.store.storeId orederType:@"1" carImageInfo:array completionSuccessHandler:^(NSDictionary *dict) {
			
		} completionFailHandler:^(NSString *failMessage) {
			
		} completionError:^(NSString *netWorkErrorMessage) {
			
		}];
		
	};
	
    [FillOrderBussiness requestFillOrderWithToken:TOKEN goodsList:self.calculationArray completionSuccessHandler:^(FillOrderModel *getFillOrderModel) {
        self.getFillOrderModel = getFillOrderModel;
        fillOrderBottomView.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.getFillOrderModel.totalcurrentPrice];
        [self.mainTableView reloadData];
        
    } completionFailHandler:^(NSString *failMessage) {
        
    } completionError:^(NSString *netWorkErrorMessage) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSourse

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray * array;
    if (section == 2) {
        NSArray * array = @[/*@"在线支付",*/@"货到付款"];
        return array.count;
    }
    if (section == 3) {
        array = @[@[@"优惠券",@"无可用优惠券"],
                  @[@"运费减免",@"无可用运费券"]];
        return array.count;

    }else if(section == 4){
        array = @[@[@"下单信息总额",@"无可用优惠券"],
                  @[@"运费",@"无可用运费券"],
                  @[@"运费优惠",@"无可用优惠券"],
                  @[@"小计",@"无可用运费券"]];
        return array.count;

    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.orderListData.count;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        FillOrderUserInfoCell * cell;
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"FillOrderUserInfoCellID"];
        if (cell == nil) {
            cell= (FillOrderUserInfoCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"FillOrderUserInfoCell" owner:self options:nil]  lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.store = self.getFillOrderModel.store;

        return cell;
    }else if (indexPath.section == 1) {
        ProductCategoryCell * cell;
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCategoryCellID"];
        if (cell == nil) {
            cell= (ProductCategoryCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"ProductCategoryCell" owner:self options:nil]  lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.carInfo = self.getFillOrderModel.carImageInfo.carInfo;

        
        return cell;
    }else if (indexPath.section == 2){
    
        FillOrderSelectTableViewCell * cell;
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"FillOrderSelectTableViewCellID"];
        if (cell == nil) {
            cell= (FillOrderSelectTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"FillOrderSelectTableViewCell" owner:self options:nil]  lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
        }
        cell.selectButtonBlock = ^(UIButton *sender) {
            self.lastsButton.selected = NO;
            sender.selected = YES;
            self.lastsButton = sender;
        };
        
    NSArray * array = @[@"在线支付",@"货到付款"];
    cell.textString = array[indexPath.row];
        return cell;
    }else {

    
        FillOrderNomailCell * cell;
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"FillOrderNomailCellID"];
        if (cell == nil) {
            cell= (FillOrderNomailCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"FillOrderNomailCell" owner:self options:nil]  lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        NSArray * array;
        if (indexPath.section == 3) {
            array = @[@[@"优惠券",@"无可用优惠券"],
                    @[@"运费减免",@"无可用运费券"]];
        }else {
            
            array = @[@[@"下单信息总额",[NSString stringWithFormat:@"￥%@",self.getFillOrderModel.totalPrice]],
                      @[@"运费",[NSString stringWithFormat:@"￥%@",self.getFillOrderModel.totalcashPeldge]],
                      @[@"运费优惠",[NSString stringWithFormat:@"-￥%@",self.getFillOrderModel.totalcashPeldge]],
                      @[@"小计",[NSString stringWithFormat:@"￥%@",self.getFillOrderModel.totalcurrentPrice]]];
        }
        if(indexPath.row == 3) {
            cell.rightLable.textColor = [UIColor colorWithHexString:Main_Font_Red_Color];
        }else {
            cell.rightLable.textColor = [UIColor colorWithHexString:Main_Font_Gary_Color];
        }
        cell.dataSourse = array[indexPath.row];
        return cell;
    
    }
    
}


- (UITableView *)mainTableView {
    
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT -NAV_BAR_HEIGHT - 50) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 200;
    }
    
    return _mainTableView;
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
