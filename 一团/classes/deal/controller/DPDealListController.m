//
//  DPDealListController.m
//  一团
//
//  Created by 戴鹏 on 14-5-12.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealListController.h"
#import "DPDealTopMenu.h"

@interface DPDealListController ()

@end

@implementation DPDealListController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //监听城市改变的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
    
    //设置背景颜色
    self.view.backgroundColor = kGlobalBg;
    
    //右边搜索框
    UISearchBar *s = [[UISearchBar alloc]init];
    s.frame = CGRectMake(0, 0, 210, 35);
    s.placeholder = @"请输入商品名、地址等";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:s];
    
    //左边的菜单栏
    DPDealTopMenu *top = [[DPDealTopMenu alloc] init];
    top.contentView = self.view;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:top];
}

-(void)cityChange
{
    MyLog(@"城市发生改变");
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
