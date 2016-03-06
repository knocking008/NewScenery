//
//  NSActionModel.h
//  NewScenery
//
//  Created by mac on 16/1/13.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSActionModel : NSObject

@property (nonatomic, strong)NSString *news_id;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *desc;
@property (nonatomic, strong)NSString *img;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *expired;

@end
