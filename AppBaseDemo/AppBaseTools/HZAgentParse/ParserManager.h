//
//  ParserManager.h
//  HZAgentiOSClient
//
//  Created by ZhentaiNing_Huizhong on 17/2/27.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 解析 管理类
 */
@interface ParserManager : NSObject

//+(instancetype) shareParserManager ;
//
//+(instancetype) manager ;

/**
 *  输入NSString、ClassName生成相应的对象
 *
 *  @param soruceDic 数据源 NSDictionary类型
 *  @param className    转化生成的对象
 *
 *  @return 由ClassName生成的对象
 
+ (id)  stringTransformObjectWithClassName : (NSDictionary *) soruceDic
                                 className : (NSString *) className;
*/
@end
