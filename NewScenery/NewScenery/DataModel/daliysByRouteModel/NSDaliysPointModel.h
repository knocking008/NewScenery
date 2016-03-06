//
//  NSDaliysPointModel.h
//  NewScenery
//
//  Created by mac on 16/1/22.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDaliysPointModel : NSObject
@property (nonatomic, strong)NSString *trip_route_id;
@property (nonatomic, strong)NSString *day_index;
@property (nonatomic, strong)NSString *daliy_id;
@property (nonatomic, strong)NSString *daliy_time;
@property (nonatomic, strong)NSString *daliy_title;
@property (nonatomic, strong)NSString *daliy_date;
@property (nonatomic, strong)NSString *daliy_date_md;
@property (nonatomic, strong)NSString *daliy_time_text;
@property (nonatomic, strong)NSString *point_id;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *title_en;
@property (nonatomic, assign)int       is_foreign;
@property (nonatomic, strong)NSString *city_text;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *daliy_type;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *location;
@property (nonatomic, strong)NSString *daliy_note;
@end
