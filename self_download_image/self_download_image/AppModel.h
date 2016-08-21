//
//  AppModel.h
//  self_download_image
//
//  Created by ximdefangzh on 16/8/21.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *downlaod;
@property (nonatomic,copy)NSString *icon;
+(instancetype)appWithDict:(NSDictionary *)dict;
@end
