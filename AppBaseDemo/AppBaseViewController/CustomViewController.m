//
//  CustomViewController.m
//  HZAgentiOSClient
//
//  Created by sharui on 2016/11/10.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()


/**
 将要呈在上方的基本图层
 */
@property (nonatomic ,strong)UIView *frontBackView;

/**
 是否实现setUpSuperViewViewControllerUI方法
 */
@property (nonatomic ,assign ) BOOL isSetUpUI;



@end

@implementation CustomViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSAssert(self.isSetUpUI == YES,@"CustomViewController类 没有实现@“setUpSuperViewViewControllerUI”方法");
    
}


- (void)setUpSuperViewViewControllerUI
{
    
    [self.view addSubview:self.backScrollView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.rearTopView.frame = CGRectMake(0, 0, _rearTopView.width, _rearTopView.height);
    self.frontTopView.frame = CGRectMake(0, 0, _frontTopView.width, _frontTopView.height);
    self.frontScrollView.frame = CGRectMake(0, _frontTopView.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.frontTopView.height - 20 - 49);
    
    self.frontScrollView.delegate = self;
    self.frontScrollView.scrollEnabled = NO;
    self.backScrollView.scrollEnabled = YES;
    //    self.backScrollView.bounces = NO;
    self.isSetUpUI = YES;
    
}
- (void)viewWillLayoutSubviews {
        self.rearTopView.frame = CGRectMake(0, 0, _rearTopView.width, _rearTopView.height);
        _frontBackView.frame =  CGRectMake(0, CGRectGetMaxY(self.rearTopView.frame), _frontBackView.width, _frontBackView.height);
    [super viewWillLayoutSubviews];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self changeScrollEnableed:scrollView];
    
    
}
#pragma mark - scrollView 面包客方法
/**
 动画结束后调用
 
 @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.frontScrollView.scrollEnabled = NO;
    self.backScrollView.scrollEnabled = YES;
}

//改变是否可滑动
- (void)changeScrollEnableed: (UIScrollView *)scrollView {
    if (scrollView == self.backScrollView) {
        NSLog(@"backScrollView  :  %f",scrollView.contentOffset.y);

        if (self.backScrollView.contentOffset.y >= CGRectGetMaxY(_rearTopView.frame) - 64) {
            self.backScrollView.contentOffset = CGPointMake(0, CGRectGetMaxY(_rearTopView.frame) - 64);
            self.frontScrollView.scrollEnabled = YES;
            self.backScrollView.scrollEnabled = NO;
        }
        
    }
}


/**
 停止拖动时调用
 
 @param scrollView <#scrollView description#>
 @param decelerate <#decelerate description#>
 */
- (void)scrollViewDidEndDragging:(nonnull UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
    if (self.frontScrollView.contentOffset.y < -_DraggingHeight) {
        [self.backScrollView setContentOffset:CGPointZero animated:YES];
        self.frontScrollView.scrollEnabled = NO;
        self.backScrollView.scrollEnabled = YES;
    }
    NSLog(@"frontScrollView  :  %f",scrollView.contentOffset.y);
    
}

- (void)setBackScrollFrame:(CGRect)backScrollFrame {
    
    _backScrollFrame = backScrollFrame;
    self.backScrollView.frame = backScrollFrame;
}

#pragma - mark 懒加载
- (UIScrollView *)backScrollView {
    
    if (_backScrollView == nil) {
       
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49)];
        _backScrollView.delegate = self;
        [self.backScrollView addSubview:self.rearTopView];
        [self.backScrollView addSubview:self.frontBackView];
        self.backScrollView.scrollsToTop = YES;

    }
    _backScrollView.contentSize = CGSizeMake(0, _backScrollView.height + _rearTopView.height);
    _backScrollView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];

    return _backScrollView;
    
}

- (UIScrollView *)frontScrollView {
    if (_frontScrollView == nil) {
        _frontScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _frontTopView.height, SCREEN_WIDTH,_backScrollView.height - _frontTopView.height)];
        _frontScrollView.contentSize = CGSizeMake(0, _frontScrollView.height * 2);
        _frontScrollView.delegate = self;
    }
    
    return _frontScrollView;
}


- (UIView *)frontTopView {
    if (_frontTopView == nil) {
        _frontTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,50)];
    }
    return _frontTopView;
    
}
- (UIView *)rearTopView {
    
    if (_rearTopView == nil) {
        _rearTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,_rearTopView.height)];
    }
    return _rearTopView;
    
}
- (UIView *)frontBackView {
    if (_frontBackView == nil) {
        _frontBackView = [[UIView alloc] initWithFrame:CGRectMake(0, _rearTopView.height, SCREEN_WIDTH,_backScrollView.height)];
        [_frontBackView addSubview:self.frontScrollView];
        [_frontBackView addSubview:self.frontTopView];
        
    }
    _frontBackView.y = _rearTopView.height;
    return _frontBackView;
    
}

@end
