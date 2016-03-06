//
//  NSRouteDaysModel.m
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSRouteDaysModel.h"
#import <UIKit/UIKit.h>
@implementation NSRouteDaysModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
+ (NSInteger)heightForCellWith:(NSString *)text
{
    if (text.length==0) {
        return 115;
    }
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
    bounds=[text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-51, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height+142;
}
@end
