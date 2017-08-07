//
//  HomeViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/28.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTopView.h"
#import "SelectTypeView.h"
#import "LoginViewRootController.h"
#import <MJExtension.h>
#import "HomeDataModel.h"
#import "HomeProductListTableViewCell.h"
#import "UserLocationViewController.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomeProductListTableViewCellDelegate>
@property (nonatomic ,strong ) HomeTopView * topView;
@property (nonatomic ,strong ) SelectTypeView * selectTypeView;
/**
 数据源
 */
@property (nonatomic ,strong) HomeDataModel *dataSourse;
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
	
	self.selectTypeView = [[SelectTypeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 74)];
	self.selectTypeView.backgroundColor = [UIColor whiteColor];
	self.frontTopView = self.selectTypeView;
	[self setUpSuperViewViewControllerUI];
	self.DraggingHeight = 20 ;
    [self initNavBarView:NAV_BAR_TYPE_ROOT_VIEW];
    self.navBarView.alpha = 0;
    
//    
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"Directions" ofType:@"geojson"];
    NSString *parseJason = [[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary * dict = [NSDictionary translateDictionaryForjsonString:parseJason];

    self.dataSourse = [HomeDataModel mj_objectWithKeyValues:[dict objectForKey:@"body"]];
    [(UITableView *)self.frontScrollView reloadData];

}
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	UserLocationViewController * vc = [[UserLocationViewController alloc] init];
	[self presentViewController:vc animated:YES completion:nil];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSourse.productInfoList[section].productList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourse.productInfoList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataSourse.productInfoList[indexPath.section].productList[indexPath.row].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const HomeProductListTableViewCellID = @"HomeProductListTableViewCellID";
    
    HomeProductListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:HomeProductListTableViewCellID];;
    if (cell == nil) {
        cell = [[HomeProductListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeProductListTableViewCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    cell.indexPath = indexPath;
    cell.dataSourse = self.dataSourse.productInfoList[indexPath.section].productList[indexPath.row];
    return cell;

}


- (void)ClickSelectSpecificationWithIndexPath:(NSIndexPath *)indexPath {
    
    [(UITableView *)self.frontScrollView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];


}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    if (scrollView == self.backScrollView) {
            self.navBarView.alpha = scrollView.contentOffset.y/60.0;
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
