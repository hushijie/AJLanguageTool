//
//  AJLanguageTool.m
//  AJLanguageTool
//
//  Created by JasonHu on 2017/9/6.
//  Copyright © 2017年 AJ. All rights reserved.
//
#define CNS @"zh-Hans"
#define EN @"en"
#define LANGUAGE_SET @"languageset"
#define DefaultLanguage @"zh-Hans"

#import "AJLanguageTool.h"

static AJLanguageTool *sharedModel;

@interface AJLanguageTool()

@property(nonatomic,strong)NSBundle *bundle;
@property(nonatomic,copy)NSString *language;

@end

@implementation AJLanguageTool

#pragma mark - 初始化创建

+(id)sharedInstance
{
    if (!sharedModel)
    {
        sharedModel = [[AJLanguageTool alloc]init];
    }
    return sharedModel;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initLanguage];
    }
    return self;
}

-(void)initLanguage
{
    self.language = [self getCurrentLanguage];
    NSString * path = [[NSBundle mainBundle]pathForResource:self.language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}


#pragma mark - 设置语言&获取当前语言

//设置新语言
-(void)setNewLanguage:(NSString*)language success:(void (^)())success failure:(void (^)())failure
{
    if ([language isEqualToString:self.language])
    {
        if (failure) {
            failure();
        }
    }
    else{
        NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
        self.bundle = [NSBundle bundleWithPath:path];
        self.language = language;
        [[NSUserDefaults standardUserDefaults]setObject:language forKey:LANGUAGE_SET];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if (success) {
            success();
        }
    }
}

//返回当前选中的语言
-(NSString *)getCurrentLanguage
{
    if ([[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE_SET]) {
        return [[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE_SET];
    }
    else{
        return DefaultLanguage;//设置默认语言类型
    }
}


#pragma mark - 获取不同语言的文字

-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table
{
    if (self.bundle)
    {
        return NSLocalizedStringFromTableInBundle(key, table, self.bundle, @"");
    }
    return NSLocalizedStringFromTable(key, table, @"");
}


@end

