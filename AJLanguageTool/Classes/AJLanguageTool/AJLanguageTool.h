//
//  AJLanguageTool.h
//  AJLanguageTool
//
//  Created by JasonHu on 2017/9/6.
//  Copyright © 2017年 AJ. All rights reserved.
//

/*
 国际化工具（切换语言工具类）
 */

#define FGGetStringWithKeyFromTable(key, tbl) [[FGLanguageTool sharedInstance] getStringForKey:key withTable:tbl]

#import <Foundation/Foundation.h>

@interface AJLanguageTool : NSObject

+(id)sharedInstance;

/**
 *  返回table中指定的key的值
 *
 *  @param key   key
 *  @param table table
 *
 *  @return 返回table中指定的key的值
 */
-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table;

/**
 设置新的语言

 @param language 新语言
 @param success 成功回调
 @param failure 失败回调
 */
-(void)setNewLanguage:(NSString*)language success:(void (^)())success failure:(void (^)())failure;

/**
 返回当前选中的语言

 @return 当前选中的语言类型
 */
-(NSString *)getCurrentLanguage;

@end
