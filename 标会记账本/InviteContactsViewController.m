//
//  ContacsViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "InviteContactsViewController.h"
#import "UserMessage.h"
#import "TKAddressBook.h"
#import "UIButton+Bootstrap.h"
#import <MessageUI/MessageUI.h>
#import "CycleSettingViewController.h"
#import "FootDetailCreatBidViewController.h"
#import "ChineseString.h"
#import "AppDelegate.h"
#import "TKContact.h"
#import "NSString+TKUtilities.h"
#import "UIImage+TKUtilities.h"

@interface InviteContactsViewController ()<MFMessageComposeViewControllerDelegate>
@property (strong, nonatomic) NSArray *myContactsArray; //联系人
@property (strong, nonatomic) NSMutableArray *mySectionIndexArray; //索引
@property (strong, nonatomic) NSMutableArray *mySelectContactsArray; //最后选中的
@end

@implementation InviteContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hidesBottomBarWhenPushed = YES;
     self.mySelectContactsArray =[[NSMutableArray alloc]init];
    //接口  判断是否为用户（菜单-联系人）：
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSLog(@"contacts :%@",[UserMessage sharedUserMessage].addressBooks);
    
//    self.myContactsArray =[ChineseString LetterSortArray:[UserMessage sharedUserMessage].addressBooks];
//    self.mySectionIndexArray =[ChineseString IndexArray:[UserMessage sharedUserMessage].addressBooks];
////    [NSArray arrayWithArray:[UserMessage sharedUserMessage].addressBooks];

    
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (_inviteType == 0) {
        self.title = @"邀请好友";
//        self.myInviteButton.hidden = YES;
//        [self.myContactTableView setFrame:CGRectMake(0, 64, APPScreenBoundsWidth, APPScreenBoundsHeight-64)];
    }else if (_inviteType == 1) {
        self.title = @"邀请会脚";
//        self.myInviteButton.hidden = NO;
//        [self.myContactTableView setFrame:CGRectMake(0, 64, APPScreenBoundsWidth, APPScreenBoundsHeight-64-40)];
    }else if (_inviteType == 2) {
        self.title = @"邀请会脚";
        [self setLeftBackButton];
    }
    self.myInviteButton.hidden = NO;
//    [self.myContactTableView setFrame:CGRectMake(0, 64, APPScreenBoundsWidth, APPScreenBoundsHeight-64-40)];
    [self.myInviteButton normalStyle];
}


#pragma mark -------点击邀请好友
- (IBAction)myInviteButtonAction:(id)sender {
    
    if (_inviteType == 0) {
        UIButton *aButton = (UIButton *)sender;
        NSLog(@"tag :%ld",(long)aButton.tag);
        NSMutableArray *aFriends =[[NSMutableArray alloc]init];
        for (ChineseString *aChinese in self.mySelectContactsArray ) {
            TKAddressBook *aTKarress =aChinese.addressBook;
            [aFriends addObject:aTKarress.telephone];
        }
        
        //调用短信 数组可以群发
        [self showMessageView:aFriends title:@"标会" body:@"我正在使用标会记帐本，简便、透明有规范，快来一起下载吧，地址http://www.biaohui123.com"];
    }else if(_inviteType == 1 ){
        
//        if (self.ViewPassValueDelegate && [self.ViewPassValueDelegate respondsToSelector:@selector(passValue:)]) {
//            [self.ViewPassValueDelegate passValue:self.mySelectContactsArray];
//        }
//        
//        [self dismissViewControllerAnimated:NO completion:nil];
        
        FootDetailCreatBidViewController *aInviteFootDetailVC =[[FootDetailCreatBidViewController alloc] init];
        aInviteFootDetailVC.myBidDetailData = self.mySelectContactsArray;
        [self.navigationController pushViewController:aInviteFootDetailVC animated:YES];
        
    }else if(_inviteType == 2 ){
        
        if (self.ViewPassValueDelegate && [self.ViewPassValueDelegate respondsToSelector:@selector(passValueContacts:)]) {
            [self.ViewPassValueDelegate passValueContacts:self.mySelectContactsArray];
        }
        
        [self.navigationController popViewControllerAnimated:NO];
//      [self dismissViewControllerAnimated:NO completion:nil];
        
        
    }
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


//
//#pragma mark -Section的Header的值
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSString *key = [self.mySectionIndexArray objectAtIndex:section];
//    return key;
//}

//#pragma mark - row height
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 65.0;
//}

//#pragma mark -
//#pragma mark Table View Data Source Methods
//#pragma mark -设置右方表格的索引数组
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return self.mySectionIndexArray;
//}
//
//#pragma mark -
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    //点击索引，列表跳转到对应索引的行
//    
//        [tableView
//         scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
//         atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    return index;
//}
//
//#pragma mark -允许数据源告知必须加载到Table View中的表的Section数。
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return [self.mySectionIndexArray count];
//}
//#pragma mark -设置表格的行数为数组的元素个数
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [[self.myContactsArray objectAtIndex:section] count];
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    static NSString *TableSampleIdentifier = @"Identifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
//    }
//    
//    if (![self.mySelectContactsArray containsObject:[self.myContactsArray objectAtIndex:indexPath.row]]) {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//    }else{
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    
//
//    ChineseString *aChineseString =[[self.myContactsArray objectAtIndex:indexPath.section]  objectAtIndex:indexPath.row];
//    TKAddressBook *aTKAddressBook  = aChineseString.addressBook;
//    cell.textLabel.text = aTKAddressBook.name;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    return cell;
//    
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == tableView.numberOfSections) {
//
//    UIView *aView =[[UIView alloc] init];
//    aView.backgroundColor =[UIColor clearColor];
//    return aView;
//    
//    }
//    
//    return nil;
//}

//#pragma mark  UITableViewDelegate
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];
//    NSLog(@"indexPath.row :%d",indexPath.row);
//    
//    if (oneCell.accessoryType == UITableViewCellAccessoryNone)
//    {
//        
//        oneCell.accessoryType = UITableViewCellAccessoryCheckmark;
//        
//        //添加对象
//        if (![self.mySelectContactsArray containsObject:[self.myContactsArray objectAtIndex:indexPath.row]]) {
//            
//            ChineseString *aChineseStr =[[self.myContactsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//            [self.mySelectContactsArray addObject:aChineseStr.addressBook];
//        }
//    }
//    else
//    {
//        oneCell.accessoryType = UITableViewCellAccessoryNone;
//        
//        //移除对象
//        if ([self.mySelectContactsArray containsObject:[self.myContactsArray objectAtIndex:indexPath.row]]) {
//            [self.mySelectContactsArray removeObject:[self.myContactsArray objectAtIndex:indexPath.row]];
//        }
//    }
//    
//    
//}


- (void)reloadAddressBook
{
    // Create addressbook data model
    NSMutableArray *contactsTemp = [NSMutableArray array];
    ABAddressBookRef addressBooks = [[AppDelegate sharedDelegate] addressBook];
    
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
            
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        contact.tel = [(__bridge NSString*)value telephoneWithReformat];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID];
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
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)]];
    else
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissAction:)] ];
    
    UITableViewCell *cell =[self.tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = (UIButton *)cell.accessoryView;
    [button setSelected:checked];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        [self.searchDisplayController.searchResultsTableView reloadData];
    }
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
//    NSMutableArray *objects = [NSMutableArray new];
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
//    [objects release];
//}


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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
