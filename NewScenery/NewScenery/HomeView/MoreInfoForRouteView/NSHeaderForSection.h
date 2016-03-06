//
//  NSHeaderForSection.h
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSHeaderForSection : UIView
@property (weak, nonatomic) IBOutlet UILabel *DLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

- (void)fullViewWithNSRoute_overviewModel:(NSRoute_overviewModel *)model;

@end
