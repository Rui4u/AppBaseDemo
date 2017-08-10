//
//  TopAdvertisementView.m
//  HZAgentiOSClient
//
//  Created by sharui on 2016/11/14.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "TopAdvertisementView.h"
#import "CustomPageView.h"
#import "HomeDataModel.h"
@interface TopAdvertisementView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


/**
 指示器
 */
@property (nonatomic ,strong ) CustomPageView * customPageView;

@end
static NSString * const reuseIdentifier = @"AdvertisementView";
@implementation TopAdvertisementView

- (instancetype)initWithFrame:(CGRect)frame
{
    self =  [super  initWithFrame:frame];
    if (self)
    {
        
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
    }
    return self;
}
#pragma mark - collection 面包客方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self.customPageView setRotationToNumber:(NSInteger)(scrollView.contentOffset.x /self.collectionView.width)];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bannerListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdvertisementView" forIndexPath:indexPath];

    UIImageView * iamgeView =[[UIImageView alloc] initWithFrame:_collectionView.bounds];
    [iamgeView sd_setImageWithURL:[NSURL URLWithString:self.bannerListArray[indexPath.item].url]];
	
	
    cell.backgroundView = iamgeView;

    cell.size = self.bounds.size;

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)setBannerListArray:(NSArray<BannerList *>*)bannerListArray
{
    _bannerListArray = bannerListArray;

//     _bannerListArray = [[NSMutableArray alloc]initWithCapacity:2];
    if (_customPageView != nil)
    {
        [_customPageView  removeFromSuperview];
    }
    if (_bannerListArray.count == 1)
    {
        
    }
    else
    {
        _customPageView = [[CustomPageView alloc] initWithNumber:self.bannerListArray.count];
        [self addSubview:_customPageView];
        [_customPageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-8);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(_customPageView.width, _customPageView.height));
        }];
  
    }
    
}
- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate  = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, _collectionView.height);
        //设置滑动方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _collectionView;
}

@end
