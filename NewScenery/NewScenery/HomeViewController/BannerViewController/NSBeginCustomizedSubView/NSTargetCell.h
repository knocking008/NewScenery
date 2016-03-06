//
//  NSTargetCell.h
//  NewScenery
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSTargetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)fullCellWithNSPlaceModel:(NSPlaceModel *)model;
@end
