//
//  NSPointBaseInfoCell.h
//  NewScenery
//
//  Created by mac on 16/1/21.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSPointBaseInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *massageLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
- (void)fullCellWith:(NSArray *)array;
@end
