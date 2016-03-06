//
//  NSDateCell.h
//  NewScenery
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *beginLabel;
@property (weak, nonatomic) IBOutlet UILabel *overLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UIView *beginView;
@property (weak, nonatomic) IBOutlet UIView *overView;

- (void)fullDateCellIntervalTime:(NSArray *)intervalTime;
@end
