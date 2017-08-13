//
//  UserLocationViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/7.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "UserLocationViewController.h"
#import "SelectLocationViewController.h"
#import "CityNotInOpenCityView.h"
#import "GetCityListBusiness.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <CoreLocation/CoreLocation.h> 
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface UserLocationViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CityNotInOpenCityViewDelegate>

/**
 主tableview
 */
@property (nonatomic ,strong ) UITableView * mainTableView;
/**
 数据源
 */
@property (nonatomic ,strong ) NSArray <BMKPoiInfo *>* dataSource;

/**
 搜索
 */
@property (nonatomic ,strong ) UITableView * searchHeadTableView;

/**
 搜索后的数据源
 */
@property (nonatomic ,strong ) NSArray <BMKPoiInfo *>* searchDataSource;


@property (nonatomic ,strong ) BMKMapView* mapView;
//定位
@property (nonatomic ,strong ) BMKLocationService * locService;

/**
 poi搜索
 */
@property (nonatomic ,strong ) BMKPoiSearch * searcher;
@property (nonatomic ,strong ) BMKBasePoiSearchOption *option; //附近搜索选项

/**
 地图标签
 */
@property (nonatomic ,strong) BMKPointAnnotation* annotation;

/**
 附近信息
 */
@property (nonatomic ,strong) NSMutableArray * poiListArray;

/**
 根据location返编译信息
 */
@property (nonatomic ,strong) BMKGeoCodeSearch * geocodesearch;

/**
 反地理位置查询结果
 */
@property (nonatomic ,strong ) BMKReverseGeoCodeResult * result;

/**
 当前城市名称
 */
@property (nonatomic ,copy ) NSString *currentCityName;

/**
 搜索
 */
@property (nonatomic ,strong ) UITextField * searchTextField;
/**
 取消
 */
@property (nonatomic ,strong ) UIButton *cancelButton;

/**
 选择城市button
 */
@property (nonatomic ,strong ) UIButton * selectCityButton;
/**
 确认按钮
 */
@property (nonatomic ,strong ) UIButton * sureButton;

@property (nonatomic ,copy ) NSString * currentAdCode;


/**
 当前开通城市adcitylist
 */
@property (nonatomic ,strong ) NSArray * openCityAdcodeList;

/**
 城市没有开通
 */
@property (nonatomic ,strong ) CityNotInOpenCityView * cityNotInOpenCityView;
@end

@implementation UserLocationViewController

-(void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	[_mapView viewWillAppear];
	_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
	_geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
	_locService.delegate = self;
	_searcher.delegate = self;
	
}

-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[_mapView viewWillDisappear];
	_mapView.delegate = nil; // 不用时，置nil
	_geocodesearch.delegate = nil; // 此处记得不用的时候需要置nil，否则影响内存的释放
	_locService.delegate = nil;
	_searcher.delegate = nil;
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];

	self.selectCityButton = [UIButton quickCreateButtonWithFrame:CGRectMake(30, 20, 100, 44) title:@"位置" addTarget:self action:@"clickLocationCityButton:"];
    self.selectCityButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.selectCityButton setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    
	[self.navBarView addSubview:self.selectCityButton];
	
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.selectCityButton.frame), 30, 1, 24)];
    lineView.backgroundColor = [UIColor colorWithHexString:Main_Line_Gary_Color];
    [self.navBarView addSubview:lineView];
    
	self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) ,20,SCREEN_WIDTH - CGRectGetMaxX(lineView.frame) - 60, 44)];
	self.searchTextField.delegate = self;
	[self.searchTextField addTarget:self action:@selector(clickSearchCityButton:) forControlEvents:UIControlEventEditingChanged];
    self.searchTextField.placeholder = @"查找小区/街道/商厦等";
	self.searchTextField.backgroundColor = [UIColor whiteColor];
	[self.navBarView addSubview:self.searchTextField];
	
	self.cancelButton = [UIButton quickCreateButtonWithFrame: CGRectMake(self.searchTextField.right, self.searchTextField.y, 60, 44)title:@"取消" addTarget:self action:@"clickCancelButton:"];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:13];
	[self.cancelButton setTitleColor:[UIColor colorWithHexString:Main_Font_Green_Color] forState:UIControlStateNormal];
	[self.navBarView addSubview:self.cancelButton];

	
	self.sureButton = [UIButton quickCreateButtonWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50) title:@"确认" addTarget:self action:@"clickSureButton:"];
	self.sureButton.backgroundColor = [UIColor colorWithHexString:Main_Font_Green_Color];
	[self.view addSubview:self.sureButton];
	[self.view bringSubviewToFront:self.sureButton];
	
	[self.view addSubview:self.searchHeadTableView];
	[self  setUpBaiduMap];
	[self setUpBaiduMapSubViews];
	[self.view addSubview:self.mainTableView];
	[self.view bringSubviewToFront:self.sureButton];

	
	
	[GetCityListBusiness requestGetCityListWithToken:TOKEN completionSuccessHandler:^(SelectCityModel *selectModel) {
		
		NSMutableArray * array = [NSMutableArray array];
		for (CityList  *cityList in selectModel.cityList) {
				for (Info *info in cityList.info) {
					[array addObject:info.adCode];
			}
		}
		self.openCityAdcodeList = array.copy;
		
	} completionFailHandler:^(NSString *failMessage) {
		[self showToastWithMessage:failMessage showTime:1];
	} completionError:^(NSString *netWorkErrorMessage) {
		[self showToastWithMessage:netWorkErrorMessage showTime:1];
	}];

}

- (void)clickCityNotInOpenCityViewForBackHome {

}

- (void)clickCityNotInOpenCityViewForSelectCityView {
	[self clickLocationCityButton:nil];
}

#pragma mark - 点击事件

- (void)clickSureButton:(UIButton *)sender {
	


}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self.view bringSubviewToFront:self.searchHeadTableView];
	self.searchDataSource = nil;
	[self.searchHeadTableView reloadData];
	
}

- (void)clickCancelButton:(UIButton *)sender {

	[self.searchTextField resignFirstResponder];
	self.searchTextField.text = @"";
	[self.view bringSubviewToFront:self.mapView];
	[self.view bringSubviewToFront:self.mainTableView];
	[self.view bringSubviewToFront:self.sureButton];


}

- (void)clickSearchCityButton:(UITextField *)textField {

	
	UITextRange *rang = textField.markedTextRange; // 获取非=选中状态文字范围
	if (rang == nil) { // 没有非选中状态文字.就是确定的文字输入
		BMKCitySearchOption *option = [[BMKCitySearchOption alloc]init];
		self.option = option;
		option.pageIndex = 0;
		option.pageCapacity = 10;
		option.city = self.currentCityName;
		//	option.location = self.currentLocation;
		//	option.sortType = BMK_POI_SORT_BY_DISTANCE;
		option.keyword = textField.text;
		BOOL flag = [_searcher poiSearchInCity:option];
		
		if(flag)
		{
			NSLog(@"周边检索发送成功");
		}
		else
		{
			NSLog(@"周边检索发送失败");
		}	}

}

//选择城市
- (void)clickLocationCityButton: (UIButton *)sender{

	SelectLocationViewController * selectLocationViewController = [[SelectLocationViewController alloc] init];
	[self.navigationController pushViewController:selectLocationViewController animated:YES];
	selectLocationViewController.locationBlock = ^(Info * info) {
//		self.currentLocation = CLLocationCoordinate2DMake(info.latitude.floatValue, info.longitude.floatValue);
		self.currentCityName = info.cityCaption;
		[self testLat:info.latitude.floatValue andLog:info.longitude.floatValue];
		[_mapView setCenterCoordinate:CLLocationCoordinate2DMake(info.latitude.floatValue,info.longitude.floatValue) animated:YES];
		[self.selectCityButton setTitle:info.cityCaption forState:UIControlStateNormal];
	};

}

- (void)setUpBaiduMap {
	
	_mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, (SCREEN_HEIGHT - NAV_BAR_HEIGHT)/2)];
	[self.view addSubview: self.mapView];
	
	_locService = [[BMKLocationService alloc]init];
	
	//启动LocationService
	[_locService startUserLocationService];
	
	_searcher =[[BMKPoiSearch alloc]init];
	
	self.annotation = [[BMKPointAnnotation alloc]init];
	
	[_mapView addAnnotation:self.annotation];
	_mapView.showMapScaleBar = YES;
	
	_geocodesearch = [[BMKGeoCodeSearch alloc]init];
	[_mapView setZoomLevel:14];
}

- (void)setUpBaiduMapSubViews {

	UIButton *location = [[UIButton alloc] init];
	[location addTarget:self action:@selector(clickLocationButton:) forControlEvents:UIControlEventTouchUpInside];
	location.backgroundColor =[UIColor  randomOfColor];
	[_mapView addSubview:location];
	
	[location mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(_mapView.mas_left).offset(15);
		make.bottom.equalTo(_mapView.mas_bottom).offset(-15);
		make.size.mas_equalTo(CGSizeMake(25, 25));
	}];
	
	UIButton *downZoom = [[UIButton alloc] init];
	[downZoom addTarget:self action:@selector(clickDownButton:) forControlEvents:UIControlEventTouchUpInside];
	downZoom.backgroundColor =[UIColor  randomOfColor];
	[_mapView addSubview:downZoom];
	
	[downZoom mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(_mapView.mas_right).offset(-15);
		make.bottom.equalTo(_mapView.mas_bottom).offset(-15);
		make.size.mas_equalTo(CGSizeMake(40, 40));
	}];
	
	UIButton *upZoom = [[UIButton alloc] init];
	[upZoom addTarget:self action:@selector(clickUpButton:) forControlEvents:UIControlEventTouchUpInside];
	upZoom.backgroundColor =[UIColor  randomOfColor];
	[_mapView addSubview:upZoom];
	
	[upZoom mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(_mapView.mas_right).offset(-15);
		make.bottom.equalTo(downZoom.mas_top).offset(0);
		make.size.mas_equalTo(CGSizeMake(40, 40));
	}];
}

#pragma mark - 地图点击
- (void)clickDownButton:(UIButton *)sender {
	[self.mapView zoomOut];
}

- (void)clickUpButton:(UIButton *)sender {
	[self.mapView zoomIn];
}

- (void)clickLocationButton:(UIButton *)sender { 	//定位
	[_locService startUserLocationService];
}



//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode;

{
	if (errorCode == BMK_SEARCH_NO_ERROR) {
		//在此处理正常结果
		for (BMKPoiInfo *info in poiResult.poiInfoList) {
			NSLog(@"%@",info.name);
			NSLog(@"%@",info.address);
			NSLog(@"%@",info.city);
			NSLog(@"%@",info.postcode);
			NSLog(@"%f,%f",info.pt.latitude,info.pt.longitude);
			NSLog(@"======");
		}
		self.searchDataSource = poiResult.poiInfoList;
		[self.searchHeadTableView reloadData];

	}
	else {
		NSLog(@"抱歉，未找到结果");
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
		[self.searchTextField resignFirstResponder];
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
	[_mapView updateLocationData:userLocation];
    [self testLat:userLocation.location.coordinate.latitude andLog:userLocation.location.coordinate.longitude];
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude) animated:YES];
    [_locService stopUserLocationService];

}


///反向地理编码
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
	self.result = result;
	self.currentCityName = result.addressDetail.city;
	[self.selectCityButton setTitle:self.currentCityName forState:UIControlStateNormal];
	
    [_poiListArray removeAllObjects];
    for(BMKPoiInfo *poiInfo in result.poiList)
    {
        NSLog(@"%@",poiInfo.address);
        [_poiListArray addObject:poiInfo.address];
    }
	if (result.addressDetail.adCode!= nil && result.addressDetail.adCode.length == 6) {
		self.currentAdCode = [result.addressDetail.adCode stringByReplacingCharactersInRange:NSMakeRange(4, 2) withString:@"00"];

	}else {
		self.currentAdCode = nil;
	}
	
	
	if ([self.openCityAdcodeList containsObject:self.currentAdCode]) {
		self.dataSource = result.poiList;
		self.cityNotInOpenCityView.hidden = YES;
	}else {
		self.dataSource = nil;
		self.cityNotInOpenCityView.hidden = NO;
	}
	[self.mainTableView reloadData];
	
}


/**
 *地图初始化完毕时会调用此接口
 *@param mapView 地图View
 */
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {


	[self testLat:mapView.centerCoordinate.latitude andLog:mapView.centerCoordinate.longitude];

}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
	
	NSLog(@"%s",__func__);
	
    [self testLat:mapView.centerCoordinate.latitude andLog:mapView.centerCoordinate.longitude];
  	
}

- (void) testLat:(CGFloat )latitude andLog:(CGFloat)longitude {
	
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){latitude, longitude};

    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }


}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

	UILabel *label = [UILabel creatLabelWithText:self.result.address FontOfSize:12 textColor:Main_Font_Black_Color];
	label.backgroundColor = [UIColor whiteColor];
	
	return label;
}

- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus*)status {
	
	CLLocationCoordinate2D coor;
	coor.latitude = mapView.centerCoordinate.latitude;
	coor.longitude = mapView.centerCoordinate.longitude;
	self.annotation.coordinate = coor;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if ([tableView isEqual: self.searchHeadTableView]) {
		return self.searchDataSource.count;
	}else {
		return self.dataSource.count;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 static NSString * const UITableViewCellID = @"UserLocationViewControllerCellID";
	
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID];;
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:UITableViewCellID];
	}
	
	if ([tableView isEqual: self.searchHeadTableView]) {
		cell.textLabel.text = self.searchDataSource[indexPath.row].name;
		cell.detailTextLabel.text = self.searchDataSource[indexPath.row].address;
	}else {
		cell.textLabel.text = self.dataSource[indexPath.row].name;
		cell.detailTextLabel.text = self.dataSource[indexPath.row].address;
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if ([tableView isEqual:self.searchHeadTableView]) {
		[self.searchHeadTableView reloadData];
		[self clickCancelButton:nil];
		CGFloat lat = self.searchDataSource[indexPath.row].pt.latitude;
		CGFloat log = self.searchDataSource[indexPath.row].pt.longitude;
		[self testLat:lat andLog:log];
		[_mapView setCenterCoordinate:CLLocationCoordinate2DMake(lat,log) animated:YES];
	}else {
	
		[self.navigationController popViewControllerAnimated:YES];
		if (self.locationBlock) {
			NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
			[dict setValue:self.dataSource[indexPath.row].address forKey:@"address"];
			[dict setValue:self.dataSource[indexPath.row].name forKey:@"name"];
			[dict setValue:[NSString stringWithFormat:@"%f",self.dataSource[indexPath.row].pt.latitude] forKey:@"latitude"];
			[dict setValue:[NSString stringWithFormat:@"%f",self.dataSource[indexPath.row].pt.longitude] forKey:@"longitude"];
			[dict setValue:self.currentAdCode forKey:@"adCode"];
			self.locationBlock(dict);
		}
	
	}
}

- (UITableView *)mainTableView {
	
	if (!_mainTableView) {
		_mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.mapView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT -self.mapView.bottom - _sureButton.height) style:UITableViewStylePlain];
		_mainTableView.delegate = self;
		_mainTableView.dataSource = self;
		_mainTableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
		_mainTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

	}
	
	return _mainTableView;
}


- (UITableView *)searchHeadTableView {
	if (_searchHeadTableView == nil) {
		_searchHeadTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_HEIGHT) style:UITableViewStylePlain];
		_searchHeadTableView.delegate = self;
		_searchHeadTableView.dataSource = self;
		//		[_searchHeadTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		_searchHeadTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

	}
	return _searchHeadTableView;
}

- (CityNotInOpenCityView *)cityNotInOpenCityView {
	if (_cityNotInOpenCityView == nil) {
		
		
		_cityNotInOpenCityView = [[NSBundle mainBundle]loadNibNamed:@"CityNotInOpenCityView" owner:self options:nil].firstObject;
		_cityNotInOpenCityView.frame = self.mainTableView.bounds;
		[self.mainTableView addSubview:_cityNotInOpenCityView];
		_cityNotInOpenCityView.hidden = YES;
		_cityNotInOpenCityView.deleagte = self;
	}
	return _cityNotInOpenCityView;
}
@end
