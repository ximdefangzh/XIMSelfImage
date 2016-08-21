//
//  AppCell.h
//  self_download_image
//
//  Created by ximdefangzh on 16/8/21.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppModel;
@interface AppCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic,strong)AppModel *model;
@end
