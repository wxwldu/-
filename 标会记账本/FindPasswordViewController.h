//
//  FindPasswordViewController.h
//  标会记账本
//
//  Created by Siven on 15/10/9.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@interface FindPasswordViewController : BaseProjectViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *myNewPassword;
@property (strong, nonatomic) IBOutlet UITextField *myPasswordField;


@property (strong, nonatomic) IBOutlet UIButton *mySubmitButton;

@end
