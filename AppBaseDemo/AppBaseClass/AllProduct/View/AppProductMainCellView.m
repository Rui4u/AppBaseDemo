//
//  AppProductMainCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/31.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AppProductMainCellView.h"
#import "SelectSpecificationView.h"
#import "GetSelectedProductModel.h"
@interface AppProductMainCellView ()
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UIButton *addButtonOrOpenButton;

/**
 <#Description#>
 */
@property (nonatomic ,strong) SelectSpecificationView * selectSpecificationView;;

@end
@implementation AppProductMainCellView

- (IBAction)clickProductButton:(UIButton *)sender {
	if ([self.delegate respondsToSelector:@selector(clickProductButtonWith:withSection:)]) {
		[self.delegate clickProductButtonWith:sender withSection:self.section];
	}
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    SelectSpecificationView * selectSpecificationView = [[SelectSpecificationView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.productName.frame)  ,CGRectGetMaxY(self.productName.frame),self.width,66)];
    self.selectSpecificationView = selectSpecificationView;
    selectSpecificationView.index = 0;
    [self addSubview:selectSpecificationView];
//    
//
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setDataSourse:(GoodsList *)dataSourse {
    _dataSourse = dataSourse;
    
    self.productName.text = [NSString stringWithFormat:@"%@ %@",dataSourse.fullName,dataSourse.feature];
    
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:dataSourse.image] placeholderImage:[UIImage imageNamed:@"guess_bancai"]];
    
    
    self.selectSpecificationView.totolPriceLabel.text = [NSString stringWithFormat:@"￥%@/%@(%@斤)",dataSourse.guige.firstObject.currentPrice,dataSourse.baseSpec,dataSourse.guige.firstObject.totalWeight];

    self.selectSpecificationView.averagePrice.text = [NSString stringWithFormat:@"{￥%@}{/%@}",dataSourse.guige.firstObject.avgPrice,dataSourse.baseSpec];
    
    
  
    self.selectSpecificationView.averagePrice.attributedText =
    [NSMutableAttributedString setAttributeString:self.selectSpecificationView.averagePrice.text
                                             font:15
                                        textcolor:[UIColor colorWithHexString:Main_Font_Red_Color]
                                      secondcolor:[UIColor colorWithHexString:Main_Font_Gary_Color]
                                       secondfont:12];

 
    
    
    
    
        if ([dataSourse.discount isEqualToString:@"1"]) {
            self.selectSpecificationView.showDisCountView = YES;
        }else {
            self.selectSpecificationView.showDisCountView = NO;
        }
    if (dataSourse.guige.count > 1) {
        [self.addButtonOrOpenButton setImage:[UIImage imageNamed:@"selectGuiGe"] forState:UIControlStateNormal];
    } else {
        [self.addButtonOrOpenButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    }
}

@end
