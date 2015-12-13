//
//  RegistViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/27.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@interface RegistViewController : BaseProjectViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *myPhone;
@property (strong, nonatomic) IBOutlet UITextField *myCodePhone;
@property (strong, nonatomic) IBOutlet UITextField *myPassword;

@property (strong, nonatomic) IBOutlet UIButton *myRegisterButton;
@property (strong, nonatomic) IBOutlet UIButton *myCodeSendButton;
@property (strong, nonatomic) IBOutlet UIButton *myAgreeButton;

@property (nonatomic) int index;  //0注册   1找回密码

@end
