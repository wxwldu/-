//
//  BaseTableViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/21.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface BaseTableViewController : BaseProjectViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    //  Reloading var should really be your tableviews datasource
    //  Putting it here for demo purposes
    BOOL _reloading;
    
}

@property (nonatomic,strong) NSArray *dataSourceArray;
@property (nonatomic,strong) UITableView *baseTableView;


- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
