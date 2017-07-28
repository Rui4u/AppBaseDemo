//
//  HomeViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/28.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTopView.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong ) HomeTopView * topView;
@property (nonatomic ,strong ) UIView * selectTypeView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.topView= [[HomeTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_AUTO(259))];
	self.rearTopView = self.topView;

	UITableView * tableViewList = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 0) style:UITableViewStyleGrouped];
	tableViewList.separatorStyle = UITableViewCellSelectionStyleNone;
	tableViewList.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
	tableViewList.dataSource = self;
	self.frontScrollView = tableViewList;
	
	self.selectTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
	
	self.frontTopView = self.selectTypeView;
	[self setUpSuperViewViewControllerUI];
	self.DraggingHeight = 20 ;
    [self initNavBarView:NAV_BAR_TYPE_ROOT_VIEW];
    self.navBarView.alpha = 0;

	
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    self.navBarView.alpha = scrollView.contentOffset.y/60.0;
    
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
