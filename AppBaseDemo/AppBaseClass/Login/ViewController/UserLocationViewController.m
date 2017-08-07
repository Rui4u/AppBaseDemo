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
@interface UserLocationViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
@property (nonatomic ,strong ) BMKMapView* mapView;
@property (nonatomic ,strong ) BMKLocationService * locService;

@property (nonatomic ,strong ) BMKPoiSearch * searcher;
@property (nonatomic ,strong ) BMKNearbySearchOption *option;
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
	_mapView.showsUserLocation = YES;//显示定位图层
	
	
	
	_searcher =[[BMKPoiSearch alloc]init];
	_searcher.delegate = self;
	//发起检索
	BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
	self.option = option;
	option.pageIndex = 0;
	option.pageCapacity = 10;
	option.location = CLLocationCoordinate2DMake(39.8984940000,116.4722310000);
	option.sortType = BMK_POI_SORT_BY_DISTANCE;
	option.keyword = @"鸭脖";
	BOOL flag = [_searcher poiSearchNearBy:option];
	
	if(flag)
	{
		NSLog(@"周边检索发送成功");
	}
	else
	{
		NSLog(@"周边检索发送失败");
	}
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
	//NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
	[_mapView updateLocationData:userLocation];
//	_searcher =[[BMKPoiSearch alloc]init];
//	_searcher.delegate = self;
//	//发起检索
//	BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//	self.option = option;
//	option.pageIndex = 0;
//	option.pageCapacity = 10;
//	option.location = CLLocationCoordinate2DMake(39.8984940000,116.4722310000);
//	option.sortType = BMK_POI_SORT_BY_DISTANCE;
//	option.keyword = @"鸭脖";
//	BOOL flag = [_searcher poiSearchNearBy:option];
//	
//	if(flag)
//	{
//		NSLog(@"周边检索发送成功");
//	}
//	else
//	{
//		NSLog(@"周边检索发送失败");
//	}
}

-(void)viewWillAppear:(BOOL)animated
{
	[_mapView viewWillAppear];
	_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
	[_mapView viewWillDisappear];
	_mapView.delegate = nil; // 不用时，置nil
	_searcher.delegate = nil;

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

//-(void)viewWillAppear:(BOOL)animated
//{
//	[_mapView viewWillAppear];
//	_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//	[_mapView viewWillDisappear];
//	_mapView.delegate = nil; // 不用时，置nil
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 *地图初始化完毕时会调用此接口
 *@param mapview 地图View
 */

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
	
	NSLog(@"%s",__func__);
	
	NSLog(@"%f,%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
	
	
	
}



@end
