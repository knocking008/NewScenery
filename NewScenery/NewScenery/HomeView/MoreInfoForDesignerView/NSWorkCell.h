//
//  NSWorkCell.h
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSWorkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *skilledLabel;
- (void)fullCellWithDesignerWorksModel:(NSDesignerWorksModel *)model;
@end
