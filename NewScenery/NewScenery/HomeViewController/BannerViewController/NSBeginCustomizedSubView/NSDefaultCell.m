//
//  NSDefaultCell.m
//  NewScenery
//
//  Created by mac on 16/2/15.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSDefaultCell.h"

@implementation NSDefaultCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fullDefaultCellWithTitle:(NSString *)title
{
    self.label.text = title;
}
@end
