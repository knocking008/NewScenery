//
//  NSDesignerBaseInfoModel.h
//  NewScenery
//
//  Created by mac on 16/1/16.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDesignerBaseInfoModel : NSObject

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *can_call;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *user_sex;
@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *desc;
@property (nonatomic, strong)NSString *designer_type;
@property (nonatomic, strong)NSString *grade;
@property (nonatomic, strong)NSString *grade_text;

@property (nonatomic, strong)NSString *route_av;
@property (nonatomic, strong)NSString *service_av;
@property (nonatomic, strong)NSString *efficiency_av;

@property (nonatomic, strong)NSString *can_phone_service;
@property (nonatomic, strong)NSString *can_doortodoor;
@property (nonatomic, strong)NSString *can_route_service;
@property (nonatomic, assign)int score_total;
@property (nonatomic, assign)int appraise_total;
@property (nonatomic, strong)NSString *button_text;
@property (nonatomic, strong)NSString *skill;

+ (NSInteger)HeighForCollectionView:(NSArray *)array;

@end
