//
//  NSRouteCell.h
//  NewScenery
//
//  Created by mac on 16/1/12.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSRouteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *sceneryImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *designerHerderImageView;

- (void)fullCellWithNSMoreRouteListModel:(NSMoreRouteListModel *)model;
@end
