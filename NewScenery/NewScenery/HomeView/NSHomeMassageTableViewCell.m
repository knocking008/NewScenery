//
//  NSHomeMassageTableViewCell.m
//  NewScenery
//
//  Created by mac on 16/1/13.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSHomeMassageTableViewCell.h"

@implementation NSHomeMassageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWith:(NSMassageModel *)model
{
    self.iconImageView.image = [UIImage imageNamed:model.iconImageName];
    self.actionLabel.text = model.actionTitle;
    self.desclabel.text = model.desc;
    self.dateLabel.text = model.date;
}

@end
