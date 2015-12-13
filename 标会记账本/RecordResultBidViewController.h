//
//  RecordSesultHeadBidViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/22.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface RecordResultBidViewController : BaseProjectViewController< UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet UIView *headTableView; //头
@property (nonatomic, strong) IBOutlet UIView *footTableView;

@property (strong, nonatomic) NSString *cycleID; //传值

@property (strong, nonatomic) IBOutlet UIButton *scopeButton; //抽签按钮






//@property (nonatomic, strong) IBOutlet UILabel *nameBidLabel;
//@property (nonatomic, strong) IBOutlet UILabel *nameBidLabel;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;



@end
