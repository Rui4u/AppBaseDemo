//
//  CommonSearchController.m
//  HZAgentiOSClient
//
//  Created by sharui on 2017/2/21.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "CommonSearchController.h"

@interface CommonSearchController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

/**
 searchBarView
 */
@property (nonatomic ,strong ) UIView * searchBarView;

/**
 搜索button
 */
@property (nonatomic ,strong ) UIButton *searchButton;

/**
 搜索控件
 */
@property (nonatomic ,strong ) UISearchBar *searchBar;
/**
 搜索
 */
@property (nonatomic ,strong ) UITableView * searchHeadTableView;

/**
 搜索数据源
 */
@property (nonatomic ,strong ) NSMutableArray * searchDataArray;


/**
 输入的文案
 */
@property (nonatomic , copy) NSString * inputText;
@end

@implementation CommonSearchController

@synthesize searchBar =  _searchBar ;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    [self.view addSubview:self.searchHeadTableView];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    self.searchBarView.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    [self.navBarView addSubview:self.searchBarView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.searchBar.text = self.inputText;
//    if ([self.inputText isEqualToString:@""] || self.inputText == nil)
//    {
//        [self.searchDataArray removeAllObjects];
        [self.searchHeadTableView reloadData];
//    }
//    else
//    {
//        
//    }
    

}



#pragma mark - UITableViewDataSourse

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchDataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell;
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"CommonSearchControllerCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonSearchControllerCell"];
    }
    cell.textLabel.textColor = [UIColor colorWithHexString:@"2097f5"];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = self.searchDataArray[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
     return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString * text = [self.searchDataArray objectAtIndex:indexPath.row];
//    SearchListViewController * vc = [[SearchListViewController alloc] init];
//    if ([text containsString:@"面包客"]) {
//        NSLog(@"%@ --- %@",self.searchBar.text,@"面包客");
//        vc.searchListType = SearchListType_agent;
//        vc.keyword = self.searchBar.text;
//        vc.sitId = self.siteId;
//        vc.searchFrom = self.searchFromVC;
//        vc.productId = self.productId;
//        vc.placeholderStr = self.inputText;
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }else if ([text containsString:@"店铺名"]) {
//        NSLog(@"%@ --- %@",self.searchBar.text,@"店铺名");
//        vc.searchListType = SearchListType_shop;
//        vc.keyword = self.searchBar.text;
//        vc.sitId = self.siteId;
//        vc.searchFrom = self.searchFromVC;
//        vc.productId = self.productId;
//        vc.placeholderStr = self.inputText;
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }else {
//        NSLog(@"%@ --- %@",self.searchBar.text,@"团队");
//    }
}
#pragma mark - 搜索

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    NSLog(@"%@",self.searchBar.text);
//    switch ((int)self.searchType)
//    {
//        case SearchType_AgentName://搜索面包客
//        {
//            SearchListViewController * vc = [[SearchListViewController alloc] init];
//            vc.searchListType = SearchListType_agent;
//            vc.keyword = self.searchBar.text;
//            vc.sitId = self.siteId;
//            vc.searchFrom = self.searchFromVC;
//            vc.productId = self.productId;
//            vc.placeholderStr = self.inputText;
//            [self.navigationController pushViewController:vc animated:YES];
//            
//        }
//            break;
//        case SearchType_ShopName://搜索店铺
//        {
//            SearchListViewController * vc = [[SearchListViewController alloc] init];
//            vc.searchListType = SearchListType_shop;
//            vc.keyword = self.searchBar.text;
//            vc.sitId = self.siteId;
//            vc.searchFrom = self.searchFromVC;
//            vc.productId = self.productId;
//            vc.placeholderStr = self.inputText;
//            [self.navigationController pushViewController:vc animated:YES];
//
//        }
//            break;
//        case
//        SearchType_SabourUnion:
//        {
//            
//        }
//            break;
//        case (SearchType_AgentName|SearchType_ShopName)://搜索面包客和店铺
//        {
//            SearchListViewController * vc = [[SearchListViewController alloc] init];
//            vc.searchListType = SearchListType_default;
//            vc.keyword = self.searchBar.text;
//            vc.sitId = self.siteId;
//            vc.searchFrom = self.searchFromVC;
//            vc.productId = self.productId;
//            vc.placeholderStr = self.inputText;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case (SearchType_AgentName|SearchType_SabourUnion):
//        {
//            
//        }
//            break;
//        case (SearchType_ShopName|SearchType_SabourUnion):
//        {
//            
//        }
//            break;
//        case (SearchType_AgentName|SearchType_ShopName|SearchType_SabourUnion):
//        {
//            
//        }
//            break;
//        default:
//            break;
//    }
}

- (void)clickSearchButton:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"取消"]) {
        [self.searchBar resignFirstResponder];
//        self.searchBar.text = @"";
        [self.searchDataArray removeAllObjects];
        [self.searchHeadTableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.view bringSubviewToFront:self.searchHeadTableView];
    //显示历史记录
    if ([searchBar.text isEqualToString: @""]) {
        [self.searchDataArray removeAllObjects];
    }
    
    
    return YES;
}
#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""])
    {
        //清空数据
        [self.searchDataArray removeAllObjects];
        [self.searchHeadTableView reloadData];
    }
    else
    {
        NSLog(@"请求数据");
        [self detailArrayData:searchText];
        [self.searchHeadTableView reloadData];
    }
    
}

- (void) detailArrayData:(NSString *)searchText
{
    self.inputText = searchText;
    switch ((int)self.searchType) {
        case SearchType_AgentName: {
            self.searchDataArray[0] = [NSString stringWithFormat:@"搜索\"%@\"相关的面包客",searchText];
        }break;
        case SearchType_ShopName: {
            self.searchDataArray[0] = [NSString stringWithFormat:@"搜索\"%@\"相关的店铺名",searchText];
        } break;
        case SearchType_SabourUnion:{
            self.searchDataArray[0] = [NSString stringWithFormat:@"搜索\"%@\"相关的团队",searchText];
        }break;
        case (SearchType_AgentName|SearchType_ShopName):
        {
            self.searchDataArray[0] = [NSString stringWithFormat:@"搜索\"%@\"相关的面包客",searchText];
            self.searchDataArray[1] = [NSString stringWithFormat:@"搜索\"%@\"相关的店铺名",searchText];
        }break;
        case (SearchType_AgentName|SearchType_SabourUnion): {
            self.searchDataArray[0] = [NSString stringWithFormat:@"搜索\"%@\"相关的面包客",searchText];
            self.searchDataArray[1] = [NSString stringWithFormat:@"搜索\"%@\"相关的团队",searchText];
        }break;
        case (SearchType_ShopName|SearchType_SabourUnion): {
            self.searchDataArray[0] = [NSString stringWithFormat:@"搜索\"%@\"相关的店铺名",searchText];
            self.searchDataArray[1] = [NSString stringWithFormat:@"搜索\"%@\"相关的团队",searchText];
        }break;
        case (SearchType_AgentName|SearchType_ShopName|SearchType_SabourUnion): {
            self.searchDataArray[0] = [NSString stringWithFormat:@"搜索\"%@\"相关的面包客",searchText];
            self.searchDataArray[1] = [NSString stringWithFormat:@"搜索\"%@\"相关的店铺名",searchText];
            self.searchDataArray[2] = [NSString stringWithFormat:@"搜索\"%@\"相关的团队",searchText];
        }break;
            
        default:
            break;
    }
    
    
}
- (UIView *)searchBarView {
    
    if (!_searchBarView) {
        
        _searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _searchBarView.backgroundColor = [UIColor clearColor];
        
        UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(15, 7, WIDTH_AUTO(303), 30)];
        self.searchBar = searchBar;
        
        searchBar.placeholder = self.searchBarPlaceholder;
        
        
        UITextField * searchField = [self.searchBar valueForKey:@"_searchField"];
        [searchField setValue:[UIColor colorWithHexString:@"8d8d8e"] forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        
        searchField.textColor = [UIColor colorWithHexString:@"ffffff"];
        
        
        searchBar.delegate = self;
        searchBar.showsCancelButton = NO;
        [_searchBarView addSubview:searchBar];
        UIImage* searchBarBg = [self GetImageWithColor:[UIColor colorWithHexString:@"232226"] andHeight:searchBar.height];
        //设置背景图片
        [searchBar setBackgroundImage:searchBarBg];
        //设置背景色
        [searchBar setBackgroundColor:[UIColor clearColor]];
        //设置文本框背景
        [searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        searchBar.layer.masksToBounds = YES;
        searchBar.layer.cornerRadius = 2;
        
        UIButton *searchButton = [[UIButton alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(searchBar.frame), 0, WIDTH_AUTO(55), _searchBarView.height)];
        self.searchButton = searchButton;
        [searchButton setTitle:@"取消" forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(clickSearchButton:) forControlEvents:UIControlEventTouchUpInside];
        [searchButton setTitleColor:[UIColor colorWithHexString: @"ffffff"] forState:UIControlStateNormal];
        searchButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_searchBarView addSubview:searchButton];
    }
    return _searchBarView;
}

- (UITableView *)searchHeadTableView {
    if (_searchHeadTableView == nil) {
        _searchHeadTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_HEIGHT) style:UITableViewStyleGrouped];
        _searchHeadTableView.delegate = self;
        _searchHeadTableView.dataSource = self;
    }
    return _searchHeadTableView;
}

- (NSMutableArray *)searchDataArray {

    if (_searchDataArray == nil) {
        _searchDataArray = [NSMutableArray arrayWithCapacity:2];

    }

    return _searchDataArray;
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