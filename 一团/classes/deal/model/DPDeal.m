//
//  Deal.m
//  团购
//
//  Created by mj on 13-11-2.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "DPDeal.h"
#import "DPRestrictions.h"
#import "NSString+DP.h"
#import "NSObject+Value.h"

@implementation DPDeal

- (void)setList_price:(double)list_price
{
    _list_price = list_price;
    
    _list_price_text = [NSString stringWithDouble:list_price fractionCount:2];
}

-(void)setCurrent_price:(double)current_price
{
    _current_price = current_price;
    
    _current_price_text = [NSString stringWithDouble:current_price fractionCount:2];

}

-(void)setRestrictions:(DPRestrictions *)restrictions
{
    if ([restrictions isKindOfClass:[NSDictionary class]]) {
        _restrictions = [[DPRestrictions alloc] init];
        [_restrictions setValues:(NSDictionary *)restrictions];
    } else {
        _restrictions = restrictions;
    }
}

@end
