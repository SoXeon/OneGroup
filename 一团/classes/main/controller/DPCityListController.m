//
//  DPCityListController.m
//  一团
//
//  Created by 戴鹏 on 14-5-12.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPCityListController.h"
#import "CitySection.h"
#import "NSObject+Value.h"
#import "DPCity.h"

#define kSearchH 44

@interface DPCityListController () <UITableViewDataSource,UISearchBarDelegate>
{
    NSArray *_citiesData;//所有城市信息
    UIView *_cover;//遮盖黑色蒙板
    UITableView *_tableView;
    UISearchBar *_searchBar;
}

@end

@implementation DPCityListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加搜索框
    [self addSearchBar];
    
    //添加tableView
    [self addTableView];
    
    //加载数据
    [self loadCitiesData];
}

#pragma mark 添加搜索框
- (void)addSearchBar
{
    UISearchBar *search = [[UISearchBar alloc] init];
    search.delegate = self;
    search.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    search.frame = CGRectMake(0, 0, self.view.frame.size.width , kSearchH);
    search.placeholder = @"请输入城市名称或拼音";
    [self.view addSubview:search];
    _searchBar = search;
}

#pragma mark 添加tableView
- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    CGFloat h = self.view.frame.size.height - kSearchH;
    tableView.frame = CGRectMake(0, kSearchH, self.view.frame.size.width, h);
    tableView.dataSource = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark 加载城市信息
- (void)loadCitiesData
{
    _citiesData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Cities.plist" ofType:nil]];
    
    NSDictionary *dict = _citiesData[0];
    //name cities
    CitySection *section = [[CitySection alloc]init];
    
    [section setValues:dict];
    
}


#pragma mark 搜索框的代理方法
#pragma mark 监听搜索框内文字的改变
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

#pragma mark 搜索框开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //现实取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    //显示遮盖
    if (_cover == nil) {
        _cover = [[UIView alloc] init];
        _cover.backgroundColor = [UIColor blackColor];
        _cover.alpha = 0.7;
        _cover.frame = _tableView.frame;
        _cover.autoresizingMask = _tableView.autoresizingMask;
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverClick)]];
    }
    [self.view addSubview:_cover];
    _cover.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.7;
    }];
}

#pragma mark 监听点击搜索框取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self coverClick];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self coverClick];
}

#pragma mark 监听点击遮盖
- (void)coverClick
{
    //移除遮盖
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
    }];
    //隐藏取消按钮
    [_searchBar setShowsCancelButton:NO animated:YES];
        
    //推出键盘
    [_searchBar resignFirstResponder];
}

#pragma mark 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _citiesData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionData = _citiesData[section];
    NSArray *citites = sectionData[@"cities"];
    return citites.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *sectionData = _citiesData[indexPath.section];
    NSArray *cities = sectionData[@"cities"];
    cell.textLabel.text = cities[indexPath.row][@"name"];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionData = _citiesData[section];
    return sectionData[@"name"];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //取出_citiesData中都所有字典name的值，并放到数组中返回
    return [_citiesData valueForKeyPath:@"name"];
}
@end
