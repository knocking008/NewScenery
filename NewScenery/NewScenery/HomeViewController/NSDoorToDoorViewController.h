//
//  NSDoorToDoorViewController.h
//  NewScenery
//
//  Created by mac on 16/1/20.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSBaseViewController.h"
@interface NSDoorToDoorViewController : NSBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *showPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UITextField *designerTypeTF;
@property (weak, nonatomic) IBOutlet UITextField *serviceTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *doorToDoorAddressTF;

@property (weak, nonatomic) IBOutlet UITextView *questionTFView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UIView *timeTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIView *BegView;

@property (nonatomic, strong)NSString *designerID;
@property (nonatomic, strong)NSString *designerType;
@end
