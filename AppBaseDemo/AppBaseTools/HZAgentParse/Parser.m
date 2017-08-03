//
//  Parser.m
//
//
//  Created by Zhentai on 15-2-7.
//  Copyright (c) 2015年 com.yixin.itoumi. All rights reserved.
//

#import "Parser.h"
#import "NSString+SRString.h"
#import <objc/runtime.h>


//static inline _Nullable id parser( NSString * classNameString , Parser * paerser)
//{
////    id value = nil;
////    for (NSUInteger i = 0, max = keyPaths.count; i < max; i++) {
////        value = dic[keyPaths[i]];
////        if (i + 1 < max) {
////            if ([value isKindOfClass:[NSDictionary class]]) {
////                dic = value;
////            } else {
////                return nil;
////            }
////        }
////    }
//    Parser * cacheParser = paerser ;
// 
//    
//    return nil;
//}

@interface Parser ()
//延展方法 获取对象放大列表
NSArray * getPropertyNameList (id objectClass);

@end

@implementation Parser
{
    @private
    NSMutableArray<__kindof  NSObject * > * parserArray ;
    NSMutableArray <__kindof NSString * > *  parserClassNameArray ;
    NSMutableDictionary <__kindof NSString *  , __kindof NSObject * > * parserMap ;
}

#pragma mark 
#pragma mark -- 动态生成对象
#pragma mark -- 动态获取单个对象
+ (id)  stringTransformObjectWithClassName : (NSDictionary *) sourceDic
                                 className : (NSString *) className
{
    Class objClass = NSClassFromString(className);
    if (objClass == nil)
    {
        @throw [NSException exceptionWithName:@"Parser classLoader error"
                                       reason:@"Parser must be loader className , this class is null"
                                     userInfo:nil];
    }
    else
    {
        
  
//    id dynamicObjet =[[objClass alloc]init];
    id dynamicObjet =[objClass new];
    if ([dynamicObjet isKindOfClass:[NSNull class]])
        return nil;
   
    NSArray * propertyArray = getPropertyNameList (objClass);
    for (NSString * key  in propertyArray)
    {
        @try
        {
            [dynamicObjet setValue:sourceDic[key] forKey:key];

        }
        @catch (NSException * exception)
        {
//            DDLog(@"stringTransformObjectWithClassName 运行动态解析是出现异常， exception : %@ : %@" , key , sourceDic[key]);
        }
        
    }
    
   
    propertyArray = nil ;
    return dynamicObjet;
          }
}
+ (id)  stringTransformObjectWithClassName : (NSDictionary *) soruceDic
                                 className : (NSString *) className
                                beReplaced : (NSString * ) beReplaced
                                   replace : (NSString * ) replace
{
    NSMutableDictionary * mutableReplacedDic = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * mutableDic = [(NSMutableDictionary * ) soruceDic mutableCopy] ;
    
    for (NSString * key in [mutableDic allKeys])
    {
        if ([key isEqualToString:beReplaced])
        {
            [mutableReplacedDic setObject:[mutableDic valueForKey:key]  forKey:replace];
            
        }
        else
        {
            [mutableReplacedDic setObject:[mutableDic valueForKey:key]  forKey:key];
            
        }
    }
    return [self stringTransformObjectWithClassName:mutableReplacedDic className:className];

}


+ (id) stringTransformObjectWithClassName : (NSDictionary *)soruceDic
                                className : (NSString *)className
                            attributeName : (NSMutableArray * ) attributeName,... NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray * array = [NSMutableArray new];
    va_list args;

    va_start(args, attributeName);
    if (attributeName)
    {
        [array addObject:attributeName];
        while (1)
        {
            NSString * otherButtonTitle = va_arg(args, NSString *);
            if(otherButtonTitle == nil) {
                break;
            } else {
                [array addObject:otherButtonTitle];
            }
        }
    }
    va_end(args);
    
//    id i  = [self stringTransformObjectWithClassName:soruceDic className:className];
    
    
    return nil;
}
#pragma mark -- 动态生成列表对象
+ (NSMutableArray *) stringTansformArrayObjectWithClassName : (id) sourceDic
                                           className : (NSString *) className
{
    Class objClass = NSClassFromString(className);
    NSMutableArray * dynamcObjectArray = [[NSMutableArray alloc]init];
    for (id dict in sourceDic)
    {
        id dynamcObject = [objClass new];
        NSArray * propertyArray = getPropertyNameList(objClass);
        for (NSString * key  in propertyArray)
        {
            if (dict[key] == [NSNull null]) //key is null
            {
//                DDLog(@"dict is null , key = %@" ,key);
                break;
            }
            else  //key  is not null
            {
                @try
                {
                    if ([dynamcObject isKindOfClass:objClass])
                         {
                             [dynamcObject setValue:dict[key] forKey:key];
                         }
                }
                @catch (NSException * exception)
                {
//                    DDLog(@"stringTansformArrayObjectWithClassName 运行动态解析是出现异常， exception : %@ : %@" , key , sourceDic[key]);

                }
            }
        }
        [dynamcObjectArray addObject:dynamcObject]; //将解析对象发到List中
    }
    
    return dynamcObjectArray;
}
+ (NSArray * ) stringTansformArrayObjectWithClassName : (NSDictionary *)sourceDic
                                            className : (NSString * )className
                                           beReplaced : (NSString * ) beReplaced
                                              replace : (NSString * ) replace
{
    
    Class objClass = NSClassFromString(className);
    NSMutableArray * dynamcObjectArray = [[NSMutableArray alloc]init];
    for (id dict in sourceDic)
    {
        NSMutableDictionary * mutableReplacedDic = [[NSMutableDictionary alloc]init];
        NSMutableDictionary * mutableDic = [(NSMutableDictionary * ) dict mutableCopy] ;
        
        for (NSString * key in [mutableDic allKeys])
        {
            if ([key isEqualToString:beReplaced])
            {
                [mutableReplacedDic setObject:[mutableDic valueForKey:key]  forKey:replace];
                
            }
            else
            {
                [mutableReplacedDic setObject:[mutableDic valueForKey:key]  forKey:key];

            }
        }

        
        id dynamcObject = [objClass new];
        NSArray * propertyArray = getPropertyNameList(objClass);
        for (NSString * key  in propertyArray)
        {
            if (mutableReplacedDic[key] == [NSNull null]) //key is null
            {
                //                DDLog(@"dict is null , key = %@" ,key);
                continue ;
            }
            else  //key  is not null
            {
                @try
                {
                    if ([dynamcObject isKindOfClass:objClass])
                    {
                        [dynamcObject setValue:mutableReplacedDic[key] forKey:key];
                    }
                }
                @catch (NSException * exception)
                {
                DDLog(@"stringTansformArrayObjectWithClassName 运行动态解析是出现异常， exception : %@ : %@" , key , sourceDic[key]);
                    
                }
            }
        }
        [dynamcObjectArray addObject:dynamcObject]; //将解析对象发到List中
    }
    
    return dynamcObjectArray;
    
}

#pragma mark -- 动态生成列表对象，包含2层的话可以用下面解析
+ (NSArray *) stringTansformArrayObjectWithClassName : (NSDictionary *) sourceDic
                                           className : (NSString *) className
                                          propertyStr: (NSString *) property
                                        subClassName : (NSString *) subName
{
    Class objClass = NSClassFromString(className);
    NSMutableArray * dynamcObjectArray = [[NSMutableArray alloc]init];
    for (id dict in sourceDic)
    {
        id dynamcObject = [objClass new];
        NSArray * propertyArray = getPropertyNameList(objClass);
        for (NSString * key  in propertyArray)
        {
            if (dict[key] == [NSNull null]) //key is null
            {
                DDLog(@"dict is null , key = %@" ,key);
            }
            else  //key  is not null
            {
                @try
                {
                    if ([dynamcObject isKindOfClass:objClass])
                    {
                        if ([key isEqualToString:property]) {
                            
                            NSMutableArray *temp = [NSMutableArray array];
                            NSMutableArray *ary = dict[key];
                            
                            if (ary && ary.description.length>0){
                                for (id dic in ary)
                                {
                                    [temp addObject:[Parser stringTransformObjectWithClassName:dic className:subName]];
                                }
                                [dynamcObject setValue:temp forKey:key];
                            }
                            else
                            {
                                [dynamcObject setValue:[dict noNullobjectForKey:key] forKey:key];
                            }
                        }else{
                            [dynamcObject setValue:[dict noNullobjectForKey:key] forKey:key];
                        }
                    }
                }
                @catch (NSException * exception)
                {
                    DDLog(@"stringTansformArrayObjectWithClassName 运行动态解析是出现异常， exception : %@ : %@" , key , sourceDic[key]);
                    
                }
            }
        }
        [dynamcObjectArray addObject:dynamcObject]; //将解析对象发到List中
    }
    
    return dynamcObjectArray;
}
- (NSArray * )   stringTansformArrayObjectWithArray : (NSMutableArray *) array
                                          className : (NSString * ) className
{
    NSMutableArray * mutableArray =  [NSMutableArray new];
     Class objClass = NSClassFromString(className);
    for (id dict in array)
    {
        id dynamcObject = [objClass new];
        NSArray * propertyArray = getPropertyNameList(objClass);
          for (NSString * key  in propertyArray)
          {
              if (dict[key] == [NSNull null]) //key is null
              {
                  DDLog(@"dict is null , key = %@" ,key);
              }
              else  //key  is not null
              {
                  @try
                  {
                      if ([dynamcObject isKindOfClass:objClass])
                      {
                          [dynamcObject setValue:dict[key] forKey:key];
                      }
                  }
                  @catch (NSException * exception)
                  {
                      //                    DDLog(@"stringTansformArrayObjectWithClassName 运行动态解析是出现异常， exception : %@ : %@" , key , sourceDic[key]);
                      
                  }
              }

          }
        [mutableArray addObject:dynamcObject];
    }
    
    return (NSArray * )mutableArray;
}

+ (NSArray *)stringTansformArrayObjectWithDataSourceArray:(NSMutableArray *)array className:(NSString *)className
{
    NSMutableArray *newDataArray = [[NSMutableArray alloc] init];
    
    Class objClass = NSClassFromString(className);
    
    for (NSDictionary *dataDic in array) {
        
       id  model = [objClass new];
        
        [model setValuesForKeysWithDictionary:dataDic];
        
        [newDataArray addObject:model];
        
    }
    
    return newDataArray;
    
    
}
/**
 *  根据输入的id,动态获取其方法列表
 *
 *  @param objectClass 动态获取的id
 *
 *  @return 方法列表
 */
#pragma mark -- 私有函数
#pragma mark -- 获取对象方法列表 
NSArray *  getPropertyNameList(id objectClass )
{
    unsigned int numberofIvars = 0;
    objc_property_t * properties = class_copyPropertyList([objectClass class], &numberofIvars);
    NSMutableArray * propertyNameArray = [NSMutableArray new];
    for (unsigned int i = 0; i < numberofIvars; ++i)
    {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        [propertyNameArray addObject:[NSString stringWithUTF8String:name]];
    }

    free(properties);
    /**
     *   NSMutableArray *valueArray = [NSMutableArray array];    //value数组
     for (NSObject *object in array) {
     unsigned int numberofIvars = 0;
     Ivar* ivars = class_copyIvarList([object class], &numberofIvars);
     NSMutableArray *objectArray = [NSMutableArray array];
     for(const Ivar* p = ivars; p< ivars+numberofIvars;p++){
     Ivar const ivar = *p ;
     NSString* key = [NSString stringWithUTF8String:ivar_getName(ivar)];
     NSString *value = [object valueForKey:key];
     [objectArray addObject:value];
     }
     [valueArray addObject:objectArray];
     }
     return valueArray;
     */
    return propertyNameArray;
    
}

@end
