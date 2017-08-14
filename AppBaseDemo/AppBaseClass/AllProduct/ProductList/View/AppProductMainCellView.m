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
#import "SelectAddView.h"
@interface AppProductMainCellView ()<SelectAddViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UIButton *addOpenOrCloseButton;

/**
 <#Description#>
 */
@property (nonatomic ,strong) SelectSpecificationView * selectSpecificationView;;

/**
 SelectAddView * selectAddView
 */
@property (nonatomic ,strong) SelectAddView * selectAddView;
@end
@implementation AppProductMainCellView

- (IBAction)clickOpenAndCloseButton:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickOpenOrCloseButton:withIndex:)]) {
        [self.delegate clickOpenOrCloseButton:sender withIndex:self.section];
    }
}

-(void)changeNumberWith:(NSString *)count {
    
    if ([self.delegate respondsToSelector:@selector(clickProductButtonWith:withSection:withCount:)]) {
        [self.delegate clickProductButtonWith:_addOpenOrCloseButton withSection:self.section withCount:count];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    SelectSpecificationView * selectSpecificationView = [[SelectSpecificationView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.productName.frame)  ,CGRectGetMaxY(self.productName.frame),self.width,66)];
    self.selectSpecificationView = selectSpecificationView;
    selectSpecificationView.index = 0;
    [self addSubview:selectSpecificationView];

    _selectAddView = ({
        SelectAddView * selectAddView = [[NSBundle mainBundle] loadNibNamed:@"SelectAddView" owner:self options:nil].firstObject;
        selectAddView.delegate = self;
        selectAddView;
    });
    
    [self addSubview:_selectAddView];
    
    [_selectAddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.size.mas_offset(CGSizeMake(90, 30));
    }];
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
    
    if ([dataSourse.discount isEqualToString:@"1"]) {
        _selectAddView.isDiscount = YES;
    }else {
        _selectAddView.isDiscount = NO;
    }
    
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
        [self.addOpenOrCloseButton setImage:[UIImage imageNamed:@"selectGuiGe"] forState:UIControlStateNormal];
        self.selectAddView.hidden = YES;
        self.addOpenOrCloseButton.hidden = NO;
    } else {
        [self.addOpenOrCloseButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        self.selectAddView.hidden = NO;
        self.addOpenOrCloseButton.hidden = YES;
    }
}

@end
