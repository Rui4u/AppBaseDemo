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
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.mainTableView.delegate = self;
	
	
	[OrderDetailBussiness requestOrderDetailWithToken:TOKEN orderId:self.orderId completionSuccessHandler:^(OrderDetailModel *getSelectedProductModel)
	{
		
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
	
	return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//    return self.orderListData.count;
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	

		OrderDetailTableViewCell * cell;
		
		cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailTableViewCellID"];
		if (cell == nil) {
			cell= (OrderDetailTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"OrderDetailTableViewCell" owner:self options:nil]  lastObject];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
		}		
		return cell;
	
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
