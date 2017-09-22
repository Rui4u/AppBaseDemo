//
//  ProtocolViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/9/22.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProtocolViewController.h"

@interface ProtocolViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:self.titlestr];
	self.textView.text = self.textStr;
	
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
