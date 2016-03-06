//
//  NSTableHeaderView.m
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSTableHeaderView.h"
#import "UIImageView+WebCache.h"
@implementation NSTableHeaderView

- (void)fullCellWithDesignerBaseInfoModel:(NSDesignerBaseInfoModel *)model
{
    [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];
    self.nameLabel.text = model.name;
    self.starLabel.text = [self converterGradeWith:model.grade];
    self.lvLabel.text = model.grade_text;
    self.cityLabel.text = model.city;
    [self.satisfiBtn setTitle:[NSString stringWithFormat:@"满意度%d",model.score_total] forState:UIControlStateNormal];
    [self.sappraiseBtn setTitle:[NSString stringWithFormat:@"评论%d",model.appraise_total] forState:UIControlStateNormal];
}

- (NSString *)converterGradeWith:(NSString *)grade{
    NSMutableString *tmpStr = [NSMutableString new];
    for (int i = 0; i < [grade intValue]; i++) {
        [tmpStr appendString:@"★ "];
    }
    return tmpStr;
}

@end
