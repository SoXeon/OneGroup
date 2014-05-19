//
//  DPImageTool.h
//  一团
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPImageTool : NSObject
+(void)downloadImage:(NSString *)url placeholder:(UIImage *)place imageView:(UIImageView *)imageView;
@end
