//
//  NSWorkCell.m
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSWorkCell.h"
#import "UIImageView+WebCache.h"
@implementation NSWorkCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWithDesignerWorksModel:(NSDesignerWorksModel *)model
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.route_icon] placeholderImage:[UIImage imageNamed:@"noOrder"]];
    self.titleLabel.text = model.route_title;
    self.skilledLabel.text = model.placeList;
}

@end
