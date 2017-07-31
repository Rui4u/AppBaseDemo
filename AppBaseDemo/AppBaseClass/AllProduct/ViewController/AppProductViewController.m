//
//  AppProductViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/31.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AppProductViewController.h"
#import "CustomScrollSelectView.h"
#import "AppProductViewControllerLeftCell.h"
@interface AppProductViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 左侧时间tableview
 */
@property (nonatomic ,strong ) UITableView *leftTimeQuantumTableView;

@property (nonatomic ,strong ) UITableView * mainTableView;

@property (nonatomic ,strong ) CustomScrollSelectView * customScrollSelectView;

/**
 上一个左侧cell
 */
@property (nonatomic ,strong ) AppProductViewControllerLeftCell * lastCell;

@end

@implementation AppProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initNavBarView:NAV_BAR_TYPE_ROOT_VIEW];
	
	
	self.customScrollSelectView = [[CustomScrollSelectView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, 48)];
	[self.view addSubview:self.customScrollSelectView];
	self.customScrollSelectView.dataSourse = @[@"肉禽类",@"新鲜蔬菜",@"米面粮油",@"肉禽类",@"新鲜蔬菜",@"米面粮油",@"肉禽类",@"新鲜蔬菜",@"米面粮油"];
	self.customScrollSelectView.textColor = [UIColor blackColor];
	[self.customScrollSelectView reloadeData];
	[self.customScrollSelectView selectSwitchButtonAtIndex:0];

	
	[self.view addSubview:self.mainTableView];
	[self.view addSubview:self.leftTimeQuantumTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didselectedMonthForRequestCommissionData {
	NSLog(@"左侧请求");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == _leftTimeQuantumTableView) {
		return 44;
	}else {
		return 70;
	}

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == _leftTimeQuantumTableView ) {
		
		static NSString * const AppProductViewControllerLeftCellID = @"AppProductViewControllerLeftCellID";
		
		AppProductViewControllerLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:AppProductViewControllerLeftCellID];;
		if (cell == nil) {
			cell = [[AppProductViewControllerLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AppProductViewControllerLeftCellID];
		}
		
		cell.nameLabel.text = @"1";
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		return cell;
		
	}else {
		static NSString * const UITableViewCellID = @"UITableViewCellID";
		
		UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID];;
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewCellID];
		}
		
		cell.textLabel.text = @"呵呵呵呵呵";
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		return cell;
	}

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if (tableView == _leftTimeQuantumTableView )
	{
		AppProductViewControllerLeftCell* cell = [tableView cellForRowAtIndexPath:indexPath];
		cell.nameLabel.textColor = [UIColor colorWithHexString:@"1ebfe5"];
		cell.contentView.backgroundColor = [UIColor whiteColor];
		
		if ([self.lastCell isEqual:cell]) {
			return;
		}
		
		self.lastCell.nameLabel.textColor = [UIColor colorWithHexString:@"7a7a7a"];
		self.lastCell.contentView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
		self.lastCell = cell;
		[self didselectedMonthForRequestCommissionData];
	}else
	{
		
	}
}

#pragma mark - 懒加载
- (UITableView *)leftTimeQuantumTableView {
	
	if (!_leftTimeQuantumTableView) {
		_leftTimeQuantumTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.customScrollSelectView.frame), 80, SCREEN_HEIGHT - (CGRectGetMaxY(self.customScrollSelectView.frame))) style:UITableViewStylePlain];
		_leftTimeQuantumTableView.delegate = self;
		_leftTimeQuantumTableView.dataSource = self;
		_leftTimeQuantumTableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
		[_leftTimeQuantumTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	}
	return _leftTimeQuantumTableView;
}

- (UITableView *)mainTableView {
	
	if (!_mainTableView) {
		_mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.leftTimeQuantumTableView.width,CGRectGetMaxY(self.customScrollSelectView.frame), SCREEN_WIDTH - self.leftTimeQuantumTableView.width, SCREEN_HEIGHT - CGRectGetMaxY(self.customScrollSelectView.frame)) style:UITableViewStylePlain];
		_mainTableView.delegate = self;
		_mainTableView.dataSource = self;
		_mainTableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
		_mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
	}
	
	return _mainTableView;
}

@end
