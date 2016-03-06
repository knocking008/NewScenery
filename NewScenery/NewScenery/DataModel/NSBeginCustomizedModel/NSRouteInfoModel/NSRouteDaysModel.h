//
//  NSRouteDaysModel.h
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSRouteDaysModel : NSObject
@property (nonatomic, strong)NSString *daliy_id;
@property (nonatomic, strong)NSString *daliy_time;
@property (nonatomic, assign)int       day_index;
@property (nonatomic, strong)NSString *lng;
@property (nonatomic, strong)NSString *lat;
@property (nonatomic, strong)NSString *city_text;
@property (nonatomic, assign)int       is_foreign;
@property (nonatomic, strong)NSString *point_id;
@property (nonatomic, strong)NSString *point_type;
@property (nonatomic, strong)NSString *type_text;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *title_en;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *daliy_type;
@property (nonatomic, strong)NSString *daliy_note;
+ (NSInteger)heightForCellWith:(NSString *)text;
@end
