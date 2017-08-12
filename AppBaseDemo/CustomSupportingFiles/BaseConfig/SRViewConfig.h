//
//    SRViewConfig.h
//    SRiOSClient
//
//  Created by sharui on 16/10/31.
//  Copyright © 2016年 sharui. All rights reserved.
//

#ifndef   SRViewConfig_h
#define   SRViewConfig_h

#if DEBUG
//#define NSLog(...) NSLog(__VA_ARGS__)
#define NSLog(s,...) NSLog(@"%s LINE:%d < %@ >",__FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define NSLog(...) {}
#endif

#define SYSTEM_DEV_IOS_7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) ? YES : NO)
#define SYSTEM_DEV_IOS_7_1 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.1) ? YES : NO)

#define SYSTEM_IOS_8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) ? YES : NO)

#define SRWindow               (UIWindow *)[[UIApplication sharedApplication] keyWindow]

#pragma mark - 关于颜色
#define COLOR_RGB(r,g,b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]
#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:a]
#define kPLRGB_16(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#define Main_Font_Green_Color @"#0bbe06" //绿色
#define Main_Font_Gary_Color @"#bfbfbf" //字灰色
#define Main_Line_Gary_Color @"#dddddd" //分割线灰色
#define Main_Font_Red_Color @"#EE5C56" //字红色
#define Main_Button_Gary_Color @"#e1e1e1" //字红色
#define Main_BackGround_Color @"#f5f5f5" //背景色



#pragma mark - 依据屏幕绝对高度判断机型
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)


#define NAV_BAR_HEIGHT (IS_IPHONE_6_PLUS ? 66 : (SYSTEM_DEV_IOS_7 ? 64 : 44))
#define TABBAR_HEIGHT 49
#pragma  mark -  屏幕宽度、高度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height - ((SYSTEM_DEV_IOS_7) ? 0 : 20))
#pragma  mark -  根据6/7来自动调节
#define AGWIDTH_AUTO   (SCREEN_WIDTH/375.0) //适配比例
#define WIDTH_AUTO(a)   a*(SCREEN_WIDTH/375.0) //适配比例
#define HEIGHT_AUTO(a)  a*(SCREEN_HEIGHT/667.0)
#define WeakSelf                __weak typeof(self) weakSelf = self


#define ISEmpty(checkStr)     ((checkStr&&![checkStr isEqualToString:@""])?checkStr:@"")

#define PhotosMessageDir ([[NSString documentPath] stringByAppendingPathComponent:@"/PhotosMessageDir/"])



#define  PEListCellHeight 177
#define  P2PListCellHeight 150
#define  TeamListCellHeight 134
#define MianYouYuHeight 179

#define  PENoReadProtocolListCellHeight 215

#endif /*   SRViewConfig_h */
