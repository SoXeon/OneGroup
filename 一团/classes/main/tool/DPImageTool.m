//
//  DPImageTool.m
//  一团
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPImageTool.h"
#import "UIImageView+WebCache.h"

@implementation DPImageTool
+(void)downloadImage:(NSString *)url placeholder:(UIImage *)place imageView:(UIImageView *)imageView
{
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}
@end
