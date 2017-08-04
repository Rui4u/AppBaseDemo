//
//  SelectLocationViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "SelectLocationViewController.h"
#import "Parser.h"
#import "GetCityListBusiness.h"
#import "SelectCityModel.h"
@interface SelectLocationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong ) UITableView * mainTableView;
@property (nonatomic ,strong ) NSArray <CityList *>*dataSourse;
@end

@implementation SelectLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    [self.navBarView setTitle:@"当前定位"];
    [self.view addSubview:self.mainTableView];
//    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"SelectLocation" ofType:@"geojson"];
//    NSString *parseJason = [[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
//
//    NSDictionary * dict = [NSDictionary translateDictionaryForjsonString:parseJason];
//    self.dataSourse = [dict objectForKey:@"cityList"];
    [self.mainTableView reloadData];
    
    
    [GetCityListBusiness requestGetCityListWithToken:TOKEN completionSuccessHandler:^(SelectCityModel *selectModel) {
        
        self.dataSourse = selectModel.cityList;
        [self.mainTableView reloadData];
    } completionFailHandler:^(NSString *failMessage) {
        [self showToastWithMessage:failMessage showTime:1];
    } completionError:^(NSString *netWorkErrorMessage) {
        [self showToastWithMessage:netWorkErrorMessage showTime:1];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourse.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourse[section].info.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString * const UITableViewCellID = @"UITableViewCellID";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID];;
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewCellID];
        }
        
    cell.textLabel.text = self.dataSourse[indexPath.section].info[indexPath.row].cityCaption;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
        
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel * label = [UILabel creatLabelWithText:self.dataSourse[section].name FontOfSize:14 textColor:@"333333"];
    return label;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
        return 30;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
}

- (UITableView *)mainTableView {
    
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT -NAV_BAR_HEIGHT) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    }
    
    return _mainTableView;
}

@end
