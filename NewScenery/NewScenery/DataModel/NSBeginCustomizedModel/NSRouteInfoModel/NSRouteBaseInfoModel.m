//
//  NSRouteBaseInfoModel.m
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSRouteBaseInfoModel.h"

#import <UIKit/UIKit.h>
@implementation NSRouteBaseInfoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

+ (NSInteger)heightForLabelWith:(NSString *)text
{
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    bounds=[text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height+50;
}
@end
