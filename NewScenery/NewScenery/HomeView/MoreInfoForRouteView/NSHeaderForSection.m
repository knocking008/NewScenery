//
//  NSHeaderForSection.m
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSHeaderForSection.h"

@implementation NSHeaderForSection

- (void)fullViewWithNSRoute_overviewModel:(NSRoute_overviewModel *)model
{
    
        self.DLabel.text = model.index_text;
        self.dateLabel.text = model.day_date;
        self.locationLabel.text = model.title;

}

@end
