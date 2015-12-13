//
//  LoginViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/27.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@interface LoginViewController : BaseProjectViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *myPhone;
@property (strong, nonatomic) IBOutlet UITextField *myPassword;

@property (strong, nonatomic) IBOutlet UIButton *myLoginButton;

@property (strong, nonatomic) IBOutlet UIButton *ChangePasswordButton;


@property (nonatomic ) int selectTag; //1第一次安装时 rootViewControll == loginViewController

@end
