//
//  AccountViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/10/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountTableViewCell.h"
#import "UserInfoViewController.h"
@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic ,strong ) NSArray * titleArray;
@property (nonatomic ,strong ) NSArray<NSArray *> * rowTitleArray;
@end

@implementation AccountViewController
- (IBAction)clickChangeLocation:(id)sender {
	UserInfoViewController *userInfoVc = [[UserInfoViewController alloc] init];
	[self.navigationController pushViewController:userInfoVc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"账号信息"];
	
	_mainTableView.delegate = self;
	_mainTableView.dataSource = self;
	_mainTableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
	
	
	_titleArray =@[@"   账号信息",@"   门店信息",@"   收货信息"];
	_rowTitleArray= @[@[@"店标",@"主账号"],
					  @[@"门店ID",@"门店名称",@"负责人",@"门店地址"],
					  @[@"收货人",@"收货时间",@"所属楼层",@"有无电梯"]
					  ];
	[self.mainTableView reloadData];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0 && indexPath.section == 0) {
		return 80;
	}
	return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.rowTitleArray[section].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	static NSString * const TexttableViewCellID = @"AccountTableViewCellID";
	
	AccountTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TexttableViewCellID];;
	if (cell == nil) {
		
		cell= (AccountTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"AccountTableViewCell" owner:self options:nil]  lastObject];
		
	}
	cell.titleLabel.text = self.rowTitleArray[indexPath.section][indexPath.row];
	cell.desTexttable.text = self.rowTitleArray[indexPath.section][indexPath.row];
	if (indexPath.row == 0 && indexPath.section == 0) {
		cell.imageVIewICon.image = [UIImage imageNamed:@"touxiang.png"];
		cell.imageVIewICon.hidden = NO;
	}else {
		cell.imageVIewICon.hidden = YES;
	}
	cell.accessoryType = UITableViewCellAccessoryNone;
	if (indexPath.section == 0 ) {
		
		if (indexPath.row == 0) {
			cell.desTexttable.text = @"";
			
		}else if (indexPath.row == 1) {
			cell.desTexttable.text = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"storeTelephone"];
		}
	}else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			cell.desTexttable.text =
			[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]];
		}else if (indexPath.row == 1) {
			cell.desTexttable.text =
			[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"storeName"]];
		}else if (indexPath.row == 2) {
			cell.desTexttable.text =
			[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"managerName"]];
		}else if (indexPath.row == 3) {
			cell.desTexttable.text =
			[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"storeAddress"]];
		}
	}else if (indexPath.section == 2) {
		if (indexPath.row == 0) {
			cell.desTexttable.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"managerName"]];
			cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
		}else if (indexPath.row == 1) {
			cell.desTexttable.text = @"7:00 - 20:00";
		}else if (indexPath.row == 2) {
			cell.desTexttable.text = @"0楼";
		}else if (indexPath.row == 3) {
			cell.desTexttable.text = @"有";
		}
	}
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	
	UILabel * label = [UILabel creatLabelWithText:self.titleArray[section] FontOfSize:17 textColor:Main_Font_Black_Color];
	label.backgroundColor = self.view.backgroundColor;
	return label;
	
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
