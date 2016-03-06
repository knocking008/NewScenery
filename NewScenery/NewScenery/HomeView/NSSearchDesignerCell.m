//
//  NSSearchDesignerCell.m
//  NewScenery
//
//  Created by mac on 16/1/22.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSSearchDesignerCell.h"
#import "UIImageView+WebCache.h"
@implementation NSSearchDesignerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fullCellWithNSSearchDesignerModel:(NSSearchDesignerModel *)model
{
    [self.iconIMageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"noOrder"]];
    self.iconIMageView.layer.cornerRadius = 8;
    self.iconIMageView.layer.masksToBounds = YES;
    self.nameLabel.text = model.name;
    self.descLabel.text = model.sign;
}
@end
