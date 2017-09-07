//
//  AJLanguageCategoryModel.m
//  AJLanguageTool
//
//  Created by JasonHu on 2017/9/7.
//  Copyright © 2017年 AJ. All rights reserved.
//

#import "AJLanguageCategoryModel.h"

@implementation AJLanguageCategoryModel

+(id)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

-(id)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
