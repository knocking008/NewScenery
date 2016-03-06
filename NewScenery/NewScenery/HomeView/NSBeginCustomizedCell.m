//
//  NSBeginCustomizedCell.m
//  NewScenery
//
//  Created by mac on 16/1/14.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSBeginCustomizedCell.h"
#import "UIImageView+WebCache.h"
@implementation NSBeginCustomizedCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)fullCellWithbPlaceModel:(NSPlaceModel *)model
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    self.placeName.text = model.title;
  
}

@end
