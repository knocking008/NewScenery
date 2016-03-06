//
//  NSDefaultCell.h
//  NewScenery
//
//  Created by mac on 16/2/15.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDefaultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;

- (void)fullDefaultCellWithTitle:(NSString *)title;
@end
