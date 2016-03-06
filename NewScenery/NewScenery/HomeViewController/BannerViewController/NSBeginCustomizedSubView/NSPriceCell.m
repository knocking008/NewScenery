//
//  NSPriceCell.m
//  NewScenery
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSPriceCell.h"

@implementation NSPriceCell
{
    UILabel *pricrLael;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 21)];
        label.text = @"总价";
        pricrLael = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 10, 100, 21)];
        pricrLael.textColor = [UIColor cyanColor];
        [self addSubview:label];
        [self addSubview:pricrLael];
    }
    return self;
}
- (void)fullPriceCellWithCount:(NSInteger)totalPrice
{
    pricrLael.text = [NSString stringWithFormat:@"￥%ld",(long)totalPrice];
    pricrLael.textAlignment = NSTextAlignmentCenter;
}
@end
