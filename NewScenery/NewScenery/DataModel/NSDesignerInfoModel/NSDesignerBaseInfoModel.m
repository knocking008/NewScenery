//
//  NSDesignerBaseInfoModel.m
//  NewScenery
//
//  Created by mac on 16/1/16.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSDesignerBaseInfoModel.h"

@implementation NSDesignerBaseInfoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
+ (NSInteger)HeighForCollectionView:(NSArray *)array{
    NSInteger tmp = 0;
    if (array.count%3 != 0) {
        tmp = array.count/3+1;
    }else{
        tmp = array.count/3;
    }
    return tmp*43;
}
@end
