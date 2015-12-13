//
//  FootDetailCreatBidViewController.h
//  标会记账本
//
//  Created by Siven on 15/10/8.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@interface FootDetailCreatBidViewController : BaseProjectViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *saveCycleBidButton; //
@property (strong, nonatomic) IBOutlet UITableView *mytableView;

@property (nonatomic, strong) NSMutableArray  *myBidDetailData; //传值-选中的会脚
@property (strong, nonatomic) IBOutlet UIView *myHeaderTableView;

@end
