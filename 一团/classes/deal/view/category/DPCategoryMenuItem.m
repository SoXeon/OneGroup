//
//  DPCategoryMenuItem.m
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPCategoryMenuItem.h"
#import "DPCategory.h"

#define kTitleRatio 0.5


@implementation DPCategoryMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //文字
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //图片
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

-(NSArray *)titles
{
    return _category.subcategories;
}

- (void)setCategory:(DPCategory *)category
{
    _category = category;
    
    //图标
    [self setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];
    
    //标题
    [self setTitle:category.name forState:UIControlStateNormal];
    
}


#pragma mark 设置按钮标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight;
    return CGRectMake(0, titleY, contentRect.size.width, titleHeight);
}

#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return  CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * (1 - kTitleRatio));
}
@end
