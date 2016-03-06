//
//  NSSearchDesignerCell.h
//  NewScenery
//
//  Created by mac on 16/1/22.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSSearchDesignerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIMageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

- (void)fullCellWithNSSearchDesignerModel:(NSSearchDesignerModel *)model;
@end
