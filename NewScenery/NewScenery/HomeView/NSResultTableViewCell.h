//
//  NSResultTableViewCell.h
//  NewScenery
//
//  Created by mac on 16/1/13.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSResultTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconIMageView;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *pointLabel;

- (void)fullCellWithNSSearchRouteModel:(NSSearchRouteModel *)model;

- (void)fullCellWithNSSearchPointModel:(NSSearchPointModel *)model;


@end
