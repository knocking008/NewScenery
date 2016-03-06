//
//  NSRouteDayCell.m
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSRouteDayCell.h"
#import "UIImageView+WebCache.h"
@implementation NSRouteDayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fullCellWithNSRouteDaysModel:(NSRouteDaysModel *)model
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 5;
    self.dateLabel.text = model.daliy_time;
    self.locationLabel.text = [NSString stringWithFormat:@"%@(%@)",model.title,model.title_en];
    if (model.daliy_note.length!=0) {
        self.noteLabel.text = model.daliy_note;
        self.noteLabel.hidden = NO;
        self.noteBegImageView.hidden = NO;
    }else{
        self.noteLabel.hidden = YES;
        self.noteBegImageView.hidden = YES;
    }
}
@end
