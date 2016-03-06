//
//  NSMoreRouteListModel.h
//  NewScenery
//
//  Created by mac on 16/1/16.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMoreRouteListModel : NSObject

@property (nonatomic, strong)NSString  *data_id;
@property (nonatomic, strong)NSString  *title;
@property (nonatomic, strong)NSString  *desc;
@property (nonatomic, strong)NSString  *img;
@property (nonatomic, strong)NSString  *price;
@property (nonatomic, assign)int  can_buy;
@property (nonatomic, strong)NSString  *user_id;
@property (nonatomic, strong)NSString  *user_icon;
@property (nonatomic, strong)NSString  *tags;
@property (nonatomic, strong)NSString  *button;
@property (nonatomic, strong)NSString  *city;


@end
