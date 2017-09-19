//
//  ProductCategoryCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ProductCategoryCell.h"
#import "FillOrderModel.h"
@interface ProductCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *totalNum;

@end
@implementation ProductCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCarInfo:(NSArray<CarInfo *> *)carInfo {

    self.totalNum.text = [NSString stringWithFormat:@"共%lu类",(unsigned long)carInfo.count];
    for (int i = 0 ; i <carInfo.count ; i ++ ) {
        
        UIImageView * imageView = [[UIImageView alloc] init];
		
		imageView.contentMode = UIViewContentModeScaleAspectFill;
		imageView.layer.masksToBounds = YES;
		
        imageView.frame = CGRectMake((105) * i , 5, 105- 10, 105- 10);
        [self.bgView addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:carInfo[i].image] placeholderImage:[UIImage imageNamed:@"guess_bancai"]];
        if (imageView.right > _bgView.width) {
            imageView.hidden = YES;
        }else {
            imageView.hidden = NO;
        }
    }
    _bgView.clipsToBounds = YES;

}

@end
