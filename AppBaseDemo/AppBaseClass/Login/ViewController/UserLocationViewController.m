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

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <CoreLocation/CoreLocation.h> 
#import <CoreLocation/CLLocationManagerDelegate.h>
@interface UserLocationViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic ,strong ) BMKMapView* mapView;
@property (nonatomic ,strong ) BMKLocationService * locService;

@property (nonatomic ,strong ) BMKPoiSearch * searcher;
@property (nonatomic ,strong ) BMKNearbySearchOption *option;

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
@end

@implementation UserLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self.view addSubview: self.mapView];
	_locService = [[BMKLocationService alloc]init];
	_locService.delegate = self;
	
	//启动LocationService
	[_locService startUserLocationService];
	
	_searcher =[[BMKPoiSearch alloc]init];
	_searcher.delegate = self;
    
    self.annotation = [[BMKPointAnnotation alloc]init];
    
    [_mapView addAnnotation:self.annotation];
	
    
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
//    _coordinateXText.text = @"116.403981";
//    _coordinateYText.text = @"39.915101";
//    _cityText.text = @"北京";
//    _addrText.text = @"海淀区上地十街10号";
    [_mapView setZoomLevel:14];
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


//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
	//NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
	[_mapView updateLocationData:userLocation];
    [self testLat:userLocation.location.coordinate.latitude andLog:userLocation.location.coordinate.longitude];

    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude) animated:YES];
    [_locService stopUserLocationService];

}

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

- (BMKMapView *)mapView {
	if (_mapView == nil) {
		_mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	}
	return _mapView;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


///反向地理编码
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    
    [_poiListArray removeAllObjects];
    for(BMKPoiInfo *poiInfo in result.poiList)
    {
        NSLog(@"%@",poiInfo.address);
        [_poiListArray addObject:poiInfo.address];
    }
}


/**
 *地图初始化完毕时会调用此接口
 *@param mapview 地图View
 */

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
	
	NSLog(@"%s",__func__);
	
    [self testLat:mapView.centerCoordinate.latitude andLog:mapView.centerCoordinate.longitude];
  	
}
- (void) testLat:(CGFloat )latitude andLog:(CGFloat)longitude {
    CLLocationCoordinate2D coor;
    coor.latitude = latitude;
    coor.longitude = longitude;
    self.annotation.coordinate = coor;
    
    NSLog(@"%f,%f",latitude,longitude);
    
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


@end
