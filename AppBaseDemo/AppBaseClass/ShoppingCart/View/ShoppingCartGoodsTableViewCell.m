//
//  ShoppingCartGoodsTableViewCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ShoppingCartGoodsTableViewCell.h"
#import "ShoppingCartListModel.h"
@interface ShoppingCartGoodsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *selectNumber;

@property (weak, nonatomic) IBOutlet UILabel *totolPrice;

@property (weak, nonatomic) IBOutlet UILabel *goodTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *goodSelectButton;

@property (weak, nonatomic) IBOutlet UIImageView *goodPic;

@end
@implementation ShoppingCartGoodsTableViewCell

- (void)selectAllOrCancelWith:(BOOL)selectAll {
	if (selectAll) {
		[self clickGoodSelectButton:self.goodSelectButton];
	}

}
- (IBAction)clickGoodSelectButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.dataSourse.selected = sender.selected;
    
    NSInteger totolNum = 0;
    CGFloat totolNumPrice = 0;
    for (Guige *guige in self.dataSourse.guige) {
        guige.selected = sender.selected;
        if (guige.isSelected == YES) {
            
            totolNum += guige.carGoodNum.integerValue;
            totolNumPrice += (guige.carGoodNum.integerValue *guige.currentPrice.floatValue);
        }
    }
    

    
    self.dataSourse.selectNum = [NSString stringWithFormat:@"%ld",totolNum];
    self.dataSourse.totolPriceNum = [NSString stringWithFormat:@"%.2f",totolNumPrice];
    
    if (self.selectShoppingCartGoodsBlock) {
        self.selectShoppingCartGoodsBlock(self.indexPath);
    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	self.goodPic.contentMode = UIViewContentModeScaleAspectFill;
	self.goodPic.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataSourse:(Goods *)dataSourse {
    _dataSourse = dataSourse;
    if (dataSourse.brand == nil  || [dataSourse.brand isEqualToString:@""]) {
        self.goodTitleLabel.text = [NSString stringWithFormat:@"%@ %@",dataSourse.fullName,dataSourse.feature];
        
    }else{
        if (dataSourse.feature == nil) {
            dataSourse.feature = @"";
        }
        self.goodTitleLabel.text = [NSString stringWithFormat:@"[%@]%@ %@",dataSourse.brand,dataSourse.fullName,dataSourse.feature];
    }
    
    self.selectNumber.text = [NSString stringWithFormat:@"已选{%@}%@",[NSString stringWithFormat:@"%ld",dataSourse.selectNum.integerValue],self.dataSourse.baseSpec];
    
    self.totolPrice.text = [NSString stringWithFormat:@"小计{￥%@}",[NSString stringWithFormat:@"%.2f",dataSourse.totolPriceNum.floatValue]];
    
    
    _selectNumber.attributedText =
    [NSMutableAttributedString setAttributeString:_selectNumber.text
                                             font:12
                                        textcolor:[UIColor colorWithHexString:Main_Font_Red_Color]
                                      secondcolor:[UIColor colorWithHexString:Main_Font_Gary_Color]
                                       secondfont:12];
    
    _totolPrice.attributedText =
    [NSMutableAttributedString setAttributeString:_totolPrice.text
                                             font:12
                                        textcolor:[UIColor colorWithHexString:Main_Font_Red_Color]
                                      secondcolor:[UIColor colorWithHexString:Main_Font_Gary_Color]
                                       secondfont:12];
    
    [self.goodPic sd_setImageWithURL:[NSURL URLWithString:dataSourse.image] placeholderImage:[UIImage imageNamed:@"guess_bancai"]];
    _goodSelectButton.selected = dataSourse.selected;
}

@end
