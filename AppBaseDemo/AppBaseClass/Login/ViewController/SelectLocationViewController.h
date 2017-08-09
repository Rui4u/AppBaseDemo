//
//  SelectLocationViewController.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseViewController.h"
#import "SelectCityModel.h"
@interface SelectLocationViewController : BaseViewController
@property (nonatomic ,copy ) void (^locationBlock)(Info *dict);
@end
