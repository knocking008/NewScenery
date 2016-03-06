//
//  NSRouteDayCell.h
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSRouteDayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *noteBegImageView;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

- (void)fullCellWithNSRouteDaysModel:(NSRouteDaysModel *)model;

@end
