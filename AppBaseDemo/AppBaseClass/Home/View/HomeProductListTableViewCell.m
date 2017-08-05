//
//  HomeProductListTableViewCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/5.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "HomeProductListTableViewCell.h"
#import "SelectSpecificationView.h"
#import "HomeDataModel.h"
@interface HomeProductListTableViewCell ()

/**
 procut图片
 */
@property (nonatomic ,strong) UIImageView * iconView;

/**
 标题
 */
@property (nonatomic ,strong) UILabel * titleLabel;

/**
 底部view
 */
@property (nonatomic ,strong) UIView * bottomBgView;

/**
 上部View
 */
@property (nonatomic ,strong) UIView * topBgView;
/**
 <#Description#>
 */
@property (nonatomic ,strong) UIView * bgView;
@end

@implementation HomeProductListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self privateSetUpUI];
    }
    return self;
}
- (void)privateSetUpUI {

    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH - 10, 100)];
    self.bgView.backgroundColor = [UIColor randomOfColor];
    [self.contentView addSubview:self.bgView];
    
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 72, 72)];
    [self.bgView addSubview:self.iconView];
    self.iconView.backgroundColor = [UIColor randomOfColor];

    self.topBgView = [[UIView alloc] initWithFrame:CGRectMake(self.iconView.right + 10, self.iconView.y,self.bgView.width - self.iconView.right -10 , 38)];
    [self.bgView addSubview:self.topBgView];
    
    self.titleLabel = [UILabel creatLabelWithText:@"香菜" FontOfSize:14 textColor:@"333333"];
    self.titleLabel.frame = CGRectMake(0,0, 200, self.topBgView.height);
    [self.topBgView addSubview:self.titleLabel];

    
    UIButton * deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.topBgView.width - 44 - 15, 0, self.topBgView.height, self.topBgView.height)];
    deleteButton.backgroundColor = [UIColor randomOfColor];
    [self.topBgView addSubview:deleteButton];
    
    UILabel *selectLabel = [UILabel creatLabelWithText:@"选规格 " FontOfSize:12 textColor:Main_Font_Gary_Color];
    selectLabel.userInteractionEnabled = YES;
    [selectLabel sizeToFit];
    
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    
    [selectLabel addGestureRecognizer:tapGesture];
    
    selectLabel.frame = CGRectMake(deleteButton.x - selectLabel.width, 0, selectLabel.width,self.topBgView.height);
    [self.topBgView addSubview:selectLabel];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topBgView.height - 1, self.topBgView.width,1)];
    lineView.backgroundColor = [UIColor colorWithHexString:Main_Line_Gary_Color];
    
    [self.topBgView addSubview:lineView];
    
    self.titleLabel.width = selectLabel.x - self.titleLabel.x - 5;
    
    self.bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(self.iconView.right + 10, self.topBgView.bottom,self.bgView.width - self.iconView.right -10 , 60)];
    self.bottomBgView.clipsToBounds = YES;
    [self.contentView addSubview:self.bottomBgView];
    self.contentView.clipsToBounds = YES;

}

- (void)setDataSourse:(ProductList *)dataSourse {
    _dataSourse = dataSourse;
    self.titleLabel.text = [NSString stringWithFormat:@"[%@]%@",dataSourse.companyName,dataSourse.productName];
    for (UIView *view  in self.bottomBgView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat selectViewHeight = 0;
    
    NSInteger count = 0 ;
    if (self.dataSourse.isOpen) {count = dataSourse.guige.count;}
    else {count = 1;}
    
    for (int i = 0; i < count;  i ++) {
        Guige * guige = dataSourse.guige[i];
        
        SelectSpecificationView * selectSpecificationView = [[SelectSpecificationView alloc] initWithFrame:CGRectMake(0,i *selectViewHeight,self.bottomBgView.width,66)];
        selectViewHeight = selectSpecificationView.height;
        [self.bottomBgView addSubview:selectSpecificationView];
        
        selectSpecificationView.totolPriceLabel.text = guige.totolPrice;
        selectSpecificationView.averagePrice.text = guige.averagePrice;
        self.bottomBgView.height = selectSpecificationView.bottom;
        self.bgView.height = self.bottomBgView.bottom;
        self.dataSourse.height = self.bgView.height + 10;
    }
}

-(void)Actiondo:(id)sender {
    
    
    self.dataSourse.open = !self.dataSourse.open;
    
    if (self.dataSourse.isOpen) {
        self.dataSourse.height = self.topBgView.height + self.dataSourse.guige.count * 66 + 10;
    }
    
    [self.delegate ClickSelectSpecificationWithIndexPath:_indexPath];
}
@end
