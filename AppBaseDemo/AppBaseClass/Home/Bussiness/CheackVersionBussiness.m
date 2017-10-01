//
//  CheackVersion.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "CheackVersionBussiness.h"

@implementation CheackVersionBussiness

+ (void) requestCheackVersionWithVersionMumber : (NSString* ) versionMumber
        completionSuccessHandler : (CheackVersionSuccessBlock) completionHandler
           completionFailHandler : (CheackVersionFailBlock) completionFailHandler
                 completionError : (CheackVersionErrorBlcok) completionError
{
    NSMutableDictionary * body = [[NSMutableDictionary alloc]init];
    [body setValue:versionMumber forKey:@"versionMumber"];
    
    
    [BaseNetWorkClient jsonFormGetRequestWithUrl:KcheckVersionIosBussinessUrl
                                           param:body
                                         success:^(id success)
     {
         NSDictionary * responeMp = (NSDictionary * ) success ;
         
         completionHandler(responeMp);
         
         
         
     } operationFailure:^(id failure) {
         
         completionFailHandler(failure);
         
     } failure:^(NSError * error)
     {
         completionError([super netWorkFailWithErroe:error]);
         
     }];
}
@end

