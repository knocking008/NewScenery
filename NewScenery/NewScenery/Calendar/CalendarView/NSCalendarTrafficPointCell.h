//
//  NSCalendarTrafficPointCell.h
//  NewScenery
//
//  Created by mac on 16/1/23.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSCalendarTrafficPointCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *daliy_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *target_cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *start_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrive_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *daliy_date1;
@property (weak, nonatomic) IBOutlet UILabel *number_flightLabel;
@property (weak, nonatomic) IBOutlet UILabel *daliy_noteLabel;
@property (weak, nonatomic) IBOutlet UILabel *daliy_date2;
@property (weak, nonatomic) IBOutlet UILabel *start_cityLabel;

- (void)fullCellWithNSDaliysTrafficModel:(NSDaliysTrafficModel *)model;
@end
