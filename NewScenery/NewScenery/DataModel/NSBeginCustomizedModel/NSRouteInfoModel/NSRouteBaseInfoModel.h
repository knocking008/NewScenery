//
//  NSRouteBaseInfoModel.h
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSRouteBaseInfoModel : NSObject
@property (nonatomic, strong)NSString *route_title;
@property (nonatomic, strong)NSString *start_date;
@property (nonatomic, strong)NSString *route_id;
@property (nonatomic, strong)NSString *route_desc;
@property (nonatomic, strong)NSString *user_id;
@property (nonatomic, strong)NSString *user_name;
@property (nonatomic, strong)NSString *user_sign;
@property (nonatomic, strong)NSString *user_icon;
@property (nonatomic, strong)NSString *route_icon;

+ (NSInteger)heightForLabelWith:(NSString *)text;
@end
