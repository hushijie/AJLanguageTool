//
//  AJLanguageCategoryModel.h
//  AJLanguageTool
//
//  Created by JasonHu on 2017/9/7.
//  Copyright © 2017年 AJ. All rights reserved.
//

/*
 语言类型model
 */

#import <Foundation/Foundation.h>

@interface AJLanguageCategoryModel : NSObject

/**
 语言类型-例如“zh-Hans”
 */
@property (nonatomic ,copy)NSString * languageCategory;

/**
 语言名字-例如“简体中文”
 */
@property (nonatomic ,copy)NSString * languageName;

/**
 是否选中该类型语言：YES-选中、NO-未选中，默认NO
 */
@property (nonatomic ,assign)BOOL isChoosed;

#pragma mark - 

+(id)modelWithDict:(NSDictionary *)dict;

@end
