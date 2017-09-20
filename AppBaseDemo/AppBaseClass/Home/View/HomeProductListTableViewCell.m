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
#import "SelectAddView.h"
#import "NewCustomAlertView.h"
@interface HomeProductListTableViewCell () <SelectSpecificationViewDelegate>

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

/**
 选规格 标签
 */
@property (nonatomic ,strong ) UIButton *selectLabel;
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

    [self.contentView addSubview:self.bgView];
    
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 65, 65)];
	self.iconView.contentMode = UIViewContentModeScaleAspectFill;
	self.iconView.layer.masksToBounds = YES;
    [self.bgView addSubview:self.iconView];

    self.topBgView = [[UIView alloc] initWithFrame:CGRectMake(self.iconView.right + 10, self.iconView.y,self.bgView.width - self.iconView.right -10 , 40)];
    [self.bgView addSubview:self.topBgView];
    
    self.titleLabel = [UILabel creatLabelWithText:@"" FontOfSize:14 textColor:Main_Font_Black_Color];
    self.titleLabel.frame = CGRectMake(0,0, 200, self.topBgView.height);
    [self.topBgView addSubview:self.titleLabel];

    
    UIButton * deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.topBgView.width - 44 - 15, 0, self.topBgView.height, self.topBgView.height)];
    [deleteButton setTitleColor:[UIColor colorWithHexString:Main_Font_SecondBlack_Color] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(clickDeteleButton:) forControlEvents:UIControlEventTouchUpInside];
	[deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.topBgView addSubview:deleteButton];
    
    
//    l = [UILabel creatLabelWithText:@"选规格 " FontOfSize:12 textColor:Main_Font_SecondBlack_Color];
    self.selectLabel = [UIButton quickCreateButtonWithFrame:CGRectMake(deleteButton.x - 70, 0, 70,self.topBgView.height) title:@"选规格" addTarget:self action:@"Actiondo:"];
    self.selectLabel.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.selectLabel setTitleColor:[UIColor colorWithHexString:Main_Font_SecondBlack_Color] forState:UIControlStateNormal];
    [self.topBgView addSubview:_selectLabel];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topBgView.height - 1, self.topBgView.width,1)];
    lineView.backgroundColor = [UIColor colorWithHexString:Main_Line_Gary_Color];
    
    [self.topBgView addSubview:lineView];
    
    self.titleLabel.width = _selectLabel.x - self.titleLabel.x - 5;
    
    self.bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(self.iconView.right + 8, self.topBgView.bottom,self.bgView.width - self.iconView.right - 8 , 65)];
    self.bottomBgView.clipsToBounds = YES;
    [self.contentView addSubview:self.bottomBgView];
    self.contentView.clipsToBounds = YES;
    
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
	[self.contentView addGestureRecognizer:tapGesture2];
    self.contentView.tag = 1000;
    
	UIView * bottomLintView = [[UIView alloc] init];
	bottomLintView.backgroundColor = [UIColor colorWithHexString:Main_BackGround_Color];
	[self.contentView addSubview:bottomLintView];
	[bottomLintView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(self.contentView.mas_bottom);
		make.left.equalTo(self.contentView.mas_left);
		make.right.equalTo(self.contentView.mas_right);
		make.height.mas_offset(5);
	}];


}

- (void)setDataSourse:(Goods *)dataSourse {
    _dataSourse = dataSourse;
	
	if (dataSourse.brand == nil || [dataSourse.brand isEqualToString:@""]) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@ %@",dataSourse.fullName,dataSourse.feature];
			
	}else{
        if (dataSourse.feature == nil) {
            dataSourse.feature = @"";
        }
        self.titleLabel.text = [NSString stringWithFormat:@"[%@]%@ %@",dataSourse.brand,dataSourse.fullName,dataSourse.feature];
	}

    for (UIView *view  in self.bottomBgView.subviews) {
        [view removeFromSuperview];
    }
	[self.iconView sd_setImageWithURL:[NSURL URLWithString:dataSourse.image] placeholderImage:[UIImage imageNamed:@"guess_bancai"]];
    CGFloat selectViewHeight = 0;
    
    NSInteger count = 0 ;
    if (self.dataSourse.isOpen) {count = dataSourse.guige.count;}
    else {count = 1;}
	
	if (self.dataSourse.guige.count <= 1) {
		self.selectLabel.hidden = YES;
	}else {
		self.selectLabel.hidden = NO;
	}
	
    for (int i = 0; i < count;  i ++) {
        Guige * guige = dataSourse.guige[i];
        
        SelectSpecificationView * selectSpecificationView = [[SelectSpecificationView alloc] initWithFrame:CGRectMake(8,i *selectViewHeight,self.bottomBgView.width- 8,65)];
		selectSpecificationView.index = i;
        selectSpecificationView.tag = 1000+ i;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
        [selectSpecificationView addGestureRecognizer:tapGesture];
        
        selectViewHeight = selectSpecificationView.height;
		selectSpecificationView.delegate = self;
        [self.bottomBgView addSubview:selectSpecificationView];
		
        selectSpecificationView.totolPriceLabel.text = [NSString stringWithFormat:@"￥%@/%@(%@斤)",guige.currentPrice,dataSourse.baseSpec,guige.totalWeight];
		selectSpecificationView.averagePrice.text = [NSString stringWithFormat:@"{￥%@}/%@",guige.avgPrice,dataSourse.baseSpec];
		
        
        selectSpecificationView.averagePrice.attributedText =
        [NSMutableAttributedString setAttributeString:selectSpecificationView.averagePrice.text
                                                 font:15
                                            textcolor:[UIColor colorWithHexString:Main_Font_Red_Color]
                                          secondcolor:[UIColor colorWithHexString:Main_Font_Gary_Color]
                                           secondfont:12];

        
        
		if ([dataSourse.discount isEqualToString:@"1"]) {
			selectSpecificationView.showDisCountView = YES;
		}else {
			selectSpecificationView.showDisCountView = NO;
		}
        
        selectSpecificationView.carGoodsNum = guige.carGoodNum;

        
        if (i != 0) {
            UIView *imaginaryLine= [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH - 80,.5)];
            [UIView drawDashLine:imaginaryLine lineLength:4 lineSpacing: 2 lineColor:[UIColor colorWithHexString:Main_Line_Gary_Color]];
            [selectSpecificationView addSubview:imaginaryLine];
        }
        
        
        self.bottomBgView.height = selectSpecificationView.bottom;
        self.bgView.height = self.bottomBgView.bottom;
        self.dataSourse.height = self.bgView.height + 10;
    }
}

- (void)changeProcutNumberBagWith:(NSString *)count with:(NSInteger)row withRect:(CGRect)rect{
    
    [self.delegate changeProcutNumberBagWithCount:count withIndexPath:[NSIndexPath indexPathForRow:row inSection:self.indexPath.row]andTypeIndex:self.indexPath.section withRect:rect];
}

#pragma mark -点击进入商品详情
- (void)event:(UITapGestureRecognizer *)gesture
{
    NSInteger  index = gesture.view.tag - 1000;
    
    if ([self.delegate respondsToSelector:@selector(clickGoToProductDetailWith:andGuiGeIndex:)]) {
        [self.delegate clickGoToProductDetailWith:self.indexPath andGuiGeIndex:index];
    }
    
}

#pragma mark - 选择规格
-(void)Actiondo:(id)sender {
    
    
    self.dataSourse.open = !self.dataSourse.open;
    
    if (self.dataSourse.isOpen) {
        self.dataSourse.height = self.topBgView.height + self.dataSourse.guige.count * 66 + 10;
    }
    if ([self.delegate respondsToSelector:@selector(ClickSelectSpecificationWithIndexPath:)]) {
        [self.delegate ClickSelectSpecificationWithIndexPath:_indexPath];
    }
	
}
- (void)clickDeteleButton:(UIButton *)sender {
	UILabel * view = [UILabel creatLabelWithText:@"是否删除清单" FontOfSize:14 textColor:@"333333"];
	NewCustomAlertView * newCustomAlertView = [[NewCustomAlertView alloc] init];
	newCustomAlertView.alertViewWidth  = SCREEN_WIDTH - 24;
	newCustomAlertView.contentView = view;
	newCustomAlertView.contentViewHeight = 50 + 15;
	newCustomAlertView.buttonTitleArray  = @[@"取消",@"确定"];
	newCustomAlertView.buttonColorArray = @[@"333333",Main_Font_Green_Color];
	newCustomAlertView.titleLabelText = @"提示";
	[newCustomAlertView reloadData];
	
	newCustomAlertView.clickBlock = ^(NSInteger index) {
		if (index == 1) {
			if ([self.delegate respondsToSelector:@selector(clickDeteleGoodsWith:)]) {
				[self.delegate clickDeteleGoodsWith:self.indexPath];
			}
		}
	};
	
	

}
@end
