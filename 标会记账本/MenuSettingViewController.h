//
//  MenuSettingViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"
#import "TKContactsMultiPickerController.h"

@interface MenuSettingViewController : BaseProjectViewController<UITableViewDelegate,UITableViewDataSource,TKContactsMultiPickerControllerDelegate,ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myMenuTableView;

@end
