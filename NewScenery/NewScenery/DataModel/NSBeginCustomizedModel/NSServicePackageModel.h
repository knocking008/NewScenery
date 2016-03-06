//
//  NSServicePackageModel.h
//  NewScenery
//
//  Created by mac on 16/1/28.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSServicePackageModel : NSObject

@property (nonatomic, strong)NSString *package_id;
@property (nonatomic, strong)NSString *title_en;
@property (nonatomic, strong)NSString *title_cn;
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *type_text;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *price_text;
@property (nonatomic, strong)NSString *member_min;
@property (nonatomic, strong)NSString *member_max;
@property (nonatomic, strong)NSString *designer_text;
@property (nonatomic, strong)NSString *route_num;
@property (nonatomic, strong)NSString *e_guide;
@property (nonatomic, strong)NSString *booking;
@property (nonatomic, strong)NSString *route_book;
@property (nonatomic, strong)NSString *can_call;
@property (nonatomic, strong)NSString *quantity;
@property (nonatomic, strong)NSString *quantity_text;

@end
