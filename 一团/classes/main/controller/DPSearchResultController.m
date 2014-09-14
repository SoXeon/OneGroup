//
//  DPSearchResultController.m
//  一团
//
//  Created by DP on 14-5-14.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPSearchResultController.h"
#import "DPMetaDataTool.h"
#import "DPCity.h"

#import "PinYin4Objc.h"

@interface DPSearchResultController ()
{
    NSMutableArray *_resultCities;//加载所有搜索到的城市
}
@end

@implementation DPSearchResultController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _resultCities = [NSMutableArray array];
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    //清除之间的搜索结果
    [_resultCities removeAllObjects];
    
    //筛选城市
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc]init];
    fmt.caseType = CaseTypeUppercase;
    fmt.toneType = ToneTypeWithoutTone;
    fmt.vCharType = VCharTypeWithUUnicode;
    
    NSDictionary *cities = [DPMetaDataTool sharedDPMetaDataTool].totalCities;
    //遍历所有字典
    [cities enumerateKeysAndObjectsUsingBlock:^(NSString *key, DPCity *obj, BOOL *stop) {
        
        //拼音
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
        
        //拼音首字母 以#作为分隔符
        NSArray *words = [pinyin componentsSeparatedByString:@"#"];
        NSMutableString *pinyinHeader = [NSMutableString string];
        for (NSString *word in words) {
            //把城市拼音首字母拼接为一个字符串
            [pinyinHeader appendString:[word substringFromIndex:1]];
        }
        
        //去除#号后，重新复制  
        pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        //搜索条件
        if (([obj.name rangeOfString:searchText].length != 0) ||
            ([pinyin rangeOfString:searchText.uppercaseString].length != 0) ||
            ([pinyinHeader rangeOfString:searchText.uppercaseString].length != 0))
        {
            //说明城市名中包含了搜索条件
            [_resultCities addObject:obj];
        }
    }];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultCities.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共%d个搜索结果",_resultCities.count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    DPCity *city = _resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

#pragma mark table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPCity *city = _resultCities[indexPath.row];
    
    [DPMetaDataTool sharedDPMetaDataTool].currentCity = city;
    
}

@end
