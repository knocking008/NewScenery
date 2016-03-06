//
//  NSNetDatasErrorCell.m
//  NewScenery
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSNetDatasErrorCell.h"

@implementation NSNetDatasErrorCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWith:(NSString *)imageName
{
    self.errorImageView.image = [UIImage imageNamed:imageName];
}

@end
