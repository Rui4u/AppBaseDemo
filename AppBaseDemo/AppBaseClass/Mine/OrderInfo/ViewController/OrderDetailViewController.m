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
#import "PaySelectVC.h"

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (nonatomic ,copy ) NSString * statusStr;
@property (nonatomic ,strong ) OrderDetailModel * orderModel;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"订单详情"];
	self.mainTableView.dataSource = self;
	self.mainTableView.delegate = self;
	
	[OrderDetailBussiness requestOrderDetailWithToken:TOKEN orderId:self.orderId completionSuccessHandler:^(OrderDetailModel *getSelectedProductModel)
	{
		self.orderModel = getSelectedProductModel;
		
		
		if (getSelectedProductModel.orderDetails.orderStatus.intValue == 0) {
			[self.rightButton setTitle:@"取消进度" forState:UIControlStateNormal];
			_statusStr = @"待配货";

		}else if (getSelectedProductModel.orderDetails.orderStatus.integerValue == 1) {
			[self.rightButton setTitle:@"取消进度" forState:UIControlStateNormal];
			_statusStr = @"待发货";

		}else if (getSelectedProductModel.orderDetails.orderStatus.integerValue == 2) {
			[self.rightButton setTitle:@"去结算" forState:UIControlStateNormal];
			_statusStr = @"待收货";

		}else if (getSelectedProductModel.orderDetails.orderStatus.integerValue == 3) {
			[self.rightButton setTitle:@"订单已完成" forState:UIControlStateNormal];
			_statusStr = @"已完成";

		}else if (getSelectedProductModel.orderDetails.orderStatus.integerValue == 4) {
			[self.rightButton setTitle:@"订单已取消" forState:UIControlStateNormal];
			_statusStr = @"已取消";

		}
		
		[self.mainTableView reloadData];
	} completionFailHandler:^(NSString *failMessage) {
		
	} completionError:^(NSString *netWorkErrorMessage) {
		
	}];
}
- (IBAction)cancelOrder:(UIButton *)sender {
	
	if ([sender.titleLabel.text isEqualToString:@"取消进度"]) {
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

	}else {
		
		
		PaySelectVC * paySelectVC = [[PaySelectVC alloc] init];
		paySelectVC.totolPrice = self.orderModel.orderDetails.totalPrice;
		paySelectVC.orderNumber = self.orderId;
		paySelectVC.orderIdNumber = self.orderModel.orderDetails.orderId;
		[self.navigationController pushViewController:paySelectVC animated:YES];
		
	}
	
	
	
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
        view.backgroundColor = [UIColor colorWithHexString:Main_BackGround_Color];
		UILabel * label = [UILabel creatLabelWithText:self.statusStr FontOfSize:12 textColor:@"333333"];
		label.text =[NSString stringWithFormat:@"订单号:%@",self.self.orderModel.orderDetails.orderId];
		label.textAlignment = NSTextAlignmentLeft;
		label.frame = CGRectMake(10, 0, SCREEN_WIDTH, 35);
		[view addSubview:label];
		
		UILabel * statuslabel = [UILabel creatLabelWithText:self.statusStr FontOfSize:12 textColor:@"333333"];
		statuslabel.textAlignment = NSTextAlignmentRight;
		statuslabel.frame = CGRectMake(-10, 0, SCREEN_WIDTH, 35);
		[view addSubview:statuslabel];
		
		return view;
	}else {
		
		return  [[UIView alloc] init];
	}
}

#pragma mark - UITableViewDataSourse

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		
		return 35;
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
		return 58 + (self.orderModel.orderDetails.goods[indexPath.row].goodsSpec.count - 1) * 25;
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
        cell.backgroundColor = [UIColor whiteColor];
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
			NSString * trueName;
			NSString * storeAddress;
			NSString * addTime;
			if(self.orderModel.orderDetails.trueName == nil){
				trueName = @"";
			}else {
				trueName = self.orderModel.orderDetails.trueName;
			}
			if(self.orderModel.orderDetails.storeAddress== nil){
				storeAddress = @"";
			}else {
				storeAddress = self.orderModel.orderDetails.storeAddress;
				
			}
			if(self.orderModel.orderDetails.addTime == nil){
				addTime = @"";
			}else {
				addTime = self.orderModel.orderDetails.addTime;
			}
			
			array = @[@[@"收货人",trueName],
					  @[@"收货地址",storeAddress],
					  @[@"下单时间",addTime],
					  @[@"预计送达",@"一天后"]];

		}
        cell.backgroundColor = [UIColor whiteColor];
		cell.dataSourse = array[indexPath.row];
		return cell;
	}
}





@end
