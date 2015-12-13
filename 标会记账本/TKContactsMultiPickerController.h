//
//  TKContactsMultiPickerController.h
//  TKContactsMultiPicker
//
//  Created by Jongtae Ahn on 12. 8. 31..
//  Copyright (c) 2012년 TABKO Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <malloc/malloc.h>
#import "TKContact.h"
//#import "TKGroup.h"
#import <MessageUI/MessageUI.h>
#import "ZHPickView.h"

@class TKContact, TKContactsMultiPickerController;
@protocol TKContactsMultiPickerControllerDelegate <NSObject>
@required
- (void)tkContactsMultiPickerController:(TKContactsMultiPickerController*)picker didFinishPickingDataWithInfo:(NSArray*)contacts;
- (void)tkContactsMultiPickerControllerDidCancel:(TKContactsMultiPickerController*)picker;
@end


@interface TKContactsMultiPickerController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate,MFMessageComposeViewControllerDelegate,ZHPickViewDelegate>
{
	id _delegate;
    
@private
//    TKGroup *_group;
    NSUInteger _selectedCount;
    NSMutableArray *_listContent;
	NSMutableArray *_filteredListContent;
}

@property (nonatomic, retain) id<TKContactsMultiPickerControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
//@property (nonatomic, retain) TKGroup *group;
@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;


@property (nonatomic, strong) NSString *addressBooks; //联系人
@property (strong, nonatomic) IBOutlet UIButton *myInviteButton;
@property ( nonatomic) int inviteType; //0菜单－邀请好友 //1起会－邀请会脚  //2编辑会－添加会脚



- (id)initWithGroup:(id *)group;

@end
