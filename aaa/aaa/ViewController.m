//
//  ViewController.m
//  aaa
//
//  Created by sharui on 2017/8/10.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ViewController.h"
#import "CityNotInOpenCityView.h"
@interface ViewController ()
@property (nonatomic ,strong ) CityNotInOpenCityView * cityNotInOpenCityView;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_cityNotInOpenCityView = [[NSBundle mainBundle]loadNibNamed:@"CityNotInOpenCityView" owner:self options:nil].firstObject;
	_cityNotInOpenCityView.frame = CGRectMake(0,0,300,300);

	[self.view addSubview:self.cityNotInOpenCityView];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
