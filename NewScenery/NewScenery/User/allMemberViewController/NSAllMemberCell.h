//
//  NSAllMemberCell.h
//  NewScenery
//
//  Created by mac on 16/2/17.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSAllMemberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *discLabel;

- (void)fullCellWithNSAllMemberModel:(NSAllMemberModel *)model;
@end
