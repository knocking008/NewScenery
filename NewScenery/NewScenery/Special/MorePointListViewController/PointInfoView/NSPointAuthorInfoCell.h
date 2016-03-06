//
//  NSPointAuthorInfoCell.h
//  NewScenery
//
//  Created by mac on 16/1/21.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSPointAuthorInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userIcomImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;

- (void)fullCellWithNSPointAuthorInfoModel:(NSPointAuthorInfoModel *)model;

@end
