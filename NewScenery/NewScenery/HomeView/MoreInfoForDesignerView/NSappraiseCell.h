//
//  NSappraiseCell.h
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSappraiseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nick_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *create_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)fullCellWithAppraise_listForDesignerModel:(NSAppraise_listForDesignerModel *)model;
+ (CGFloat)getCellHeightWith:(NSString *)designerSesc;
@end
