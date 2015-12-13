//
//  HeadBidViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface HeadBidViewController : BaseProjectViewController<EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *refreshTableHeaderView;
    BOOL reloading;
    
    
    NSInteger  selectedIndex;
}



@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;


@end
