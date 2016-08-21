//
//  NSString+SandPath.m
//  self_download_image
//
//  Created by ximdefangzh on 16/8/21.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import "NSString+SandPath.h"

@implementation NSString (SandPath)
+(instancetype)cachePathByString:(NSString *)str{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [cachePath stringByAppendingPathComponent:[str lastPathComponent]];
    return path;
}
@end
