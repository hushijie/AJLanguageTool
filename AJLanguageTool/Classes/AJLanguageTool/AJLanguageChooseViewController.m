//
//  AJLanguageChooseViewController.m
//  AJLanguageTool
//
//  Created by JasonHu on 2017/9/6.
//  Copyright © 2017年 AJ. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "AJLanguageChooseViewController.h"
#import "AJLanguageChooseCell.h"
#import "AJLanguageCategoryModel.h"
#import "AJLanguageTool.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface AJLanguageChooseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,weak)UITableView * tableView;

@property (nonatomic ,strong)NSMutableArray * dataSource;

@end

@implementation AJLanguageChooseViewController

#pragma mark -

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.title=[[AJLanguageTool sharedInstance] getStringForKey:@"AJLanguageChooseViewController_Title" withTable:@"Internationalization"];
        
        /*
         取消按钮
         */
        UIBarButtonItem * leftItem=[[UIBarButtonItem alloc]initWithTitle:[[AJLanguageTool sharedInstance] getStringForKey:@"AJLanguageChooseViewController_CancelBtnTitle" withTable:@"Internationalization"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
        NSMutableDictionary * leftItemAttrs = [NSMutableDictionary dictionary];
        leftItemAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.80];
        leftItemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        [leftItem setTitleTextAttributes:leftItemAttrs forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItem = leftItem;
        
        /*
         完成按钮
         */
        UIBarButtonItem * rightItem=[[UIBarButtonItem alloc]initWithTitle:[[AJLanguageTool sharedInstance] getStringForKey:@"AJLanguageChooseViewController_DoneBtnTitle" withTable:@"Internationalization"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
        // 设置正常文字颜色
        NSMutableDictionary * rightItemAttrs = [NSMutableDictionary dictionary];
        rightItemAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:255.0/255.0 green:104.0/255.0 blue:120.0/255.0 alpha:1];
        rightItemAttrs[NSFontAttributeName] =[UIFont systemFontOfSize:15];
        [rightItem setTitleTextAttributes:rightItemAttrs forState:UIControlStateNormal];
        // 设置不能点击时文字颜色
        NSMutableDictionary * rightItemAttrsDisabled = [NSMutableDictionary dictionary];
        rightItemAttrsDisabled[NSForegroundColorAttributeName] = [UIColor colorWithRed:255.0/255.0 green:104.0/255.0 blue:119.0/255.0 alpha:0.32];
        rightItemAttrsDisabled[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        [rightItem setTitleTextAttributes:rightItemAttrsDisabled forState:UIControlStateDisabled];
        self.navigationItem.rightBarButtonItem=rightItem;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self refreshContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 懒加载

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        
        _dataSource=[NSMutableArray array];
        
        //读取AJLanguageCategories.plist文件中的数据
        NSString * plistPath=[[NSBundle mainBundle] pathForResource:@"AJLanguageCategories" ofType:@"plist"];
        NSArray * plistArray=[NSArray arrayWithContentsOfFile:plistPath];
        //字典转模型
        for (NSDictionary * dict in plistArray) {
            AJLanguageCategoryModel * model=[AJLanguageCategoryModel modelWithDict:dict];
            if ([[[AJLanguageTool sharedInstance] getCurrentLanguage] isEqualToString:model.languageCategory]) {
                model.isChoosed=YES;
            }
            [_dataSource addObject:model];
        }
        
    }
    return _dataSource;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
        
        [tableView setBackgroundColor:[UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1]];
        tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
        
        tableView.delegate=self;
        tableView.dataSource=self;
        
        [self.view addSubview:tableView];
        _tableView=tableView;
    }
    return _tableView;
}


#pragma mark - 按钮点击事件

-(void)leftBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)rightBtnClick
{
    for (AJLanguageCategoryModel * model in self.dataSource) {
        if (model.isChoosed) {
            [[AJLanguageTool sharedInstance] setNewLanguage:model.languageCategory success:^{
                
                [self dismissViewControllerAnimated:YES completion:^{
                    AppDelegate * appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
                    appDelegate.window.rootViewController=[[ViewController alloc]init];
                }];
                
            } failure:nil];
            break;
        }
    }
}


#pragma mark - tableView的代理方法


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AJLanguageChooseCell * cell=[AJLanguageChooseCell cellWithTableView:tableView];
    cell.model=self.dataSource[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AJLanguageChooseCellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //使点击之后点击效果(灰色背景)消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (int i=0; i<self.dataSource.count; i++) {
        AJLanguageCategoryModel * model=self.dataSource[i];
        if (i==indexPath.row) {
            model.isChoosed=YES;
        }
        else{
            model.isChoosed=NO;
        }
    }
    
    [self refreshContentView];
}


#pragma mark - 刷新view

-(void)refreshContentView
{
    [self.tableView reloadData];
    
    for (AJLanguageCategoryModel * model in self.dataSource) {
        if (model.isChoosed) {
            //判断“完成”按钮是否可点
            if ([model.languageCategory isEqualToString:[[AJLanguageTool sharedInstance] getCurrentLanguage]]) {
                self.navigationItem.rightBarButtonItem.enabled=NO;
            }
            else{
                self.navigationItem.rightBarButtonItem.enabled=YES;
            }
            break;
        }
    }
}



@end
