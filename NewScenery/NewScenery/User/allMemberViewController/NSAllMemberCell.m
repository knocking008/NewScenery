//
//  NSAllMemberCell.m
//  NewScenery
//
//  Created by mac on 16/2/17.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSAllMemberCell.h"
#import "UIImageView+WebCache.h"
@implementation NSAllMemberCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWithNSAllMemberModel:(NSAllMemberModel *)model
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"noOrder"]];
    self.titlelabel.text = model.title;
    self.discLabel.text = model.desc;
}

@end
