//
//  UserLocationViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/7.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "UserLocationViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件


#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <CoreLocation/CoreLocation.h> 
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface UserLocationViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong ) BMKMapView* mapView;
//定位
@property (nonatomic ,strong ) BMKLocationService * locService;

/**
 poi搜索
 */
@property (nonatomic ,strong ) BMKPoiSearch * searcher;
@property (nonatomic ,strong ) BMKNearbySearchOption *option; //附近搜索选项

/**
 <#Description#>
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
 主
 */
@property (nonatomic ,strong ) UITableView * mainTableView;

/**
 数据源
 */
@property (nonatomic ,strong ) NSArray <BMKPoiInfo *>* dataSource;

/**
 反地理位置查询结果
 */
@property (nonatomic ,strong ) BMKReverseGeoCodeResult * result;
@end

@implementation UserLocationViewController

-(void)viewWillAppear:(BOOL)animated
{
	[_mapView viewWillAppear];
	_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
	_geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
	
}
-(void)viewWillDisappear:(BOOL)animated
{
	[_mapView viewWillDisappear];
	_mapView.delegate = nil; // 不用时，置nil
	_searcher.delegate = nil;
	_geocodesearch.delegate = nil; // 此处记得不用的时候需要置nil，否则影响内存的释放
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"当前定位"];

	[self  setUpBaiduMap];
	[self setUpBaiduMapSubViews];
	[self.view addSubview:self.mainTableView];
	
}
- (void)setUpBaiduMap {
	
	_mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, (SCREEN_HEIGHT - NAV_BAR_HEIGHT)/2)];
	[self.view addSubview: self.mapView];
	
	_locService = [[BMKLocationService alloc]init];
	_locService.delegate = self;
	
	//启动LocationService
	[_locService startUserLocationService];
	
	_searcher =[[BMKPoiSearch alloc]init];
	_searcher.delegate = self;
	
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
		
	}
	else {
		NSLog(@"抱歉，未找到结果");
	}
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
	
    [_poiListArray removeAllObjects];
    for(BMKPoiInfo *poiInfo in result.poiList)
    {
        NSLog(@"%@",poiInfo.address);
        [_poiListArray addObject:poiInfo.address];
    }
	self.dataSource = result.poiList;
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
	
    
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    self.option = option;
    option.pageIndex = 0;
    option.pageCapacity = 10;
    option.location = CLLocationCoordinate2DMake(latitude,longitude);
    option.sortType = BMK_POI_SORT_BY_DISTANCE;
    option.keyword = @"商家";
    BOOL flag = [_searcher poiSearchNearBy:option];
    
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){latitude, longitude};

    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
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

	UILabel *label = [UILabel creatLabelWithText:self.result.address FontOfSize:12 textColor:@"333333"];
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
	return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 static NSString * const UITableViewCellID = @"UserLocationViewControllerCellID";
	
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID];;
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewCellID];
	}
	
	cell.textLabel.text = self.dataSource[indexPath.row].name;
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;

}

- (UITableView *)mainTableView {
	
	if (!_mainTableView) {
		_mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.mapView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT -self.mapView.bottom) style:UITableViewStylePlain];
		_mainTableView.delegate = self;
		_mainTableView.dataSource = self;
		_mainTableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
	}
	
	return _mainTableView;
}

@end
