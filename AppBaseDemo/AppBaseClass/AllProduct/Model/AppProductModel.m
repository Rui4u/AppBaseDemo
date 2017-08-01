//
//  AppProductModel.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/1.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AppProductModel.h"

@implementation AppProductModel
- (NSArray *)moreSpecificationArray {
	if (_moreSpecificationArray ==nil) {
		NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
		for (int i = 0; i < arc4random_uniform(4); i++) {
			[array addObject:@"1"];
		}
		_moreSpecificationArray = array.copy;
	}
	
	return _moreSpecificationArray;
}
@end
