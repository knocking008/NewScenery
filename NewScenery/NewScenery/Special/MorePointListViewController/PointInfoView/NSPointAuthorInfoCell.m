//
//  NSPointAuthorInfoCell.m
//  NewScenery
//
//  Created by mac on 16/1/21.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSPointAuthorInfoCell.h"
#import "UIImageView+WebCache.h"
@implementation NSPointAuthorInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWithNSPointAuthorInfoModel:(NSPointAuthorInfoModel *)model
{
    [self.userIcomImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];
    self.userIcomImageView.layer.cornerRadius = 35;
    self.userIcomImageView.layer.masksToBounds = YES;
    self.nameLabel.text = model.name;
    self.creatTimeLabel.text = [NSString stringWithFormat:@"%@创建了本条旅游资源",[self changeTimeWithTimeStr:model.time]];
}
//将时间戳转化为时间
- (NSString *)changeTimeWithTimeStr:(NSString *)str
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str integerValue]];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy.MM.dd";
    return [formater stringFromDate:confromTimesp];
}
@end
