//
//  AppCell.m
//  self_download_image
//
//  Created by ximdefangzh on 16/8/21.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import "AppCell.h"
@interface AppCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;

@end
@implementation AppCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
