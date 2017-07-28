//
//  HZAgentGlobalConfig.h
//  HZAgentiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/10/31.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#ifndef HZAgentGlobalConfig_h
#define HZAgentGlobalConfig_h


#import <MJRefresh.h>
#import <UIImageView+WebCache.h>


#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define AutoHeight(height) height*(SCREEN_WIDTH/375.0f)


#pragma mark - 宏文件 UserDefaults
#define hzAgentUserDefaults   [NSUserDefaults standardUserDefaults]

#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)



#pragma mark - 一次性全部清除 UserDefaults中存储的数据
#define clearUserDefaults()\
{\
    NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];\
     NSDictionary *dictionary = [defatluts dictionaryRepresentation];\
     for(NSString *key in [dictionary allKeys])\
    {\
        [defatluts removeObjectForKey:key];\
        [defatluts synchronize];\
    }\
}

#define dataKey(x) [NSString stringWithFormat@"%@",x]
#define dataValue(y) [NSString stringWithFormat:@"%@",y]


#pragma mark -  保存数据到NSUserDefault 宏方法
#define saveDataUserDefaultForValueKey(dataValue,dataKey)\
{\
    if (nil != (dataKey) && nil !=(dataValue))\
    {\
        [hzAgentUserDefaults setObject:dataValue forKey:dataKey];\
        [hzAgentUserDefaults synchronize];\
    }\
}


#define isNull(x)             (!x || [x isKindOfClass:[NSNull class]])


#endif /* HZAgentGlobalConfig_h */
