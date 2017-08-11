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
#import "ZYPinYinSearch.h"
#import <objc/runtime.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
@interface SelectLocationViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UISearchBarDelegate>

/**
 主talbview
 */
@property (nonatomic ,strong ) UITableView * mainTableView;

/**
 数据源
 */
@property (nonatomic ,strong ) NSMutableArray <CityList *>*dataSourse;

/**
 w定位服务
 */
@property (nonatomic ,strong ) BMKLocationService * locService;
/**
 根据location返编译信息
 */
@property (nonatomic ,strong) BMKGeoCodeSearch * geocodesearch;

/**
 当前城市是否在服务区
 */
@property (nonatomic ,assign ) BOOL cityInService;

/**
 搜索
 */
@property (nonatomic ,strong ) UITableView * searchHeadTableView;

/**
 搜索控件
 */
@property (nonatomic ,strong ) UIView * searchBarView;
@property (nonatomic ,strong ) UISearchBar *searchBar;
/**
 搜索结果
 */
@property (nonatomic ,strong ) NSMutableArray <Info *>* searchResultDataSource;

/**
 要搜索的数据源
 */
@property (nonatomic ,strong ) NSArray <CityList *>* searchDataSource;
/**
 搜索button
 */
@property (nonatomic ,strong ) UIButton *searchButton;


@end

@implementation SelectLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    [self.navBarView setTitle:@"当前定位"];
	[self.view addSubview:self.searchHeadTableView];
    [self.view addSubview:self.mainTableView];
	
//    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"SelectLocation" ofType:@"geojson"];
//    NSString *parseJason = [[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
//
//    NSDictionary * dict = [NSDictionary translateDictionaryForjsonString:parseJason];
//    self.dataSourse = [dict objectForKey:@"cityList"];
//    [self.mainTableView reloadData];
	
	[self setBaiduMap];
	self.dataSourse = [NSMutableArray arrayWithCapacity:10];
    
    [GetCityListBusiness requestGetCityListWithToken:TOKEN completionSuccessHandler:^(SelectCityModel *selectModel) {
        
        [self.dataSourse addObjectsFromArray: selectModel.cityList];
        [self.mainTableView reloadData];
    } completionFailHandler:^(NSString *failMessage) {
        [self showToastWithMessage:failMessage showTime:1];
    } completionError:^(NSString *netWorkErrorMessage) {
        [self showToastWithMessage:netWorkErrorMessage showTime:1];
    }];
	
	
}
#pragma mark - 地图相关
- (void)setBaiduMap {
	_geocodesearch = [[BMKGeoCodeSearch alloc]init];
	_geocodesearch.delegate = self;
	
	_locService = [[BMKLocationService alloc]init];
	_locService.delegate = self;
	
	//启动LocationService
	[_locService startUserLocationService];


}

-(void)viewWillDisappear:(BOOL)animated
{
	_locService.delegate = self;
	_geocodesearch.delegate = nil; // 此处记得不用的时候需要置nil，否则影响内存的释放
	
}


/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
	
	[self detailLocation:userLocation.location.coordinate.latitude andLog:userLocation.location.coordinate.longitude];
	
}


- (void) detailLocation:(CGFloat )latitude andLog:(CGFloat)longitude {
	
	
	CLLocationCoordinate2D pt = (CLLocationCoordinate2D){latitude, longitude};
	
	BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
	reverseGeocodeSearchOption.reverseGeoPoint = pt;
	BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
	if(flag) {
		NSLog(@"反geo检索发送成功");
		[self.locService stopUserLocationService];
	} else
	{
		NSLog(@"反geo检索发送失败");
	}
	
	
}
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {

	[self showToastWithMessage:@"定位失败" showTime:1];
}

///反向地理编码
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
	
	if (result != nil) {
		CityList * cityList = [[CityList alloc] init];
		cityList.name = @"当前城市";
		Info * info = [[Info alloc] init];
		info.cityCode = result.cityCode;
		info.cityCaption = result.addressDetail.city;
		info.latitude = [NSString stringWithFormat:@"%f",result.location.latitude];
		info.longitude = [NSString stringWithFormat:@"%f",result.location.longitude];
		NSArray<Info *> *infoArray = @[info];
		cityList.info = infoArray;
		
		for (CityList * list in self.dataSourse) {
			for (Info *listInfo in list.info) {
				if ([listInfo.cityCode intValue] == [info.cityCode intValue]) {
					self.cityInService = YES;
					break;
				}else {
					self.cityInService = NO;
					
				}
			}
			if(self.cityInService == YES){
				break;
			}
		}
		
		
		[self.dataSourse insertObject:cityList atIndex:0];
		
		[self.mainTableView reloadData];
	}
	
}

#pragma mark - 搜索
- (void)clickSearchButton:(UIButton *)sender {
	if ([sender.titleLabel.text isEqualToString:@"取消"]) {
		[self.searchBar resignFirstResponder];
		self.searchBar.text = @"";
		[self.view bringSubviewToFront:self.mainTableView];
		[_searchResultDataSource removeAllObjects];
		[self.searchHeadTableView reloadData];
		
		
	}
	
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	if ([searchText isEqualToString:@""]) {
		//清空数据
		[self.searchResultDataSource removeAllObjects];
		NSArray * array = CITYHISTORY ;
		[self.searchResultDataSource addObjectsFromArray:array];
		[self.searchHeadTableView reloadData];
		
	}else  {
		[self.view bringSubviewToFront:self.searchHeadTableView];
		
		[_searchResultDataSource removeAllObjects];
		NSArray *ary = self.dataSourse;
		self.searchResultDataSource = [NSMutableArray array];
		
		
		if (searchBar.text.length == 0) {
			[_searchResultDataSource addObjectsFromArray:ary];
		}else {
			for (CityList *cityList in ary) {
			NSArray	*temp = [ZYPinYinSearch searchWithOriginalArray:cityList.info andSearchText:searchBar.text andSearchByPropertyName:@"cityCaption"];
				
				[_searchResultDataSource addObjectsFromArray:temp];
			}
	
		}
		
		
		[self.searchHeadTableView reloadData];
		
	}
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
	[self.view bringSubviewToFront:self.searchHeadTableView];
	//显示历史记录
	[self.searchResultDataSource removeAllObjects];
	NSArray * array = CITYHISTORY ;
	[self.searchResultDataSource addObjectsFromArray:array];
	[self.searchHeadTableView reloadData];
	return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if ([tableView isEqual:self.searchHeadTableView]) {
		return 1;
	}else {
		return self.dataSourse.count;
	}
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if ([tableView isEqual:self.searchHeadTableView]) {
		return self.searchResultDataSource.count;

	}else {
		return self.dataSourse[section].info.count;
	}
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	if ([tableView isEqual:self.searchHeadTableView]) {
		
			
			UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UIHeaderTableViewCell"];
			if ( cell == nil) {
				cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UIHeaderTableViewCell"];
			}
			[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//			((CityTableViewCell *) cell).cityName = _searchResultDataSource[indexPath.row].cityName;
			cell.textLabel.text = self.searchResultDataSource[indexPath.row].cityCaption;
			return cell;
		
	}else {
	
        static NSString * const UITableViewCellID = @"UITableViewCellID";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID];;
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewCellID];
        }
        
		cell.textLabel.text = self.dataSourse[indexPath.section].info[indexPath.row].cityCaption;
	
		if (!self.cityInService && indexPath.section == 0) {
			cell.textLabel.textColor = [UIColor redColor];
		}else {
			cell.textLabel.textColor = [UIColor blackColor];
		}
	
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
	}
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	if ([tableView isEqual:self.searchHeadTableView]){
		return self.searchBarView;
	}else {
		UILabel * label = [UILabel creatLabelWithText:self.dataSourse[section].name FontOfSize:14 textColor:@"333333"];
		return label;
;	}
	
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	if ([tableView isEqual:self.searchHeadTableView]){
		return 50;
	}else {
		return 30;
	}
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([tableView isEqual:self.searchHeadTableView]) {
//	//搜索
		
		Info *info = self.searchResultDataSource[indexPath.row];
		if (self.locationBlock) {
			self.locationBlock(info);
		}
	}else {
	
		Info *info = self.dataSourse[indexPath.section].info[indexPath.row];
		if (self.locationBlock) {
			self.locationBlock(info);
		}
		
	}
	[self.navigationController popViewControllerAnimated:YES];

}

- (UITableView *)mainTableView {
	
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NAV_BAR_HEIGHT + 50, SCREEN_WIDTH, SCREEN_HEIGHT -NAV_BAR_HEIGHT - 50) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    }
	
    return _mainTableView;
}

- (UITableView *)searchHeadTableView {
	if (_searchHeadTableView == nil) {
		_searchHeadTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_HEIGHT) style:UITableViewStylePlain];
		_searchHeadTableView.delegate = self;
		_searchHeadTableView.dataSource = self;
//		[_searchHeadTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	}
	return _searchHeadTableView;
}

#pragma mark - 懒加载
- (UIView *)searchBarView {
	
	if (!_searchBarView) {
		
		_searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
		_searchBarView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
		
		UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(15, 10, WIDTH_AUTO(303), 30)];
		self.searchBar = searchBar;
		searchBar.backgroundColor = [UIColor whiteColor];
		searchBar.delegate = self;
		searchBar.placeholder = @"输入城市名或拼音查询";
		searchBar.showsCancelButton = NO;
		[_searchBarView addSubview:searchBar];
		UIImage* searchBarBg = [self GetImageWithColor:[UIColor whiteColor] andHeight:searchBar.height];
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
		[searchButton setTitleColor:[UIColor colorWithHexString: @"1556da"] forState:UIControlStateNormal];
		searchButton.titleLabel.font = [UIFont systemFontOfSize:14];
		
		[_searchBarView addSubview:searchButton];
	}
	return _searchBarView;
}


@end
