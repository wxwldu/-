//
//  BaseProjectViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/17.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"
#import "MBPConfig.h"

@interface BaseProjectViewController ()

@end

@implementation BaseProjectViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
//        self.view.backgroundColor = MBPLightGrayColor;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.hidesBottomBarWhenPushed = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//pushViewController 时
- (void)setBackButton
{
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 50)];
//    button.backgroundColor = [UIColor whiteColor];
//    [button setTitle:@"返回" forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor clearColor];
//    [button setBackgroundImage:nil forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
////    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
//    [button addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.leftBarButtonItem = customBarItem;
//    
////    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 12, 24)];
////    imageView.image = [UIImage imageNamed:@"navbar_back"];
////    [button addSubview:imageView];
    
    UIButton *aBackButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [aBackButton setFrame:CGRectMake(0, 0, 30, 30)];
    aBackButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [aBackButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [aBackButton setTitle:@"返回" forState:UIControlStateNormal];
    [aBackButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:aBackButton];
    
}

- (UIButton *)customButton:(NSString *)titleButton
{
    UIButton *aButton =[UIButton buttonWithType:UIButtonTypeCustom];
    aButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [aButton setTitleColor:PorjectGreenColor forState:UIControlStateNormal];
    [aButton setTitle:titleButton forState:UIControlStateNormal];
    aButton.layer.masksToBounds = YES;
    aButton.layer.cornerRadius = 8;
    aButton.layer.borderWidth = 0.8;
    aButton.layer.borderColor = PorjectGreenColor.CGColor;
    
    return aButton;
    
}


- (void)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//presentViewController 时
- (void)setLeftBackButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 18)];
    
    button.backgroundColor = MBPGreenColor;
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:MBPGreenColor forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"wish-list-trash-icon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = customBarItem;
}

- (void)rightButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
