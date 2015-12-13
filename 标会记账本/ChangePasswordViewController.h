//
//  ChangePasswordViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/25.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ChangePasswordViewController : BaseProjectViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *OldPassword;
@property (strong, nonatomic) IBOutlet UITextField *NewPassword;
@property (strong, nonatomic) IBOutlet UITextField *CopyNewPassword;

@property (strong, nonatomic) IBOutlet UIButton *ChangePasswordButton;

@end
