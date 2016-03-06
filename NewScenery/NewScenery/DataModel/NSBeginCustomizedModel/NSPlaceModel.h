//
//  NSPlaceModel.h
//  NewScenery
//
//  Created by mac on 16/1/14.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPlaceModel : NSObject

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *img;
@property (nonatomic, strong)NSString *data_id;
@property (nonatomic, assign)BOOL isSectel;
@property (nonatomic, strong)NSString *locationTypt;

@end
