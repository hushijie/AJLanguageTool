//
//  ViewController.m
//  AJLanguageTool
//
//  Created by JasonHu on 2017/9/6.
//  Copyright © 2017年 AJ. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "AJLanguageChooseViewController.h"
#import "AJLanguageTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(8, 100, ScreenWidth-16, 50)];
    label.layer.cornerRadius=2.0f;
    label.layer.masksToBounds=YES;
    label.layer.borderColor=[UIColor blackColor].CGColor;
    label.layer.borderWidth=0.5f;
    label.textAlignment=NSTextAlignmentCenter;
    label.text=[[AJLanguageTool sharedInstance] getStringForKey:@"ViewController_LabelText" withTable:@"Internationalization"];
    [self.view addSubview:label];
    
    
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake((ScreenWidth-50)/2, ScreenHeight-100-50, 50, 50);
    btn.backgroundColor=[UIColor greenColor];
    btn.layer.cornerRadius=50/2;
    btn.layer.masksToBounds=YES;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 按钮点击事件

-(void)btnClick
{
    AJLanguageChooseViewController * vc=[[AJLanguageChooseViewController alloc]init];
    UINavigationController * naVC=[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:naVC animated:YES completion:nil];
}



@end
