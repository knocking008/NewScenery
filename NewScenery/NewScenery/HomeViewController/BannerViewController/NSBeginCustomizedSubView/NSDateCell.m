//
//  NSDateCell.m
//  NewScenery
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSDateCell.h"


@implementation NSDateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fullDateCellIntervalTime:(NSArray *)intervalTime
{
    self.beginLabel.textColor = [UIColor cyanColor];
    self.overLabel.textColor = [UIColor cyanColor];
    if ([[intervalTime firstObject] integerValue]!= 0) {
        NSArray *tmpArr = [intervalTime[0] componentsSeparatedByString:@" "];
        self.beginLabel.text = [tmpArr firstObject];
        
    }else{
        self.beginLabel.text = @"开始日期";
    }
    if([intervalTime[1] integerValue] !=0){
         NSArray *tmpArr = [intervalTime[1] componentsSeparatedByString:@" "];
        self.overLabel.text = [tmpArr firstObject];
    }else{
        self.overLabel.text = @"结束日期";
    }
    
    if ([[intervalTime lastObject] integerValue]!= 0) {
        self.daysLabel.text = [NSString stringWithFormat:@"%@天",intervalTime[2]];
    }else{
    self.daysLabel.text = [NSString stringWithFormat:@"%d天",0];
    }
    
    UITapGestureRecognizer *beginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginTap)];
    [self.beginView addGestureRecognizer:beginTap];
    
    UITapGestureRecognizer *overTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overTap)];
    [self.overView addGestureRecognizer:overTap];
}
- (void)beginTap{
    NSLog(@"beginTap");
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"packageDate" object:@"beginTap"];
    
}
- (void)overTap{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"packageDate" object:@"overTap"];
    NSLog(@"overTap");
}


@end
