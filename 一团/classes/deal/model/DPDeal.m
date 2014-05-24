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
#import "DPBusiness.h"

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

-(BOOL)isEqual:(DPDeal *)other
{
    return [other.deal_id isEqualToString:_deal_id];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:@"_title"];
    [aCoder encodeDouble:_list_price forKey:@"_list_price"];
    
    [aCoder encodeObject:_purchase_deadline forKey:@"_purchase_deadline"];
    [aCoder encodeObject:_deal_id forKey:@"_deal_id"];
    [aCoder encodeObject:_image_url forKey:@"_image_url"];
    [aCoder encodeObject:_desc forKey:@"_desc"];
    [aCoder encodeDouble:_current_price forKey:@"_current_price"];
    [aCoder encodeInt:_purchase_count forKey:@"_purchase_count"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"_title"];
        self.list_price = [aDecoder decodeDoubleForKey:@"_list_price"];
        self.purchase_deadline = [aDecoder decodeObjectForKey:@"_purchase_deadline"];
        self.deal_id = [aDecoder decodeObjectForKey:@"_deal_id"];
        self.image_url = [aDecoder decodeObjectForKey:@"_image_url"];
        self.desc = [aDecoder decodeObjectForKey:@"_desc"];
        self.current_price = [aDecoder decodeDoubleForKey:@"_current_price"];
        self.purchase_count = [aDecoder decodeIntForKey:@"_purchase_count"];

    }
    return self;
}

-(void)setBusinesses:(NSArray *)businesses
{
    NSDictionary *obj = [businesses lastObject];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in businesses) {
            DPBusiness *b = [[DPBusiness alloc]init];
            [b setValues:dict];
            [temp addObject:b];
        }
        _businesses = temp;
    } else {
        _businesses = businesses;
    }
}

@end
