//
//  DPBaseDealListController.m
//  一团
//
//  Created by DP on 14-5-24.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPBaseDealListController.h"
#import "DPDeal.h"
#import "DPDealCell.h"
#import "UIBarButtonItem+DP.h"
#import "DPDealDetailController.h"
#import "DPNavigationController.h"
#import "DPCover.h"

#define kItemW 250
#define kItemH 250
#define kDetailWitdh 600

@interface DPBaseDealListController ()
{
    DPCover *_cover;
}

@end

@implementation DPBaseDealListController

- (id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kItemW, kItemH);
    layout.minimumLineSpacing = 20;
    return [self initWithCollectionViewLayout:layout];
}

-(void)viewDidLoad
{
    //注册cell的xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"DPDealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];

    self.collectionView.backgroundColor = kGlobalBg;
    
    //设置collectionView永远支持垂直滚动
    self.collectionView.alwaysBounceVertical = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    //默认计算layout
    [self didRotateFromInterfaceOrientation:0];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 屏幕旋转的时候调用
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //取出layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    //计算间距
    CGFloat v = 20;
    CGFloat h = 0;
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        h = (self.view.frame.size.width - 3 * kItemW) / 4;
    } else {
        h = (self.view.frame.size.width - 2 * kItemW) / 3;
    }
    [UIView animateWithDuration:1.0 animations:^{
        layout.sectionInset = UIEdgeInsetsMake(v, h, v, h);
    }];
}

#pragma mark 代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetail:self.totalDeals[indexPath.row]];
}

#pragma mark 显示详情控制器
-(void)showDetail:(DPDeal *)deal
{
    if (_cover == nil) {
        _cover = [DPCover coverWithTarget:self action:@selector(hideDetail)];}
    _cover.frame = self.navigationController.view.bounds;
    _cover.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        [_cover reset];
    }];
    [self.navigationController.view addSubview:_cover];
    
    //展示团购详情
    DPDealDetailController *detail = [[DPDealDetailController alloc]init];
    detail.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_nac_close.png" highlightedIcon:@"btn_nav_close_hl.png" target:self action:@selector(hideDetail)];
    detail.deal = deal;
    DPNavigationController *nav = [[DPNavigationController alloc]initWithRootViewController:detail];
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    nav.view.frame = CGRectMake(_cover.frame.size.width, 0, 600, _cover.frame.size.height);
    //两个控制器为互为父子关系，view也是一样的
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = nav.view.frame;
        f.origin.x -= kDetailWitdh;
        nav.view.frame = f;
    }];
}

-(void)hideDetail
{
    //隐藏遮盖
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0;
        CGRect f = nav.view.frame;
        f.origin.x += kDetailWitdh;
        nav.view.frame = f;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalDeals.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"deal";
    
    DPDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.deal = self.totalDeals[indexPath.row];
    
    return cell;
}

@end
