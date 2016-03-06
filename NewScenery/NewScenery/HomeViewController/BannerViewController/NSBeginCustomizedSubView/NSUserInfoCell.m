//
//  NSUserInfoCell.m
//  NewScenery
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSUserInfoCell.h"



@interface NSUserInfoCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *phoneTF;

@end

@implementation NSUserInfoCell
{
    UILabel *nameLabel;
    UILabel *phoneLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 21)];
        phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 41, 100, 21)];
        nameLabel.text = @"联系人姓名";
        nameLabel.font = [UIFont systemFontOfSize:15.0];
        phoneLabel.text = @"联系人电话";
        phoneLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:nameLabel];
        [self addSubview:phoneLabel];
        
        self.nameTF = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 150, 21)];
        self.nameTF.placeholder = @"请输入姓名";
        self.nameTF.delegate = self;
        self.nameTF.tag = 10;
        [self addSubview:self.nameTF];
        
        self.phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(120, 41, 150, 21)];
        self.phoneTF.placeholder = @"请输入手机号码";
        self.phoneTF.delegate = self;
        self.phoneTF.tag = 20;
        [self addSubview:self.phoneTF];
    }
    return self;
}

#pragma mark - UITextViewDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"touchField" object:nil];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    if (textField.tag == 20) {
        if (textField.text) {
           NSLog(@"%d",[self validateMobile:textField.text]);
            if ([self validateMobile:textField.text] != 0) {
                [center postNotificationName:@"userInfo" object:@"phone" userInfo:@{@"phone":textField.text}];
            }else{
                [center postNotificationName:@"userInfoError" object:@"phone"];
            }
        }
    }
    if (textField.tag == 10) {
        if (textField.text.length!=0) {
                 [center postNotificationName:@"userInfo" object:@"name" userInfo:@{@"name":textField.text}];
        }else{
            [center postNotificationName:@"userInfoError" object:@"name"];
        }
    }
    [self endEditing:YES];
    return YES;
}
//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

@end
