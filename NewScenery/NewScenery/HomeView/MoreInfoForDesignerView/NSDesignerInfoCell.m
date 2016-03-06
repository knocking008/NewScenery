//
//  NSDesignerInfoCell.m
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSDesignerInfoCell.h"

@implementation NSDesignerInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCell:(NSString *)designerSesc
{
    self.DesignerInfoLabel.text = designerSesc;
   }
+ (CGFloat)getCellHeightWith:(NSString *)designerSesc
{
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    bounds=[designerSesc boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height+21;
    
}
@end
