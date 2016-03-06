//
//  NSCanCell.m
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSCanCell.h"

@implementation NSCanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWith:(NSString *)canStr
{
    NSArray *tmpArr = @[@"can_phone_service",@"can_doortodoor",@"can_route_service"];
    if ([canStr isEqualToString:tmpArr[0]]) {
        self.titleLabel.text = @"电话咨询";
        self.iconImageView.image = [UIImage imageNamed:@"designer_phone"];
    }else if([canStr isEqualToString:tmpArr[1]]){
        self.titleLabel.text = @"见面咨询";
        self.iconImageView.image = [UIImage imageNamed:@"designerserver"];
    }else if ([canStr isEqualToString:tmpArr[2]]){
        self.titleLabel.text = @"邀请定制";
        self.iconImageView.image = [UIImage imageNamed:@"designer_route"];
    }
}

@end
