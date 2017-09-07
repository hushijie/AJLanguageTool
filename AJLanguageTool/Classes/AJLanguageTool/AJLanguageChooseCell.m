//
//  AJLanguageChooseCell.m
//  AJLanguageTool
//
//  Created by JasonHu on 2017/9/6.
//  Copyright © 2017年 AJ. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ChoosedBtnWidthHeight 44.0f

#import "AJLanguageChooseCell.h"

@interface AJLanguageChooseCell ()

@property (nonatomic ,weak)UILabel * leftLabel;

@property (nonatomic ,weak)UIButton * choosedBtn;

@end

@implementation AJLanguageChooseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark -

+(id)cellWithTableView:(UITableView *)tableView
{
    NSString * ID=NSStringFromClass([self class]);
    AJLanguageChooseCell * cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[AJLanguageChooseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return  cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor=[UIColor whiteColor];
        //self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        //自定义选中之后的背景颜色
        UIView * selectedBackgroundView=[[UIView alloc]initWithFrame:self.frame];
        selectedBackgroundView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.08];
        self.selectedBackgroundView=selectedBackgroundView;
        
        /*
         创建子控件对象
         */
        
        //leftLabel
        UILabel * leftLabel=[[UILabel alloc]init];
        leftLabel.frame=CGRectMake(15, 0, ScreenWidth-15-8-ChoosedBtnWidthHeight-8, AJLanguageChooseCellHeight);
        leftLabel.font=[UIFont systemFontOfSize:16];
        leftLabel.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.80];
        leftLabel.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:leftLabel];
        _leftLabel=leftLabel;
    
        //选中按钮
        UIButton * choosedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        choosedBtn.frame=CGRectMake(CGRectGetMaxX(self.leftLabel.frame)+8, (AJLanguageChooseCellHeight-ChoosedBtnWidthHeight)/2, ChoosedBtnWidthHeight, ChoosedBtnWidthHeight);
        [choosedBtn setImage:nil forState:UIControlStateNormal];
        [choosedBtn setImage:[UIImage imageNamed:@"choosedBtn"] forState:UIControlStateSelected];
        choosedBtn.userInteractionEnabled=NO;//按钮不可点
        [self.contentView addSubview:choosedBtn];
        _choosedBtn=choosedBtn;
        
        //底部细线
        UIView * bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(15, AJLanguageChooseCellHeight-0.5, ScreenWidth-CGRectGetMinX(self.leftLabel.frame), 0.5)];
        bottomLineView.backgroundColor=[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
        [self.contentView addSubview:bottomLineView];
        
    }
    return self;
}

#pragma mark - setter

-(void)setModel:(AJLanguageCategoryModel *)model
{
    _model=model;
    
    self.leftLabel.text=model.languageName;
    
    if (model.isChoosed) {
        self.choosedBtn.selected=YES;
    }
    else{
        self.choosedBtn.selected=NO;
    }
}


@end
