//
//  NSRouteCell.m
//  NewScenery
//
//  Created by mac on 16/1/12.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSRouteCell.h"
#import "UIImageView+WebCache.h"
@implementation NSRouteCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWithNSMoreRouteListModel:(NSMoreRouteListModel *)model
{
    [self.sceneryImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    self.titleLabel.text = model.title;
    self.desc.text = model.desc;
    self.cityLabel.text = model.city;
    [self.designerHerderImageView sd_setImageWithURL:[NSURL URLWithString:model.user_icon] placeholderImage:nil];
    self.designerHerderImageView.layer.masksToBounds = YES;
    self.designerHerderImageView.layer.cornerRadius = 25;
}

@end
