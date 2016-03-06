//
//  NSPointAuthorInfoModel.h
//  NewScenery
//
//  Created by mac on 16/1/21.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPointAuthorInfoModel : NSObject
@property (nonatomic, strong)NSString *uid;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *time;
@property (nonatomic, assign)int       is_designer;

@end
