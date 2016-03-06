//
//  NSTargetCell.m
//  NewScenery
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSTargetCell.h"
#import "UIImageView+WebCache.h"
@implementation NSTargetCell

- (void)awakeFromNib {
    // Initialization code
    self.iconImageView.layer.cornerRadius = 8;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fullCellWithNSPlaceModel:(NSPlaceModel *)model
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    self.nameLabel.text = model.title;
}

@end
