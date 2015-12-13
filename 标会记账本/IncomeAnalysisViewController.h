//
//  IncomeAnalysisViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/21.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@interface IncomeAnalysisViewController : BaseProjectViewController<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mySegmentControll;

@property (nonatomic,strong) IBOutlet UIView *myHeadView;

@end
