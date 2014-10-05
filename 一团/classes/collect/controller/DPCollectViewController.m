//
//  DPCollectViewController.m
//  一团
//
//  Created by 戴鹏 on 14-5-12.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPCollectViewController.h"
#import "DPCollectTool.h"
#import "DPDealCell.h"


@interface DPCollectViewController ()

@end

@implementation DPCollectViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    
    //加载收藏数据
    [[NSNotificationCenter defaultCenter]addObserver:_collectionView selector:@selector(reloadData) name:kCollectChangeNote object:nil];

}

-(NSArray *)totalDeals
{
    return [DPCollectTool sharedDPCollectTool].collectedDeals;
}

@end
