//
//  AppDelegate.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/27.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "DESEncryption.h"
#import "LoginViewRootController.h"
#import "MoreViewController.h"
#import "OrderListViewController.h"
#import "UserLocationViewController.h"
#import "WXApi.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	[self setUpBaiduMapManager];
	
	
	RootViewController* rootViewController = [[RootViewController alloc] init];
    
	self.rootViewController = rootViewController;
	
	self.navgationController  = [[CustomNavigationController alloc] initWithRootViewController:rootViewController];
	
	
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = self.navgationController;
	
	//隐藏navigationController naviagtionBar
	self.navgationController.navigationBar.hidden = YES;
	[self.window makeKeyAndVisible];
    [WXApi registerApp:@"wx4475250f68d9a5ae"];
     
     


	
	return YES;
}

- (void)setUpBaiduMapManager {
	// 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
	
	/**
	 *百度地图SDK所有接口均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
	 *默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
	 *如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
	 */
	if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL]) {
		NSLog(@"经纬度类型设置成功");
	} else {
		NSLog(@"经纬度类型设置失败");
	}
	
	BOOL ret = [_mapManager start:@"wXT23fCZUEcV99FhVYnn689m6frkjohg" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
	if  ([url.host isEqualToString:@"pay"]) {
		//微信
		return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
	}
	if ([url.host isEqualToString:@"safepay"]) {
		//跳转支付宝钱包进行支付，处理支付结果
		[[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
			NSLog(@"result = %@",resultDic);

			[[ALiPayApiManager sharedManager] payStatus:resultDic];
		}];
	}
	return YES;}

- (BOOL)application:(UIApplication *)application
			openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
		 annotation:(id)annotation {
	if  ([url.host isEqualToString:@"pay"]) {
		//微信
		return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
	}
	if ([url.host isEqualToString:@"safepay"]) {
		//跳转支付宝钱包进行支付，处理支付结果
		[[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
			NSLog(@"result = %@",resultDic);

			[[ALiPayApiManager sharedManager] payStatus:resultDic];
		}];
	}
	return YES;
}


// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
	
	if  ([url.host isEqualToString:@"pay"]) {
		//微信
		return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
	}
	if ([url.host isEqualToString:@"safepay"]) {
		//跳转支付宝钱包进行支付，处理支付结果
		[[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
			NSLog(@"result = %@",resultDic);
			
			[[ALiPayApiManager sharedManager] payStatus:resultDic];
		}];
	}
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	// Saves changes in the application's managed object context before the application terminates.
	[self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"AppBaseDemo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)onGetNetworkState:(int)iError
{
	if (0 == iError) {
		NSLog(@"联网成功");
	}
	else{
		NSLog(@"onGetNetworkState %d",iError);
	}
	
}

- (void)onGetPermissionState:(int)iError
{
	if (0 == iError) {
		NSLog(@"授权成功");
	}
	else {
		NSLog(@"onGetPermissionState %d",iError);
	}
}


@end
