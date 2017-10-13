//
//  AcountContentListViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/10/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AcountContentListViewController.h"
#import "listByStoreIDBussiness.h"
#import "AddAccountViewController.h"
#import "AccountContentListCellTableViewCell.h"
#import "UpdateforaddressBussiness.h"
@interface AcountContentListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic ,strong ) NSArray * dataSourse;
@end

@implementation AcountContentListViewController
- (IBAction)clickAddContent:(id)sender {
	
	AddAccountViewController *addAccountViewController = [[AddAccountViewController alloc] init];
	[self.navigationController pushViewController:addAccountViewController animated:YES];
	
	addAccountViewController.reloadeDataBlock = ^{
		[self.mainTableView.mj_header beginRefreshing];
	};
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"联系人"];
	
	_mainTableView.delegate = self;
	_mainTableView.dataSource = self;
	_mainTableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];

	_mainTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullToRefresh)];
	[_mainTableView.mj_header beginRefreshing];}

- (void)pullToRefresh {
	
	[listByStoreIDBussiness requestlistByStoreIDWithToken:TOKEN completionSuccessHandler:^(NSDictionary *succeed) {
		self.dataSourse = [succeed objectForKey:@"storeAddressList"];
		[self.mainTableView reloadData];
		[_mainTableView.mj_header endRefreshing];
	} completionFailHandler:^(NSString *failMessage) {
		[_mainTableView.mj_header endRefreshing];
	} completionError:^(NSString *netWorkErrorMessage) {
		[_mainTableView.mj_header endRefreshing];
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataSourse.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString * const AccountContentListCellTableViewCellID = @"AccountContentListCellTableViewCellID";
	
		AccountContentListCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AccountContentListCellTableViewCellID];;
		if (cell == nil) {
	
			 cell= (AccountContentListCellTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"AccountContentListCellTableViewCell" owner:self options:nil] lastObject];
		}
	cell.name.text = [self.dataSourse[indexPath.row] objectForKey:@"trueName"];
	cell.phone.text = [self.dataSourse[indexPath.row] objectForKey:@"telPhone"];
	if ([[self.dataSourse[indexPath.row] objectForKey:@"addrDefault"] integerValue] == 1) {
		cell.button.selected = YES;
	}else {
		cell.button.selected = NO;
	}
	
	cell.submitButtonBlock = ^(NSString *name, NSString *phone) {
		[self updateforaddressId:[self.dataSourse[indexPath.row] objectForKey:@"addressId"]];
	};
	
	return cell;
}


- (void)updateforaddressId:(NSString *)addressId{
	
	[UpdateforaddressBussiness requestUpdateforaddressWithToken:TOKEN addressId:addressId completionSuccessHandler:^(NSDictionary *succeed) {
		
		[self showToastWithMessage:@"添加成功" showTime:1];
		[self.mainTableView.mj_header beginRefreshing];
	} completionFailHandler:^(NSString *failMessage) {
		
	} completionError:^(NSString *netWorkErrorMessage) {
		
	}];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	return [UIView new];
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
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
