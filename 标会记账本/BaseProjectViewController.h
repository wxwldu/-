//
//  BaseProjectViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/17.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseProjectViewController : BaseViewController

- (void)setBackButton;
- (void)setLeftBackButton;

//定制button 绿字绿边框
- (UIButton *)customButton:(NSString *)titleButton;

@end
