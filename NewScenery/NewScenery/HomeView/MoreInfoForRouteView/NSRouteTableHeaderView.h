//
//  NSRouteTableHeaderView.h
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSRouteTableHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userSignLabel;

@property (weak, nonatomic) IBOutlet UILabel *route_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *start_datelabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

- (void)fullViewWithNSRouteBaseInfoModel:(NSRouteBaseInfoModel*)model;
@end
