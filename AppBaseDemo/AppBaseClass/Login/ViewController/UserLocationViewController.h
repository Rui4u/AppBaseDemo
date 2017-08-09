//
//  UserLocationViewController.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/7.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseViewController.h"

@interface UserLocationViewController : BaseViewController
@property (nonatomic ,copy ) void (^locationBlock)(NSDictionary *dict);

@end
