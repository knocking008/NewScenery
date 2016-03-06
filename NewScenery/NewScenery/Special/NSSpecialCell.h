//
//  NSSpecialCell.h
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSSpecialCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

- (void)fullCellWithNSGetspecialModel:(NSGetspecialModel *)model;
@end
