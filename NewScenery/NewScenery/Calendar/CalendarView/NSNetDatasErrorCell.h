//
//  NSNetDatasErrorCell.h
//  NewScenery
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSNetDatasErrorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *errorImageView;

- (void)fullCellWith:(NSString *)imageName;

@end
