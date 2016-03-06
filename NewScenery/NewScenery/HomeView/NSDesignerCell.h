//
//  NSDesignerCell.h
//  NewScenery
//
//  Created by mac on 16/1/12.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSDesignerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *desinerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *skillLabel;

@property (weak, nonatomic) IBOutlet UIButton *phoneCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *faceToFaceBtn;
@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;



- (void)fullCellWithMoreDesignerModel:(NSMoreDesigner *)entity;
@end
