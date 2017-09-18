//
//  payStatusVC.m
//  GPhoneFlowiOSClient
//
//  Created by Livia on 16/9/12.
//  Copyright © 2016年 ZhentaiNing. All rights reserved.
//

#import "payStatusVC.h"
#import "RootViewController.h"
@interface payStatusVC ()
@property (weak, nonatomic) IBOutlet UIImageView *payStatusImageView;
@property (weak, nonatomic) IBOutlet UILabel *payStatusLabel;

@end

@implementation payStatusVC
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initNavBarView:NAV_BAR_TYPE_ROOT_VIEW];
    
    UIButton * userCenter = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 44, 20, 44, 44)];
    [userCenter addTarget: self action:@selector(payComplete) forControlEvents:UIControlEventTouchUpInside];
    [userCenter setTitle:@"完成" forState:UIControlStateNormal];
    userCenter.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.navBarView addSubview:userCenter];
    
    
    switch (self.payStatus) {
        case payStatusSuccessd:
        {
            self.payStatusLabel.text = @"支付成功";
            self.payStatusImageView.image = [UIImage imageNamed:@"icon_success"];
        }
            break;
        case payStatusFail:
        {
            self.payStatusLabel.text = @"支付失败";
            self.payStatusImageView.image = [UIImage imageNamed:@"pic_fail"];
        }
            break;
        case payStatusCancel:
        {
            self.payStatusLabel.text = @"支付失败";
            self.payStatusImageView.image = [UIImage imageNamed:@"pic_fail"];
        }
            break;
        default:
            break;
    }
    
    [self.navBarView setTitle:self.payStatusLabel.text];

}
/**
 *  支付完成
 */
- (void)payComplete {
    
    
    [self back];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)back {

    [self dismissViewControllerAnimated:YES completion:nil];
    [APP_DELEGATE.navgationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[RootViewController class]]) {
            [APP_DELEGATE.navgationController popToViewController:obj animated:NO];
            return;
        
        }
    }];
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
