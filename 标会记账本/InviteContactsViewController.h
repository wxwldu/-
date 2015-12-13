//
//  ContacsViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@protocol ViewPassValueDelegate <NSObject>
-(void) passValueContacts:(NSArray *)valueArray;//用于传值的方法
@end



@interface InviteContactsViewController : BaseProjectViewController
{
    
    @private
    NSUInteger _selectedCount;
    NSMutableArray *_listContent;
    NSMutableArray *_filteredListContent;
    
}
@property (nonatomic,weak) id<ViewPassValueDelegate> ViewPassValueDelegate;

@property ( nonatomic) int inviteType; //0菜单－邀请好友 //1起会－邀请会脚  //2编辑会－添加会脚

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *myInviteButton;

@property (nonatomic,strong) NSMutableDictionary *beganBidDictiony; //传值


@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;



@end
