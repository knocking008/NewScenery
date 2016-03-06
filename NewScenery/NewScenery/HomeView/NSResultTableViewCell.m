//
//  NSResultTableViewCell.m
//  NewScenery
//
//  Created by mac on 16/1/13.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSResultTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation NSResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWithNSSearchRouteModel:(NSSearchRouteModel *)model
{
    [self.iconIMageView sd_setImageWithURL:[NSURL URLWithString:model.route_icon] placeholderImage:[UIImage imageNamed:@"noOrder"]];
    self.iconIMageView.layer.cornerRadius = 8;
    self.iconIMageView.layer.masksToBounds = YES;
    self.descLabel.text = model.route_title;
    self.pointLabel.text = model.place_li;
    
}

- (void)fullCellWithNSSearchPointModel:(NSSearchPointModel *)model
{
    [self.iconIMageView sd_setImageWithURL:[NSURL URLWithString:model.point_icon] placeholderImage:[UIImage imageNamed:@"noOrder"]];
    self.iconIMageView.layer.cornerRadius = 8;
    self.iconIMageView.layer.masksToBounds = YES;
    self.descLabel.text = model.point_name_cn;
    self.pointLabel.text = model.area_text;
}
@end
