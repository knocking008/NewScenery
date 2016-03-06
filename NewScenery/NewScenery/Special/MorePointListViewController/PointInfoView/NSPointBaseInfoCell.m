//
//  NSPointBaseInfoCell.m
//  NewScenery
//
//  Created by mac on 16/1/21.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSPointBaseInfoCell.h"

@implementation NSPointBaseInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fullCellWith:(NSArray *)array
{
    self.massageLabel.text = [array firstObject];
    self.valueLabel.text = [array lastObject];
    if ([[array firstObject] isEqualToString:@"电话"]|[[array firstObject] isEqualToString:@"官网"])
    {
        self.valueLabel.textColor = [UIColor cyanColor];
    }
}
@end
