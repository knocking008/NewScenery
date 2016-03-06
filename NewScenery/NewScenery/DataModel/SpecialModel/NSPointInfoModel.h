//
//  NSPointInfoModel.h
//  NewScenery
//
//  Created by mac on 16/1/21.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPointInfoModel : NSObject
@property (nonatomic, strong)NSString *name_cn;
@property (nonatomic, strong)NSString *name_en;
@property (nonatomic, strong)NSString *point_type;
@property (nonatomic, strong)NSString *city_text;
@property (nonatomic, assign)int       is_foreign;
@property (nonatomic, strong)NSString *type_text;
@property (nonatomic, strong)NSString *point_desc;
@property (nonatomic, strong)NSString *point_content;
@property (nonatomic, assign)int       show_price;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, assign)int       can_buy;
@property (nonatomic, strong)NSString *per_cost;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *tips;
@property (nonatomic, strong)NSString *suggest_time;
@property (nonatomic, strong)NSString *best_season;
@property (nonatomic, strong)NSString *point_way;
@property (nonatomic, strong)NSString *lng;
@property (nonatomic, strong)NSString *lat;
@property (nonatomic, assign)int       is_praise;
@property (nonatomic, strong)NSString *praise_num;
@property (nonatomic, strong)NSString *button_text;
@property (nonatomic, strong)NSArray *img;
@end
