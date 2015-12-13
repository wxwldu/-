//
//  BaseViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/17.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


/**如果未登录，则弹出登录框*/
- (BOOL)showLoginIfNeed;


@end
