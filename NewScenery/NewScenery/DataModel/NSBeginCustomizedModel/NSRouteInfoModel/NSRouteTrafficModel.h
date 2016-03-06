//
//  NSRouteTrafficModel.h
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSRouteTrafficModel : NSObject
@property (nonatomic, strong)NSString *daliy_id;
@property (nonatomic, strong)NSString *daliy_time;
@property (nonatomic, assign)int       day_index;
@property (nonatomic, strong)NSString *daliy_type;
@property (nonatomic, strong)NSString *city_text;
@property (nonatomic, assign)int       is_foreign;
@property (nonatomic, strong)NSString *start_lng;
@property (nonatomic, strong)NSString *start_lat;
@property (nonatomic, strong)NSString *target_lng;
@property (nonatomic, strong)NSString *target_lat;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *start_city;
@property (nonatomic, strong)NSString *target_city;
@property (nonatomic, strong)NSString *start_city_en;
@property (nonatomic, strong)NSString *target_city_en;
@property (nonatomic, strong)NSString *start_point_id;
@property (nonatomic, strong)NSString *target_point_id;
@property (nonatomic, strong)NSString *number_flight;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *start_time;
@property (nonatomic, strong)NSString *arrive_time;
@property (nonatomic, strong)NSString *start_time_text;
@property (nonatomic, strong)NSString *arrive_time_text;
@property (nonatomic, strong)NSString *traffic_phone;
@property (nonatomic, strong)NSString *word_url;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *traffic_type;
@property (nonatomic, strong)NSString *traffic_icon;
@property (nonatomic, strong)NSString *daliy_note;


+ (NSInteger)heightForCellWith:(NSString *)text;
@end
