//
//  NSCanCell.h
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSCanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
- (void)fullCellWith:(NSString *)canStr;
@end
