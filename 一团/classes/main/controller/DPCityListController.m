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
#import "DPMetaDataTool.h"
#import "DPSearchResultController.h"

#define kSearchH 44

@interface DPCityListController () <UITableViewDataSource,UISearchBarDelegate,UITableViewDelegate>
{
    NSMutableArray *_citiesSections;//所有城市信息
    UIView *_cover;//遮盖黑色蒙板
    UITableView *_tableView;
    
    DPSearchResultController *_searchResult;
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
    
    //默认宽度是768或更高，设置自动伸缩才能显示正常
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
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark 加载城市信息
- (void)loadCitiesData
{
    
    _citiesSections = [NSMutableArray array];

    NSArray *sections = [DPMetaDataTool sharedDPMetaDataTool].totalCitySections;
    
    [_citiesSections addObjectsFromArray:sections];

}


#pragma mark 搜索框的代理方法
#pragma mark 监听搜索框内文字的改变，实时刷新搜索
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        //隐藏搜索界面
        [_searchResult.view removeFromSuperview];
    } else {
        if (_searchResult == nil) {
            _searchResult = [[DPSearchResultController alloc]init];
            _searchResult.view.frame = _cover.frame;
            _searchResult.view.backgroundColor = [UIColor whiteColor];
            _searchResult.view.autoresizingMask = _cover.autoresizingMask;
            [self addChildViewController:_searchResult];
            }
        _searchResult.searchText = searchText;
        [self.view addSubview:_searchResult.view];
    }
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
        _cover.autoresizingMask = _tableView.autoresizingMask;
        
        //监听手势，点击蒙板，蒙板消失
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverClick)]];
    }
    _cover.frame = _tableView.frame;
    [self.view addSubview:_cover];
    _cover.alpha = 0.0;
    
    //蒙板饱和度动画变化过程
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.7;
    }];
}

#pragma mark 监听点击搜索框取消按钮
#pragma mark 另外两种显示取消的状态
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
    return _citiesSections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CitySection *s = _citiesSections[section];
    return s.cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    CitySection *s = _citiesSections[indexPath.section];
    DPCity *city = s.cities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CitySection *s = _citiesSections[section];
    return s.name;
}

//返回索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //取出_citiesSections中所有元素name的值,并且装入数组中返回
    return [_citiesSections valueForKeyPath:@"name"];
}

#pragma mark - tableView的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitySection *s = _citiesSections[indexPath.section];
    DPCity *city = s.cities[indexPath.row];
    
    [DPMetaDataTool sharedDPMetaDataTool].currentCity = city;
    
}
@end
