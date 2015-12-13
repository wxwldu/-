//
//  BaseViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/17.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseViewController.h"
#import "MBPConfig.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.view.backgroundColor = PorjectGreenColor;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (BOOL)showLoginIfNeed {
//    if (![[BSEngine currentEngine] isLoggedIn]) {
//        BasicNavigationController *subNav = [[BasicNavigationController alloc] initWithRootViewController:[[LoginController alloc] init]];
//        [self presentViewController:subNav animated:YES completion:nil];
//        return NO;
//    }
//    return YES;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
