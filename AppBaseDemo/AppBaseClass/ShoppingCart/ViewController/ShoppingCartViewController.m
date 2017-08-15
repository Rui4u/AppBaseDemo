//
//  ShoppingCartViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartGuiGeTableViewCell.h"
#import "ShoppingCartGoodsTableViewCell.h"
@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong ) UITableView * mainTableView;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 72;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString * const ShoppingCartGuiGeTableViewCellID = @"ShoppingCartGuiGeTableViewCell";
    
    ShoppingCartGuiGeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCartGuiGeTableViewCellID];;
    if (cell == nil) {
    
        cell= (ShoppingCartGuiGeTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"ShoppingCartGuiGeTableViewCell" owner:self options:nil]  lastObject];

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ShoppingCartGoodsTableViewCell * shoppingCartGoodsTableViewCell=  [[[NSBundle  mainBundle]  loadNibNamed:@"ShoppingCartGoodsTableViewCell" owner:self options:nil]  lastObject];
    return shoppingCartGoodsTableViewCell;
    
}


- (UITableView *)mainTableView {
    
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NAV_BAR_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - NAV_BAR_HEIGHT - 44) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _mainTableView;
}



@end
