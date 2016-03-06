//
//  NSDesignerInfoCell.h
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDesignerInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *DesignerInfoLabel;

- (void)fullCell:(NSString *)designerSesc;
+ (CGFloat)getCellHeightWith:(NSString *)designerSesc;
@end
