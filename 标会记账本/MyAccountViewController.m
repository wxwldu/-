//
//  MyAccountViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "MyAccountViewController.h"
#import "MBPConfig.h"
#import "ChangePasswordViewController.h"

@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self setBackButton];

    UIButton *aButton;
    aButton = [self customButton:@"修改密码"];
    aButton.frame = CGRectMake(80, 80, self.view.frame.size.width- 160, 40);
    [aButton addTarget:self action:@selector(changePasswordButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aButton];
    
}
-(void )changePasswordButton{
    ChangePasswordViewController *aChangePasswordVC =[[ChangePasswordViewController alloc]init];
    [self.navigationController pushViewController:aChangePasswordVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
