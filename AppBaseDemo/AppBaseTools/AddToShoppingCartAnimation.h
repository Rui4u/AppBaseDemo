//
//  AddToShoppingCartAnimation.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddToShoppingCartAnimation : NSObject
+ (instancetype)sharedAnimation;
- (void)animationWith:(UIView *)view  andPoint:(CGPoint)startPorin andEndPoint:(CGPoint)endPoint;
@end
