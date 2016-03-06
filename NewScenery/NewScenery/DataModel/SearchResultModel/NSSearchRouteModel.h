//
//  NSSearchRouteModel.h
//  NewScenery
//
//  Created by mac on 16/1/22.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSearchRouteModel : NSObject
@property (nonatomic, strong)NSString *route_title;
@property (nonatomic, strong)NSString *route_icon;
@property (nonatomic, strong)NSString *route_id;
@property (nonatomic, strong)NSString *place_li;
@property (nonatomic, assign)NSInteger route_price;
@property (nonatomic, assign)int       show_price;
@end
