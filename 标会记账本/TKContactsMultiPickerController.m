//
//  TKContactsMultiPickerController.m
//  TKContactsMultiPicker
//
//  Created by Jongtae Ahn on 12. 8. 31..
//  Copyright (c) 2012년 TABKO Inc. All rights reserved.
//

#import "TKPeoplePickerController.h"
#import "TKContactsMultiPickerController.h"
#import "NSString+TKUtilities.h"
#import "UIImage+TKUtilities.h"
#import "AppDelegate.h"

#import "FootDetailCreatBidViewController.h"

@interface TKContactsMultiPickerController(PrivateMethod)

- (IBAction)doneAction:(id)sender;
- (IBAction)dismissAction:(id)sender;

@end

@implementation TKContactsMultiPickerController
@synthesize tableView = _tableView;
@synthesize delegate = _delegate;
@synthesize savedSearchTerm = _savedSearchTerm;
@synthesize savedScopeButtonIndex = _savedScopeButtonIndex;
@synthesize searchWasActive = _searchWasActive;
@synthesize searchBar = _searchar;

@synthesize  addressBooks;


#pragma mark -
#pragma mark Craete addressbook ref

- (void)reloadAddressBook
{
    [self.myInviteButton normalStyle];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Create addressbook data model
    NSMutableArray *contactsTemp = [NSMutableArray array];
//    ABAddressBookRef addressBooks = [[AppDelegate sharedDelegate] addressBook];
    
    
    NSMutableArray *addressBookTemp =[[NSMutableArray alloc]init];
    //新建一个通讯录类
    //    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        
    }
    
    else
        
    {
        addressBooks = ABAddressBookCreate();
        
    }
    
    
    CFArrayRef allPeople;
    CFIndex peopleCount;
//    if (_group) {
//        self.title = _group.name;
//        ABRecordRef groupRecord = ABAddressBookGetGroupWithRecordID(addressBooks, (ABRecordID)_group.recordID);
//        allPeople = ABGroupCopyArrayOfAllMembers(groupRecord);
//        peopleCount = (CFIndex)_group.membersCount;
//    } else {
        self.title = NSLocalizedString(@"All Contacts", nil);
        allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
        peopleCount = ABAddressBookGetPersonCount(addressBooks);
//    }
    
    for (NSInteger i = 0; i < peopleCount; i++)
    {
        ABRecordRef contactRecord = CFArrayGetValueAtIndex(allPeople, i);
        
        // Thanks Steph-Fongo!
        if (!contactRecord) continue;
        
        CFStringRef abName = ABRecordCopyValue(contactRecord, kABPersonFirstNameProperty);
        CFStringRef abLastName = ABRecordCopyValue(contactRecord, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(contactRecord);
        TKContact *contact = [[TKContact alloc] init];
        
        /*
         Save thumbnail image - performance decreasing
         UIImage *personImage = nil;
         if (person != nil && ABPersonHasImageData(person)) {
         if ( &ABPersonCopyImageDataWithFormat != nil ) {
         // iOS >= 4.1
         CFDataRef contactThumbnailData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
         personImage = [[UIImage imageWithData:(NSData*)contactThumbnailData] thumbnailImage:CGSizeMake(44, 44)];
         CFRelease(contactThumbnailData);
         CFDataRef contactImageData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatOriginalSize);
         CFRelease(contactImageData);
         
         } else {
         // iOS < 4.1
         CFDataRef contactImageData = ABPersonCopyImageData(person);
         personImage = [[UIImage imageWithData:(NSData*)contactImageData] thumbnailImage:CGSizeMake(44, 44)];
         CFRelease(contactImageData);
         }
         }
         [addressBook setThumbnail:personImage];
         */
        
        NSString *fullNameString;
        NSString *firstString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            fullNameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                fullNameString = [NSString stringWithFormat:@"%@ %@", firstString, lastNameString];
            }
        }
        
        contact.name = fullNameString;
        contact.recordID = (int)ABRecordGetRecordID(contactRecord);
        contact.rowSelected = NO;
        contact.lastName = (__bridge NSString*)abLastName;
        contact.firstName = (__bridge NSString*)abName;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(contactRecord, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
//            contact.phoneNumberarray =[[ NSMutableArray alloc ]init];
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        NSString *phoneStr =[NSString stringWithFormat:@"%@;",[(__bridge NSString*)value telephoneWithReformat]];
                        if (k == 0) {
                            
                            if (valuesCount == 1) {
                                contact.tempPhone = [(__bridge NSString*)value telephoneWithReformat];
                            }else{
                                contact.tel = phoneStr;
                            }
                            
                        }else {
                            
                          contact.tel = [contact.tel stringByAppendingString:phoneStr];
                            
                        }
                        
                        
                        break;
                    }
                    case 1: {// Email
                        contact.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        
        [contactsTemp addObject:contact];
        [contact release];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    
    if (allPeople) CFRelease(allPeople);
    
    // Sort data
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    
    // Thanks Steph-Fongo!
    SEL sorter = ABPersonGetSortOrdering() == kABPersonSortByFirstName ? NSSelectorFromString(@"sorterFirstName") : NSSelectorFromString(@"sorterLastName");
    
    for (TKContact *contact in contactsTemp) {
        NSInteger sect = [theCollation sectionForObject:contact
                                collationStringSelector:sorter];
        contact.sectionNumber = sect;
    }
    
    NSInteger highSection = [[theCollation sectionTitles] count];
    NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
    for (int i=0; i<=highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionArrays addObject:sectionArray];
    }
    
    for (TKContact *contact in contactsTemp) {
        [(NSMutableArray *)[sectionArrays objectAtIndex:contact.sectionNumber] addObject:contact];
    }
    
    for (NSMutableArray *sectionArray in sectionArrays) {
        NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:sorter];
        [_listContent addObject:sortedSection];
    }
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Initialization

- (id)initWithGroup:(id *)group
{
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
//        self.group = group;
        _selectedCount = 0;
        _listContent = [NSMutableArray new];
        _filteredListContent = [NSMutableArray new];
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.hidesBottomBarWhenPushed = YES;
    
//    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationItem setLeftBarButtonItem:nil];
    [self.navigationItem setTitle:NSLocalizedString(@"Contacts", nil)];
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissAction:)] autorelease]];
    
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setText:_savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
	
	self.searchDisplayController.searchResultsTableView.scrollEnabled = YES;
	self.searchDisplayController.searchBar.showsCancelButton = NO;

    [self reloadAddressBook];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:
                [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 0;
    } else {
        if (title == UITableViewIndexSearch) {
            [tableView scrollRectToVisible:self.searchDisplayController.searchBar.frame animated:NO];
            return -1;
        } else {
            return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index-1];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
	} else {
        return [_listContent count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        return [[_listContent objectAtIndex:section] count] ? [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section] : nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return 0;
    return [[_listContent objectAtIndex:section] count] ? tableView.sectionHeaderHeight : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_filteredListContent count];
    } else {
        return [[_listContent objectAtIndex:section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCustomCellID = @"TKPeoplePickerControllerCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	TKContact *contact = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
        contact = (TKContact *)[_filteredListContent objectAtIndex:indexPath.row];
	else
        contact = (TKContact *)[[_listContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if ([[contact.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
        cell.textLabel.text = contact.name;
    } else {
        cell.textLabel.font = [UIFont italicSystemFontOfSize:cell.textLabel.font.pointSize];
        cell.textLabel.text = @"No Name";
    }
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:CGRectMake(30.0, 0.0, 28, 28)];
	[button setBackgroundImage:[UIImage imageNamed:@"uncheckBox.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateSelected];
	[button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    [button setSelected:contact.rowSelected];
    
	cell.accessoryView = button;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		[self tableView:self.searchDisplayController.searchResultsTableView accessoryButtonTappedForRowWithIndexPath:indexPath];
		[self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:indexPath animated:YES];
	}
	else {
		[self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
		[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	TKContact *contact = nil;
    
	if (tableView == self.searchDisplayController.searchResultsTableView)
		contact = (TKContact*)[_filteredListContent objectAtIndex:indexPath.row];
	else
        contact = (TKContact*)[[_listContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    BOOL checked = !contact.rowSelected;
    contact.rowSelected = checked;
    
    // Enabled rightButtonItem
    if (checked) _selectedCount++;
    else _selectedCount--;
    if (_selectedCount > 0)
        [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)] autorelease]];
    else
        [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissAction:)] autorelease]];
    
    UITableViewCell *cell =[self.tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = (UIButton *)cell.accessoryView;
    [button setSelected:checked];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        [self.searchDisplayController.searchResultsTableView reloadData];
    }
  
    //多个手机号码时
    if (checked) {
        NSArray *separatArray =[[contact.tel substringToIndex:contact.tel.length-1] componentsSeparatedByString:@";"];
        
        if (separatArray.count > 1) {

            ZHPickView *_pickview=[[ZHPickView alloc] initPickviewWithArray:separatArray isHaveNavControler:NO];
            _pickview.indexValue = indexPath;
//            _pickview.alertDate = resultVaule;
            _pickview.delegate=self;
            [_pickview show];
            
        }
        else{
            contact.tel =[separatArray objectAtIndex:0];
        }
    }
}

#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    TKContact *contact = nil;
    if (self.tableView == self.searchDisplayController.searchResultsTableView)
        contact = (TKContact*)[_filteredListContent objectAtIndex:pickView.indexValue.row];
    else
        contact = (TKContact*)[[_listContent objectAtIndex:pickView.indexValue.section] objectAtIndex:pickView.indexValue.row];
    contact.tempPhone = resultString;
    

}
- (void)checkButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.tableView];
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
	
	if (indexPath != nil)
	{
		[self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
	}
}

#pragma mark -
#pragma mark Save action

//- (IBAction)doneAction:(id)sender
//{
//	NSMutableArray *objects = [NSMutableArray new];
//    for (NSArray *section in _listContent) {
//        for (TKContact *contact in section)
//        {
//            if (contact.rowSelected)
//                [objects addObject:contact];
//        }
//    }
//    
//    if ([self.delegate respondsToSelector:@selector(tkContactsMultiPickerController:didFinishPickingDataWithInfo:)])
//        [self.delegate tkContactsMultiPickerController:self didFinishPickingDataWithInfo:objects];
//    
//	[objects release];
//}

- (IBAction)dismissAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(tkContactsMultiPickerControllerDidCancel:)])
        [self.delegate tkContactsMultiPickerControllerDidCancel:self];
    else
        [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)_searchBar
{
	[self.searchDisplayController.searchBar setShowsCancelButton:NO];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar
{
	[self.searchDisplayController setActive:NO animated:YES];
	[self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
	[self.searchDisplayController setActive:NO animated:YES];
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark ContentFiltering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	[_filteredListContent removeAllObjects];
    for (NSArray *section in _listContent) {
        for (TKContact *contact in section)
        {
            NSComparisonResult result = [contact.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
            {
                [_filteredListContent addObject:contact];
            }
        }
    }
}

#pragma mark -
#pragma mark UISearchDisplayControllerDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    return YES;
}


#pragma mark -------点击邀请好友
- (IBAction)doneAction:(id)sender {
    NSMutableArray *objects = [NSMutableArray new];
    for (NSArray *section in _listContent) {
        for (TKContact *contact in section)
        {
            if (contact.rowSelected)
                [objects addObject:contact];
        }
    } 

    
    
    if (_inviteType == 0) {
        UIButton *aButton = (UIButton *)sender;
        NSLog(@"tag :%ld",(long)aButton.tag);
        
        NSMutableArray *aFriends =[[NSMutableArray alloc]init];
        for (TKContact *aChinese in objects ) {
            NSString *aTKarress =aChinese.tempPhone;
            [aFriends addObject:aTKarress];
        }
        
        //调用短信 数组可以群发
        [self showMessageView:aFriends title:@"标会" body:@"我正在使用标会记帐本，简便、透明有规范，快来一起下载吧，地址http://www.biaohui123.com"];
        
        
    }else if(_inviteType == 1 ){
        
        FootDetailCreatBidViewController *aInviteFootDetailVC =[[FootDetailCreatBidViewController alloc] init];
        aInviteFootDetailVC.myBidDetailData = objects;
        [self.navigationController pushViewController:aInviteFootDetailVC animated:YES];
        
        
    }else if(_inviteType == 2 ){
        
        if ([self.delegate respondsToSelector:@selector(tkContactsMultiPickerController:didFinishPickingDataWithInfo:)])
            [self.delegate tkContactsMultiPickerController:self didFinishPickingDataWithInfo:objects];

        
        [self.navigationController popViewControllerAnimated:NO];
        //      [self dismissViewControllerAnimated:NO completion:nil];
        
        
    }
    
    [objects release];

}

-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}


#pragma mark  MFMessageComposeViewControllerDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}



#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
//    [_group release];
	[_filteredListContent release];
    [_listContent release];
    [_tableView release];
    [UISearchBar release];
	[super dealloc];
}

@end