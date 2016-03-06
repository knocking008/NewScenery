//
//  NSUserHelpCell.h
//  NewScenery
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSUserHelpCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *TextLabel;

- (void)fullCellWith:(NSString *)title text:(NSString *)text textHidden:(int)textHidden;
@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UILabel *flagLabel;

@end
