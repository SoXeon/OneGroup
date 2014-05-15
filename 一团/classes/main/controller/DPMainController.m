 //
//  DPMainController.m
//  一团
//
//  Created by 戴鹏 on 14-5-11.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPMainController.h"
#import "DPDock.h"
#import "DPDealListController.h"
#import "DPCollectViewController.h"
#import "DPMapViewController.h"
#import "DPMineViewController.h"
#import "DPNavigationController.h"

@interface DPMainController () <DPDockDelegate>
{
    UIView *_contentView;
}

@end

@implementation DPMainController

- (void)viewDidLoad
{
    [super viewDidLoad]; 
    
    //添加左边的DOCK
    DPDock *dock = [[DPDock alloc]init];
    dock.frame = CGRectMake(0, 0, 0, self.view.frame.size.height);
    dock.delegate = self;
    [self.view addSubview:dock];
    
    //添加内容View
    _contentView = [[UIView alloc]init];
    [self.view  addSubview:_contentView];
    CGFloat w = self.view.frame.size.width - kDockItemW;
    CGFloat h = self.view.frame.size.height;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.frame = CGRectMake(kDockItemW, 0, w, h);
    [self.view addSubview:_contentView];
    
    //添加子控制器
    [self addAllChildControllers];

}

#pragma mark 添加子控制器
- (void)addAllChildControllers
{
    DPDealListController *deal = [[DPDealListController alloc]init];
    DPNavigationController *nav = [[DPNavigationController alloc]initWithRootViewController:deal];
    [self addChildViewController:nav];
    
    DPMapViewController *map = [[DPMapViewController alloc]init];
    nav = [[DPNavigationController alloc]initWithRootViewController:map];
    [self addChildViewController:nav];
    
    DPCollectViewController *collect = [[DPCollectViewController alloc]init];
    nav = [[DPNavigationController alloc]initWithRootViewController:collect];
    [self addChildViewController:nav];
    
    DPMineViewController *mine = [[DPMineViewController alloc]init];
    nav = [[DPNavigationController alloc]initWithRootViewController:mine];
    [self addChildViewController:nav];
    
    //默认选中团购控制器
    [self dock:nil tabChangeFrom:0 to:0];
}


#pragma mark 监听点击tab切换子控制器
- (void)dock:(DPDock *)dock tabChangeFrom:(int)from to:(int)to
{
    //移除旧控制器
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    //添加新控制器
     UIViewController *new = self.childViewControllers[to];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    new.view.frame = _contentView.bounds;
    [_contentView addSubview:new.view];
}

@end
