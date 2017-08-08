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
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件


#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
@interface SelectLocationViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic ,strong ) UITableView * mainTableView;
@property (nonatomic ,strong ) NSMutableArray <CityList *>*dataSourse;

@property (nonatomic ,strong ) BMKLocationService * locService;
/**
 根据location返编译信息
 */
@property (nonatomic ,strong) BMKGeoCodeSearch * geocodesearch;

@property (nonatomic ,assign ) BOOL cityInService;

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
	
		if (!self.cityInService && indexPath.section == 0) {
			cell.textLabel.textColor = [UIColor redColor];
		}else {
			cell.textLabel.textColor = [UIColor blackColor];
		}
	
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
