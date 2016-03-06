//
//  NSSpecialCell.m
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSSpecialCell.h"
#import "UIImageView+WebCache.h"
@implementation NSSpecialCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWithNSGetspecialModel:(NSGetspecialModel *)model
{

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
}

@end
