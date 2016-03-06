//
//  NSappraiseCell.m
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSappraiseCell.h"

@implementation NSappraiseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fullCellWithAppraise_listForDesignerModel:(NSAppraise_listForDesignerModel *)model
{
    self.nick_nameLabel.text = model.nick_name;
    self.create_timeLabel.text = model.create_time;
    self.contentLabel.text = model.content;
    CGRect rect = [self.contentLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.contentLabel.font} context:nil];
    CGRect frame = self.contentLabel.frame;
    CGRect cellFrame = self.frame;
    cellFrame.size.height +=(rect.size.height - frame.size.height);

    frame.size.height = rect.size.height;
    self.contentLabel.frame = frame;
}

+ (CGFloat)getCellHeightWith:(NSString *)designerSesc
{
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    bounds=[designerSesc boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height+50;
}

@end
