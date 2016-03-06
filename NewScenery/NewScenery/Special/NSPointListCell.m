//
//  NSPointListCell.m
//  NewScenery
//
//  Created by mac on 16/1/21.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSPointListCell.h"
#import "UIImageView+WebCache.h"
@implementation NSPointListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fullCellWithNSPointListModel:(NSPointListModel *)model
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    self.titleLabel.text = model.title;
    self.type.text = model.type_text;
    self.discLabel.text = model.desc;
    self.areaLabel.text = model.area_text;
}
@end
