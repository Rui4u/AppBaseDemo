//
//  OrderDetailViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/23.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"
#import "OrderDetailBussiness.h"
#import "OrderDetailModel.h"
#import "FillOrderNomailCell.h"
#import "NewCustomAlertView.h"
#import "CancelOrderBussiness.h"

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic ,strong ) OrderDetailModel * orderModel;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"订单详情"];
	self.mainTableView.dataSource = self;
	self.mainTableView.delegate = self;
	
	[OrderDetailBussiness requestOrderDetailWithToken:TOKEN orderId:self.orderId completionSuccessHandler:^(OrderDetailModel *getSelectedProductModel)
	{
		self.orderModel = getSelectedProductModel;
		[self.mainTableView reloadData];
	} completionFailHandler:^(NSString *failMessage) {
		
	} completionError:^(NSString *netWorkErrorMessage) {
		
	}];
}
- (IBAction)cancelOrder:(id)sender {
	UILabel * view = [UILabel creatLabelWithText:@"是否取消订单" FontOfSize:14 textColor:@"333333"];
	NewCustomAlertView * newCustomAlertView = [[NewCustomAlertView alloc] init];
	newCustomAlertView.alertViewWidth  = SCREEN_WIDTH - 24;
	newCustomAlertView.contentView = view;
	newCustomAlertView.contentViewHeight = 50 + 15;
	newCustomAlertView.buttonTitleArray  = @[@"取消",@"确定"];
	newCustomAlertView.buttonColorArray = @[@"333333",Main_Font_Green_Color];
	newCustomAlertView.titleLabelText = @"取消订单";
	[newCustomAlertView reloadData];
	
	newCustomAlertView.clickBlock = ^(NSInteger index) {
		
		if (index == 1) {
			[CancelOrderBussiness requestCancelOrderWithToken:TOKEN orderId:self.orderId completionSuccessHandler:^(NSDictionary *dict) {
				
				[self showToastWithMessage:@"取消成功" showTime:1];
				
				[self.navigationController popViewControllerAnimated:YES];
				
				if (self.cancelBlock) {
					self.cancelBlock();
				}
				
			} completionFailHandler:^(NSString *failMessage) {
				
			} completionError:^(NSString *netWorkErrorMessage) {
				
			}];
		}
	};

	
	
}
- (IBAction)buyAgain:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	if (section == 0) {
		
	UIView * view = [[UIView alloc] init];
		
		UILabel * label = [[UILabel alloc] init];
		label.text =[NSString stringWithFormat:@"订单号:%@",self.self.orderModel.orderDetails.orderId];
		label.textAlignment = NSTextAlignmentLeft;
		label.frame = CGRectMake(10, 0, SCREEN_WIDTH, 30);
		[view addSubview:label];
		
		UILabel * statuslabel = [[UILabel alloc] init];
		statuslabel.text =[NSString stringWithFormat:@"%@",self.self.orderModel.orderDetails.orderStatus];
		statuslabel.textAlignment = NSTextAlignmentRight;
		statuslabel.frame = CGRectMake(-10, 0, SCREEN_WIDTH, 30);
		[view addSubview:label];
		
		return view;
	}else {
		
		return  [[UIView alloc] init];
	}
}

#pragma mark - UITableViewDataSourse

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		
		return 30;
	}else {
		return 10;
	}
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return .1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) return self.orderModel.orderDetails.goods.count;
	else  if (section == 1) return 3;
	else  if (section == 2) return 4;
	else return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//    return self.orderListData.count;
	return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section ==0) {
		
		if (self.orderModel.orderDetails.goods.count == 1) {
			return 58;
		}else {
			return 58 + (self.orderModel.orderDetails.goods[indexPath.row].goodsSpec.count - 1) * 21;
			
		}
	}else {
		return 37;
	}
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.section ==0) {
		OrderDetailTableViewCell * cell;
		
		cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailTableViewCellID"];
		if (cell == nil) {
			cell= (OrderDetailTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"OrderDetailTableViewCell" owner:self options:nil]  lastObject];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
		}
		
		cell.good = self.orderModel.orderDetails.goods[indexPath.row];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		return cell;
		
	}else {
	
		FillOrderNomailCell * cell;
		
		cell = [tableView dequeueReusableCellWithIdentifier:@"FillOrderNomailCellID"];
		if (cell == nil) {
			cell= (FillOrderNomailCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"FillOrderNomailCell" owner:self options:nil]  lastObject];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
		}
		NSArray * array;
		if (indexPath.section == 1) {
			
			if(self.orderModel.orderDetails.totalPrice != nil && self.orderModel.orderDetails.totalPrice!= nil
			   ) {
				array = @[@[@"下单商品金额",self.orderModel.orderDetails.totalPrice],
						  @[@"运费",@"无可用运费券"],
						  @[@"总计",self.orderModel.orderDetails.totalPrice]];
				
			}
			
		}else{
			if(self.orderModel.orderDetails.trueName != nil && self.orderModel.orderDetails.storeAddress!= nil &&
			   self.orderModel.orderDetails.addTime != nil
			   ) {
			array = @[@[@"收货人",self.orderModel.orderDetails.trueName],
					  @[@"收货地址",self.orderModel.orderDetails.storeAddress],
					  @[@"下单时间",self.orderModel.orderDetails.addTime],
					  @[@"预计送达",@"预计送达"]];

			}
		}
		cell.dataSourse = array[indexPath.row];
		return cell;
	}
}





@end
