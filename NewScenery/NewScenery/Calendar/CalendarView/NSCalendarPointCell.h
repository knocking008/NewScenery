//
//  NSCalendarPointCell.h
//  NewScenery
//
//  Created by mac on 16/1/23.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSCalendarPointCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titlLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *daliy_noteLabel;
@property (weak, nonatomic) IBOutlet UIView *phoneView;

- (void)fullCellWithNSDaliysPointModel:(NSDaliysPointModel *)model;
@end
