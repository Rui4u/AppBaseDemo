//
//  HZAgentDebugConfig_h.h
//  HZAgentiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/10/31.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

//#ifndef HZAgentDebugConfig_h_h
#define HZAgentDebugConfig_h

#define NEED_OUTPUT_LOG       1
#if     NEED_OUTPUT_LOG
#define DDLog(xx, ...)          NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define  DEBUGCODE_DATA  YES
#else
#define DDLog(xx, ...)
#define     DEBUGCODE_DATA    NO

#endif /* HZAgentDebugConfig_h_h */
