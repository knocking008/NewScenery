//
//  NSCalendarPointCell.m
//  NewScenery
//
//  Created by mac on 16/1/23.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSCalendarPointCell.h"
#import "UIImageView+WebCache.h"
@implementation NSCalendarPointCell
{
    NSString *phoneStr;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fullCellWithNSDaliysPointModel:(NSDaliysPointModel *)model
{
    self.timeLabel.text = model.daliy_time;
    self.titlLabel.text = [NSString stringWithFormat:@"%@ %@",model.title,model.title_en];
    self.addressLabel.text = model.address;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"noOrder"]];
    self.daliy_noteLabel.text = model.daliy_note;
    phoneStr = model.phone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.phoneView addGestureRecognizer:tap];
}
- (void)tapAction{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"phoneStr" object:phoneStr];
}
@end
