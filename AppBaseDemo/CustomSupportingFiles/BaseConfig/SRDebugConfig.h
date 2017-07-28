//
//    SRDebugConfig_h.h
//    SRiOSClient
//
//  Created by sharui on 16/10/31.
//  Copyright © 2016年 sharui. All rights reserved.
//

//#ifndef   SRDebugConfig_h_h
#define   SRDebugConfig_h

#define NEED_OUTPUT_LOG       1
#if     NEED_OUTPUT_LOG
#define DDLog(xx, ...)          NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define  DEBUGCODE_DATA  YES
#else
#define DDLog(xx, ...)
#define     DEBUGCODE_DATA    NO

#endif /*   SRDebugConfig_h_h */
