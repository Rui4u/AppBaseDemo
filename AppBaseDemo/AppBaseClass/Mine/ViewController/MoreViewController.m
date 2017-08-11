//
//  MoreViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreBaseView.h"
@interface MoreViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	MoreBaseView * moreBaseView = [[NSBundle mainBundle] loadNibNamed:@"MoreBaseView" owner:self options:nil].firstObject;
	moreBaseView.frame = CGRectMake(0, 0, 375, 667);
	[_bgScrollView addSubview:moreBaseView];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
