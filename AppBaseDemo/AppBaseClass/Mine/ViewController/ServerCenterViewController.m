//
//  ServerCenterViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/9/21.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ServerCenterViewController.h"
#import "QuestionViewController.h"
@interface ServerCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (nonatomic ,strong ) NSArray * titleArray;

@end

@implementation ServerCenterViewController
- (IBAction)leftButton:(id)sender {
    
    QuestionViewController * ques = [[QuestionViewController alloc] init];
    [self.navigationController pushViewController:ques animated:YES];
}

- (IBAction)rightButton:(id)sender {
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.mainTableView.delegate = self;
	self.mainTableView.dataSource = self;
	self.titleArray = @[@"服务条款",@"售后规则",@"运费规则"];
	[self.mainTableView reloadData];
	self.mainTableView.scrollEnabled = NO;
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"客户服务"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewcell"];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableviewcell"];
		cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
		cell.textLabel.text = self.titleArray[indexPath.row];
		cell.textLabel.font = [UIFont systemFontOfSize:12];
	}
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
