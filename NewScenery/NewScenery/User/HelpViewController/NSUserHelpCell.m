//
//  NSUserHelpCell.m
//  NewScenery
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSUserHelpCell.h"

@implementation NSUserHelpCell

- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.tapView addGestureRecognizer:tap];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWith:(NSString *)title text:(NSString *)text textHidden:(int)textHidden
{
    self.textTitleLabel.text = title;
    self.TextLabel.text = text;
    if (textHidden == 1) {
        self.TextLabel.hidden = YES;
        self.flagLabel.text = @"﹀";
    }else{
        self.TextLabel.hidden = NO;
        self.flagLabel.text = @"︿";
    }
}

- (void)tapAction{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"tapAction" object:self.textTitleLabel.text];
}

@end
