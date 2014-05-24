//
//  DPMineViewController.m
//  一团
//
//  Created by 戴鹏 on 14-5-12.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPMineViewController.h"
#import "DPDealTool.h"

@interface DPMineViewController ()

@end

@implementation DPMineViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"我的";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStyleBordered target:self action:@selector(logout)];
}

-(void)logout
{
    [[DPDealTool sharedDPDealTool] dealsWithPage:1 success:^(NSArray *deals, int totalCount) {
        [self showDetail:deals[0]];
    } error:nil];
}

@end
