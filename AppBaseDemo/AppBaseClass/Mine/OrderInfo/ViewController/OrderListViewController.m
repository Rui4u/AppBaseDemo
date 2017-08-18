//
//  OrderListViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/18.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListBussiness.h"
#import "MyOrderListTableViewCell.h"
#import "CustomScrollSelectView.h"
#import "OrderListModel.h"
@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource,CustomScrollSelectViewDelegate>

@property (nonatomic ,strong ) UITableView * mainTableView;

@property (nonatomic ,strong ) NSArray<OrderList *> * orderListData;

@property (nonatomic ,strong ) CustomScrollSelectView * customScrollSelectView;
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"我的订单"];
	
	_customScrollSelectView = ({
		CustomScrollSelectView * selectView= [[CustomScrollSelectView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, 48)];
		selectView.textColor = [UIColor blackColor];
		selectView.backgroundColor = [UIColor whiteColor];
		selectView.delegate = self;
		selectView.customTextAlignment = CustomTextAlignmentCenter;
		selectView.dataSourse = @[@"全部",@"待付款",@"待发货",@"待收货"];
		[selectView reloadeData];
		[selectView selectSwitchButtonAtIndex:0 withClick:YES];
		selectView;
	});
	[self.view addSubview:_customScrollSelectView];
	
	UIView * lineView  = [[UIView alloc] init];
	lineView.backgroundColor = [UIColor colorWithHexString:Main_Line_Gary_Color];
	[self.navBarView addSubview:lineView];
	
	[lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(.5);
		make.left.equalTo(self.navBarView.mas_left);
		make.right.equalTo(self.navBarView.mas_right);
		make.bottom.equalTo(self.navBarView.mas_bottom);
	}];

	[self.view addSubview:self.mainTableView];

	
    // Do any additional setup after loading the view.
	
}

- (void)customScrollSelectView:(CustomScrollSelectView *)customScrollSelectView didSelectWithProductTypeModel:(NSInteger)index {

	[self requestOrderList];

}

- (void)requestOrderList {

	[OrderListBussiness requestOrderListWithToken:TOKEN state:@""
						 completionSuccessHandler:^(OrderListModel *getSelectedProductModel) {
							 self.orderListData = getSelectedProductModel.orderList;
							 [self.mainTableView reloadData];
						 } completionFailHandler:^(NSString *failMessage) {
							 [self showToastWithMessage:failMessage showTime:1];
						 } completionError:^(NSString *netWorkErrorMessage) {
							 [self showToastWithMessage:netWorkErrorMessage showTime:1];
						 }];
}

#pragma mark - UITableViewDataSourse

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return .1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 1;
	
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.orderListData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	MyOrderListTableViewCell * cell;
	
	
	cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderListTableViewCellID"];
	if (cell == nil) {
		cell= (MyOrderListTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"MyOrderListTableViewCell" owner:self options:nil]  lastObject];
	
	}
	cell.orderListInfo = self.orderListData[indexPath.section];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;

	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 195;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)mainTableView {
	
	if (!_mainTableView) {
		_mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NAV_BAR_HEIGHT + 48, SCREEN_WIDTH, SCREEN_HEIGHT -NAV_BAR_HEIGHT - 48) style:UITableViewStyleGrouped];
		_mainTableView.delegate = self;
		_mainTableView.dataSource = self;
		_mainTableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
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
