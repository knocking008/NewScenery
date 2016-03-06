//
//  NSDesignerCell.m
//  NewScenery
//
//  Created by mac on 16/1/12.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSDesignerCell.h"
#import "UIImageView+WebCache.h"
@implementation NSDesignerCell
{
    NSMutableArray *tmpArr;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWithMoreDesignerModel:(NSMoreDesigner *)entity
{
    tmpArr = [NSMutableArray new];
    [self.desinerImageView sd_setImageWithURL:[NSURL URLWithString:entity.img] placeholderImage:nil];
    self.nameLabel.text = entity.title;
    self.starsLabel.text = [self converterGradeWith:entity.grade];
    self.cityLabel.text = entity.city;
    self.starLabel.text = entity.grade_text;
    self.scoreLabel.text = [NSString stringWithFormat:@"满意度%d",entity.score_total];
    self.skillLabel.text = entity.skill;
    //btn
    self.phoneCallBtn.backgroundColor = [UIColor colorWithWhite:1-[self converterEnableWith:entity.can_phone_service] alpha:1];
    self.faceToFaceBtn.backgroundColor = [UIColor colorWithWhite:1-[self converterEnableWith:entity.can_doortodoor] alpha:1];
    self.inviteBtn.backgroundColor = [UIColor colorWithWhite:1-[self converterEnableWith:entity.can_route_service] alpha:1];
    [tmpArr addObject:entity];
    [tmpArr addObject:@"holder"];
}

- (float)converterEnableWith:(NSString *)btnEnable{
    int tmp = [btnEnable intValue];
    if (tmp==2) {
        return 0.03;
    }else{
        return 0;
    }
}
- (NSString *)converterGradeWith:(NSString *)grade{
    NSMutableString *tmpStr = [NSMutableString new];
    for (int i = 0; i < [grade intValue]; i++) {
        [tmpStr appendString:@"★ "];
    }
    return tmpStr;
}

- (IBAction)canPhoneClick:(id)sender {
  
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [tmpArr replaceObjectAtIndex:1 withObject:@"canPhoneClick"];
    [center postNotificationName:@"ServiceMassage" object:tmpArr];
}
- (IBAction)canDoorClick:(id)sender {
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [tmpArr replaceObjectAtIndex:1 withObject:@"canDoorClick"];
    [center postNotificationName:@"ServiceMassage" object:tmpArr];
}
- (IBAction)canServiceClick:(id)sender {
  
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
      [tmpArr replaceObjectAtIndex:1 withObject:@"canServiceClick"];
    [center postNotificationName:@"ServiceMassage" object:tmpArr];}

@end
