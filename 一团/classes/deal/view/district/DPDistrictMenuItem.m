//
//  DPDistrictMenuItem.m
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDistrictMenuItem.h"
#import "DPDistrict.h"

@implementation DPDistrictMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDistrict:(DPDistrict *)district
{
    _district = district;
    
    [self setTitle:district.name forState:UIControlStateNormal];
}

- (NSArray *)titles
{
    return _district.neighborhoods;
}
@end
