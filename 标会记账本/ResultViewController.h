//
//  ResultViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface ResultViewController : BaseProjectViewController<EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource,ZHPickViewDelegate,UIAlertViewDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    //  Reloading var should really be your tableviews datasource
    //  Putting it here for demo purposes
    BOOL _reloading;
    
}
@property(nonatomic,strong)ZHPickView *pickview;

@property (strong, nonatomic) IBOutlet UIView *myHeadTableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *myHeadFootView;

@property (weak, nonatomic) IBOutlet UIButton *mySaveHeadFootButton;

@property (strong, nonatomic) NSDictionary *detailBidData;//传值
@property (nonatomic) int indexFrom; //0会脚 1会头

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;



@end
