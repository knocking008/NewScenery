//
//  NSActionCollectionViewCell.m
//  NewScenery
//
//  Created by mac on 16/1/13.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSActionCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation NSActionCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)fullCellWithActionModel:(NSActionModel *)model
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"noOrder"]];
    self.descLabel.text = model.desc;
    self.titlLabel.text = model.title;
    self.dateLabel.text = @"02月14日00:00";
}

@end
