//
//  NSRouteTableHeaderView.m
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSRouteTableHeaderView.h"
#import "UIImageView+WebCache.h"
@implementation NSRouteTableHeaderView
{
    BOOL isShow;
}

- (void)fullViewWithNSRouteBaseInfoModel:(NSRouteBaseInfoModel *)model
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.route_icon] placeholderImage:nil];
    [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:model.user_icon] placeholderImage:nil];
    self.userIconImageView.layer.masksToBounds = YES;
    self.userIconImageView.layer.cornerRadius = 25;
    self.nameLabel.text = model.user_name;
    self.userSignLabel.text = model.user_sign;
    self.route_titleLabel.text = model.route_title;
    self.start_datelabel.text = model.start_date;
    
    self.descLabel.text = model.route_desc;
    self.showLabel.text = @"﹀";
    UITapGestureRecognizer *showTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTapAction)];
    self.showLabel.userInteractionEnabled = YES;
    [self.showLabel addGestureRecognizer:showTap];
   }
- (void)showTapAction{
    isShow = !isShow;
    if (isShow) {
        self.showLabel.text = @"^";
    }else{
         self.showLabel.text = @"﹀";
    }
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"changeHeaderViewHeight" object:@(isShow)];
}



@end
