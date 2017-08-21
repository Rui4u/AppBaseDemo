//
//  ProductDetailViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/14.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "CustomScrollSelectView.h" //顶部
#import "ProdcutDetailBottomView.h"//底部
#import "ProductDetailTopView.h"
#import "ProductSpecificationParameterView.h"
#import "ProcudtDetailedInformationView.h"
#import "ProductDetailBussiness.h"
#import  "ProductDetaiModel.h"
#import "AddToShoppingCartAnimation.h"
#import  "ProductDetailGuiGeInfo.h"
#import "AddToShoppingCartAnimation.h"
#import "ShoppingCartChangeNumBussiness.h"
#import "DeleteCartBusiness.h"
#import "ProductAddListBussiness.h"
#import "DealWithShoppingCartData.h"
#import "CountPriceBussiness.h"
#import "CountPriceModel.h"
#import "ProductDetailWebView.h"
#import "ShoppingCartViewController.h"
@interface ProductDetailViewController () <ProductDetailTopViewDelegate,CustomScrollSelectViewDelegate,UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic ,strong ) CustomScrollSelectView * customScrollSelectView; //顶部
@property (nonatomic ,strong ) ProdcutDetailBottomView * prodcutDetailBottomView; //购物车
@property (nonatomic ,strong ) ProductDetailTopView * productDetailTopView; //头部
@property (nonatomic ,strong ) ProcudtDetailedInformationView * procudtDetailedInformationView;
@property (nonatomic ,strong ) ProductSpecificationParameterView * productSpecificationParameterView;
@property (nonatomic ,strong ) UIScrollView * bgScrollView;
/**
 <#Description#>
 */
@property (nonatomic ,strong) Goods * goodsDataSourse;
/**
 <#Description#>
 */
@property (nonatomic ,assign) BOOL canScroll;

/**
 记录上一个 判断是否需要出现红点
 */
@property (nonatomic ,assign ) NSInteger count;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setNavUI];
    [self setBottomViewUI];
    [self pullToRefresh];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	
}
- (void)pullToRefresh {
    
    
    [ProductDetailBussiness requestProductDetailWithToken:TOKEN goodsId:self.goodsId completionSuccessHandler:^(ProductDetaiModel *productModel) {
        
        
        self.goodsDataSourse = productModel.goods;
        [self reloadeData];
        [self.bgScrollView.mj_header endRefreshing];
        
    } completionFailHandler:^(NSString *failMessage) {
        
        [self showToastWithMessage:failMessage showTime:1];
        [self.bgScrollView.mj_header endRefreshing];
    } completionError:^(NSString *netWorkErrorMessage) {
        
        [self showToastWithMessage:netWorkErrorMessage showTime:1];
        [self.bgScrollView.mj_header endRefreshing];
    }];
    
}
#pragma mark - 刷新数据
- (void)reloadeData {

    self.navBarView.alpha = 0;
    [self.view addSubview:self.bgScrollView];
    
    [self setUPTopViewUI];
    [self setUpProcudtDetailedInformationViewUI];
    [self.view setNeedsLayout];
    [self setUpProductSpecificationParameterViewUI];
    [self.view bringSubviewToFront:self.navBarView];
    [self.view bringSubviewToFront:_prodcutDetailBottomView];
    
    self.bgScrollView.contentSize = CGSizeMake(0, self.productSpecificationParameterView.bottom + 20);
    _prodcutDetailBottomView.numText = [NSString stringWithFormat:@"%tu",[ShoppingCartManager sharedManager].selectNumber];
    [self changeShoppingCartNumberWithCurrent:@"" andIndex:1];
}

#pragma - 点击添加产品回调
-(void)changeNumberWith:(NSString *)count withRect:(CGRect)rect withGuiGeIndex:(NSInteger)index{
    
    NSString * guigeId = self.goodsDataSourse.guige[index].guigeID;
    NSString * goodsId = self.goodsDataSourse.goodsId;
	self.goodsDataSourse.guige[index].carGoodNum = count;
	
	[[ShoppingCartManager sharedManager] addobjectWith:self.goodsDataSourse withGuiGeIndex:index];

	[CommonNotification postNotification:CNotificationShoppingCartNumberNotify userInfo:nil object:nil];
	
    if(count.integerValue == 0){
        NSLog(@"删除");
		
		[[ShoppingCartManager sharedManager] removeobjectWith:self.goodsDataSourse withGuiGeIndex:index];

        NSMutableArray * goodListArray = [[NSMutableArray alloc] init];
        NSMutableDictionary * goodInfoDict = [[NSMutableDictionary alloc] init];
        NSMutableArray * goodsSpecArray = [[NSMutableArray alloc] init];
        NSMutableDictionary * goodsSpecDict = [[NSMutableDictionary alloc] init];
        
        
        goodsSpecDict = @{@"id":guigeId}.mutableCopy;
        [goodsSpecArray addObject:goodsSpecDict];
        [goodInfoDict  setValue:goodsId forKey:@"id"];
        [goodInfoDict  setValue:goodsSpecArray forKey:@"goodsSpec"];
        
        [goodListArray addObject:goodInfoDict];
        
        [DeleteCartBusiness requestDeleteCartWithToken:TOKEN goodsList:goodListArray completionSuccessHandler:^(NSString *getSelectedProductModel) {
            
        } completionFailHandler:^(NSString *failMessage) {
            [self showToastWithMessage:failMessage showTime:1];
        } completionError:^(NSString *netWorkErrorMessage) {
            [self showToastWithMessage:netWorkErrorMessage showTime:1];
        }];
        
    }else {
        
        if (count.integerValue > self.count) {
            
            
            CGRect endRect = [_prodcutDetailBottomView.numberLabel convertRect: _prodcutDetailBottomView.numberLabel.bounds toView:APP_DELEGATE.window];
            
            [[AddToShoppingCartAnimation sharedAnimation] animationWith:self.view andPoint:rect.origin andEndPoint:CGPointMake(endRect.origin.x +endRect.size.width, endRect.origin.y)];
        }
        self.count = count.integerValue;
        
        
        [ShoppingCartChangeNumBussiness requestShoppingCartChangeNumWithToken:TOKEN
                                                                      goodsId:goodsId
                                                                       specId:guigeId                                                               num:count
                                                     completionSuccessHandler:^(NSString *succeed)
         {
             
         } completionFailHandler:^(NSString *failMessage) {
             [self showToastWithMessage:failMessage showTime:1];
         } completionError:^(NSString *netWorkErrorMessage) {
             [self showToastWithMessage:netWorkErrorMessage showTime:1];
         }];
    }
    //改变个数
    [self changeShoppingCartNumberWithCurrent:count andIndex:index];

}


#pragma mark - 改变购物车个数

- (void)changeShoppingCartNumberWithCurrent:(NSString *)count andIndex:(NSInteger)index {
    
	
    _prodcutDetailBottomView.numText = [NSString stringWithFormat:@"%tu",[ShoppingCartManager sharedManager].selectNumber];
    
    
    
    NSArray * array = [DealWithShoppingCartData dealWithShoppingCartDataWith:[ShoppingCartManager sharedManager].CarInfoList];
    
    
    
    [CountPriceBussiness requestCountPriceWithToken:TOKEN status:@"1" goodsList:array completionSuccessHandler:^(CountPriceModel *getSelectedProductModel) {
        
        _prodcutDetailBottomView.priceText = [NSString stringWithFormat:@"总价:{￥%@}",getSelectedProductModel.totalcurrentPrice];
        
    } completionFailHandler:^(NSString *failMessage) {
        [self showToastWithMessage:failMessage showTime:1];
        
    } completionError:^(NSString *netWorkErrorMessage) {
        [self showToastWithMessage:netWorkErrorMessage showTime:1];
    }];
    

}
#pragma mark - 点击反馈
- (void)clickRightButton {
    
    
}

#pragma mark - 设置产品信息UI
- (void)setUpProcudtDetailedInformationViewUI {

    _procudtDetailedInformationView = [[NSBundle mainBundle]loadNibNamed:@"ProcudtDetailedInformationView"
                                                                       owner:self
                                                                     options:nil].firstObject;
    [_bgScrollView addSubview:_procudtDetailedInformationView];
    CGFloat tempHeight = 50;
    NSArray * detailInfoImage = [_goodsDataSourse.detailsImage componentsSeparatedByString:@","];
    for (int i = 0; i <detailInfoImage.count; i++) {
        
//        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50 + i * (AutoHeight(200) + 10), SCREEN_WIDTH, AutoHeight(300))];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:detailInfoImage[i]] placeholderImage:nil];
//        [_procudtDetailedInformationView addSubview:imageView];
		
		        ProductDetailWebView * webView = [[ProductDetailWebView alloc] initWithFrame:CGRectMake(0, 50 + i * (AutoHeight(200) + 10), SCREEN_WIDTH, AutoHeight(300))];
			[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];

		        [_procudtDetailedInformationView addSubview:webView];
		webView.delegate = self;
		int totalHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];
		webView.scrollView.scrollEnabled = NO;

		tempHeight = totalHeight;
    }
    
		_procudtDetailedInformationView.frame = CGRectMake(0, CGRectGetMaxY(_productDetailTopView.frame) , SCREEN_WIDTH, tempHeight);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
	NSLog(@"webView:%@",NSStringFromCGSize(fittingSize));
	
	webView.height = fittingSize.height;
	_procudtDetailedInformationView.frame = CGRectMake(0, CGRectGetMaxY(_productDetailTopView.frame) , SCREEN_WIDTH, webView.height);
	[self reloadeFrame];

}

- (void)reloadeFrame {

	self.productSpecificationParameterView.frame = CGRectMake(0, self.procudtDetailedInformationView.bottom + 10, SCREEN_WIDTH, self.productSpecificationParameterView.height);
	self.bgScrollView.contentSize = CGSizeMake(0, self.productSpecificationParameterView.bottom + 20);

}
#pragma 设置产品规格UI
- (void) setUpProductSpecificationParameterViewUI{
    self.productSpecificationParameterView = [[NSBundle mainBundle]loadNibNamed:@"ProductSpecificationParameterView"
                                                                          owner:self
                                                                        options:nil].firstObject;
    
    
    [self.bgScrollView addSubview:self.productSpecificationParameterView];
    NSMutableArray * tempArray = [NSMutableArray arrayWithCapacity:1];
    
    
    if (self.goodsDataSourse.brand != nil && ![self.goodsDataSourse.brand isEqualToString:@""]) {
        [tempArray addObject:@{	@"text":self.goodsDataSourse.brand,
                                @"title":@"品牌"
                                }];
    }
    
    [tempArray addObject:@{	@"text":[NSString stringWithFormat:@"%@(%@斤)",self.goodsDataSourse.baseSpec,self.goodsDataSourse.guige.firstObject.totalWeight],
                            @"title":@"规格"
                            }];
    
    if (self.goodsDataSourse.feature != nil) {
        [tempArray addObject:@{	@"text":self.goodsDataSourse.feature,
                                @"title":@"等级"
                                }];
    }
    if (self.goodsDataSourse.baseSpec != nil) {
        [tempArray addObject:@{	@"text":self.goodsDataSourse.baseSpec,
                                @"title":@"包装"
                                }];
    }
    if (self.goodsDataSourse.place != nil) {
        [tempArray addObject:@{	@"text":self.goodsDataSourse.place,
                                @"title":@"生产地"
                                }];
    }
    if (self.goodsDataSourse.producer != nil) {
        [tempArray addObject:@{	@"text":self.goodsDataSourse.producer,
                                @"title":@"生产商"
                                }];
    }
    
    NSInteger tempHeight = 0;
    
    for (int i= 0; i <tempArray.count; i ++) {
        ProductDetailGuiGeInfo * productDetailGuiGeInfo = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailGuiGeInfo" owner:self options:nil].firstObject;
        productDetailGuiGeInfo.frame = CGRectMake(0, 50 + i * 40, SCREEN_WIDTH, 40);
        productDetailGuiGeInfo.guigeTitle.text = tempArray[i][@"title"];
        productDetailGuiGeInfo.guigeTextLabel.text = tempArray[i][@"text"];
        tempHeight = productDetailGuiGeInfo.bottom + 10;
        [self.productSpecificationParameterView addSubview:productDetailGuiGeInfo];
    }
    
    self.productSpecificationParameterView.frame = CGRectMake(0, self.procudtDetailedInformationView.bottom + 10, SCREEN_WIDTH, tempHeight);
    

}

#pragma mark - 顶部View
- (void)setUPTopViewUI{
    
    _productDetailTopView = [[ProductDetailTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 800) withGootDataSourse:self.goodsDataSourse];
    _productDetailTopView.delegate = self;
    
    UIButton *backButton= ({
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 22, 50, 44)];
        [backButton setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        backButton;
    });
    
    [_bgScrollView addSubview:_productDetailTopView];
    [_productDetailTopView addSubview:backButton];
    
    __weak typeof(self) weakSelf = self;
    _productDetailTopView.clickAddProductListButton = ^(UIButton *sender) {
        sender.selected = YES;
        [ProductAddListBussiness requestProductAddListWithToken:TOKEN goodsId:weakSelf.goodsId completionSuccessHandler:^(BOOL succeed) {
            NSLog(@"加入清单成功");
            
            sender.selected = succeed;
            sender.enabled = !succeed;
            
        } completionFailHandler:^(NSString *failMessage) {
            [weakSelf showToastWithMessage:failMessage showTime:1];
        } completionError:^(NSString *netWorkErrorMessage) {
            [weakSelf showToastWithMessage:netWorkErrorMessage showTime:1];
        }];
    };
}

#pragma mark - 底部去购物车UI
- (void)setBottomViewUI {
    

    _prodcutDetailBottomView = [[NSBundle mainBundle] loadNibNamed:@"ProdcutDetailBottomView" owner:self options:nil].firstObject;
    [self.view addSubview:_prodcutDetailBottomView];
    
    [_prodcutDetailBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@60);
    }];
    
    __weak typeof(self) weakSelf = self;
    _prodcutDetailBottomView.gotoProductCart = ^{
        ShoppingCartViewController * shoppingCartViewController = [[ShoppingCartViewController alloc] init];
        
        shoppingCartViewController.navBarType = NAV_BAR_TYPE_SECOND_LEVEL_VIEW;
        [weakSelf.navigationController pushViewController:shoppingCartViewController animated:YES];
    };
}

#pragma mark - navbar
- (void)setNavUI {
    
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    [self.navBarView setTitle:@"商品信息"];
    
    _customScrollSelectView = ({
        CustomScrollSelectView * selectView= [[CustomScrollSelectView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, 48)];
        selectView.textColor = [UIColor blackColor];
        selectView.delegate = self;
        selectView.customTextAlignment = CustomTextAlignmentCenter;
        selectView.dataSourse = @[@"商品",@"详细信息",@"规格参数"];
        [selectView reloadeData];
        [selectView selectSwitchButtonAtIndex:0 withClick:NO];
        selectView;
    });
    
    
    UIButton * rightButton =({
        UIButton * rightButton = [UIButton quickCreateButtonWithFrame:CGRectMake(SCREEN_WIDTH-AutoHeight(44) - 20, 20, AutoHeight(44), AutoHeight(44))
                                                                title:@"反馈"
                                                            addTarget:self
                                                               action:@"clickRightButton"];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        rightButton.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentRight;
        [rightButton setTitleColor:[UIColor colorWithHexString:Main_Font_Green_Color] forState:UIControlStateNormal];
        rightButton;
    });
    
    [self.navBarView addSubview:_customScrollSelectView];
    [self.navBarView addSubview:rightButton];
    
    self.navBarView.height = 64 + 48;
    
}

- (void)backButtonPressed:(UIButton *)sender {
    [self back];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -lazyLoad
- (UIScrollView *)bgScrollView {
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.delegate = self;
        _bgScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 60);
    }
    return _bgScrollView;
}

#pragma mark - 点击title代理
- (void)customScrollSelectView:(CustomScrollSelectView *)customScrollSelectView didSelectWithProductTypeModel:(NSInteger)index {
    
    self.canScroll = NO;
    if (index == 0) {
        [self.bgScrollView setContentOffset:CGPointMake(0, -1) animated:YES];
    }else if (index == 1) {
        [self.bgScrollView setContentOffset:CGPointMake(0, self.productDetailTopView.height - self.navBarView.height)animated:YES];
    }else if (index == 2) {
        [self.bgScrollView setContentOffset:CGPointMake(0,self.procudtDetailedInformationView.bottom - self.bgScrollView.height + 100) animated:YES];
    }
    
}
#pragma mark - 滑动代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.canScroll = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.navBarView.alpha = scrollView.contentOffset.y/120;
    
    if (self.canScroll) {
        //控制滑动时选择哪个标题
        if (self.bgScrollView.contentOffset.y > self.productDetailTopView.height - self.navBarView.height) {
            NSLog(@"%f",self.procudtDetailedInformationView.bottom - self.bgScrollView.height);
            if (self.bgScrollView.contentOffset.y > self.procudtDetailedInformationView.bottom - self.bgScrollView.height) {
                [self.customScrollSelectView selectSwitchButtonAtIndex:2 withClick:NO];
            }else {
                [self.customScrollSelectView selectSwitchButtonAtIndex:1 withClick:NO];
            }
        }else {
            [self.customScrollSelectView selectSwitchButtonAtIndex:0 withClick:NO];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.canScroll = YES;
}

- (void)dealloc {
    
}


@end
