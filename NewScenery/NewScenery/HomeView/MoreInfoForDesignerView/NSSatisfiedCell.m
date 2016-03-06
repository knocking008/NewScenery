//
//  NSSatisfiedCell.m
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSSatisfiedCell.h"

@implementation NSSatisfiedCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWithSatisfied:(NSArray *)satisfied
{
    self.routeProView.progress = (float)([satisfied[0] intValue] +0.001)/ 100;
    self.routeLabel.text = satisfied[0];
    self.serviceProView.progress = (float)([satisfied[1] intValue]+0.001 )/ 100;
    self.serviceLabel.text = satisfied[1];
    self.efficiencyProView.progress = (float)([satisfied[2] intValue] +0.001)/ 100;
    self.efficiencyLabel.text = satisfied[2];
}

@end
