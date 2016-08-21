//
//  AppCell.m
//  self_download_image
//
//  Created by ximdefangzh on 16/8/21.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import "AppCell.h"
#import "AppModel.h"
@interface AppCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;

@end
@implementation AppCell

-(void)setModel:(AppModel *)model{
    _model = model;
    self.nameLabel.text = model.name;
    self.downloadLabel.text = model.download;
}
@end
