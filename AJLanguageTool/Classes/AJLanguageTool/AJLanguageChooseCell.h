//
//  AJLanguageChooseCell.h
//  AJLanguageTool
//
//  Created by JasonHu on 2017/9/6.
//  Copyright © 2017年 AJ. All rights reserved.
//

/*
 多语言选择VC - 自定义cell
 */

#define AJLanguageChooseCellHeight 44.0f

#import <UIKit/UIKit.h>
#import "AJLanguageCategoryModel.h"

@interface AJLanguageChooseCell : UITableViewCell

@property (nonatomic ,retain)AJLanguageCategoryModel * model;

#pragma mark -

+(id)cellWithTableView:(UITableView *)tableView;

@end
