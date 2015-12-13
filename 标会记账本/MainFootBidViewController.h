//
//  MainFootBidViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/26.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"
#import "EGORefreshTableHeaderView.h"


@protocol PassValueDelegate <NSObject>

-(void)passValue:(NSArray *) valueArray;

@end


@interface MainFootBidViewController : BaseProjectViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,MBProgressHUDDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
 
    EGORefreshTableHeaderView *refreshTableHeaderView;
    BOOL reloading;
    
    BOOL _isOpen; //是否展开
    NSInteger  selectedIndex; //选中的
    
    NSArray       *contentPickViewarray;//选择器 提醒
    
    
}
@property(nonatomic,weak) id<PassValueDelegate> Valuedelegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *myHeadTableView;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
