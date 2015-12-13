//
//  MainFootBidViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/26.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "MainFootBidViewController.h"
#import "FootBidTableViewCell.h"
#import "MBPConfig.h"
#import "ResultViewController.h"
#import "IncomeAnalysisViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import "TKAddressBook.h"
#import "UserMessage.h"
#import "BidDownTableViewCell.h"
#import "MainFootBidViewController.h"
#import "CycleSettingViewController.h"
#import "ZHPickView.h"
#import "UIButton+Bootstrap.h"
#import "MJRefresh.h"

@interface MainFootBidViewController ()<FootBidTableViewCellDelegate,BidDownCellButtonDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ZHPickViewDelegate>{
    BOOL _multyFlag;//是否可多行展开
    
    int page; //当前页书
}
@property (strong,nonatomic) FootBidTableViewCell *aFootBidCell;
@property (strong,nonatomic) NSMutableArray  *myDataArray;

@property (nonatomic, strong) NSMutableSet *openCell;//展开的section index集合
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;
@property(nonatomic,strong)ZHPickView *pickview;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end


@implementation MainFootBidViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.openCell=[[NSMutableSet alloc] initWithCapacity:1];
        _multyFlag = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    page = 1;
    
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
    [self setEdgesForExtendedLayout:UIRectEdgeBottom];
    
    self.myDataArray =[[NSMutableArray alloc] init];
    
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone];
    NSString *passwordUser = [[NSUserDefaults standardUserDefaults] objectForKey:KUserPassword];
    if (phoneNumber.length != 0 && passwordUser.length != 0) {
        
        [self getFootBidData:[NSString stringWithFormat:@"%d",page]];
         [self setupRefresh];
    }
    
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title =@"标会记帐本";
    
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.myHeadTableView;
    [self tableHeaderView];

    
//    [self getAddressBooks];
   
}


/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//#warning 自动刷新(一进入程序就下拉刷新)
//    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可刷新";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
    self.tableView.headerRefreshingText = @"刷新中...";
    
    self.tableView.footerPullToRefreshText = @"上拉加载数据";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.tableView.footerRefreshingText = @"刷新中...";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加数据
    [self getFootBidData:[NSString stringWithFormat:@"%d",page]];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    page++;
    // 1.添加假数据
    [self getFootBidData:[NSString stringWithFormat:@"%d",page]];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}




-(void)tableHeaderView{
    UIView *aHeadView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    UIButton *aButton;
    aButton = [self customButton:@"收益分析"];
    aButton.frame = CGRectMake(50, 15, aHeadView.frame.size.width - 100, 40);
    [aButton addTarget:self action:@selector(selectHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aHeadView addSubview:aButton];
    
    self.tableView.tableHeaderView = aHeadView;
    
}
//头部跳转
-(void)selectHeadButtonAction:(id)sender{
    
    IncomeAnalysisViewController *aResultVC =[[IncomeAnalysisViewController alloc]initWithNibName:@"ResultViewController" bundle:nil];
    //    UIBarButtonItem *aBackButton =[[UIBarButtonItem alloc]init];
    //    aBackButton.title = @"返回";
    //    aResultVC.navigationItem.backBarButtonItem = aBackButton;
    aResultVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aResultVC animated:YES];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.myDataArray.count;  //在这里是几行
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //如果cell打开，则多显示一个cell
    if (self.myDataArray.count == 0) {
        return 0;
    } else {
        return [self.openCell count]>0&&[self.openCell containsObject:[NSNumber numberWithInt:(int)section]] ? 2:1;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TableSampleIdentifier = @"Identifier";
    static NSString *BidDownTableSampleIdentifier = @"BidDownIdentifier";
    
    if (indexPath.row == 0) {
        FootBidTableViewCell *cell = (FootBidTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
        
        if (cell == nil) {
            NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"FootBidTableViewCell" owner:self options:nil];
            
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[FootBidTableViewCell class]]) {
                    cell = (FootBidTableViewCell *)oneObject;
                }
            }
//            cell.detailButton  n
            cell.downCellDelegate = self;
            
        }
        
        
        cell.nameBidLabel.text = [[self.myDataArray objectAtIndex:indexPath.section] objectForKey:@"creatorName"];
        cell.amountBidLabel.text = [[self.myDataArray objectAtIndex:indexPath.section] objectForKey:@"baselineMoney"];
        
        NSString *firstDateString = [[self.myDataArray objectAtIndex:indexPath.section] objectForKey:@"firstDate"];
        NSString *calendarTypeString =[[self.myDataArray objectAtIndex:indexPath.section] objectForKey:@"calendarType"];
        
        if ([calendarTypeString isEqualToString:@"0"]) {
            cell.dateBidLabel.text = [NSString stringWithFormat:@"农历%@",firstDateString];
        } else {
            cell.dateBidLabel.text = [NSString stringWithFormat:@"阳历%@",firstDateString];
        }
        
        //        cell.backgroundColor =[UIColor greenColor];
        return cell;
        
    } else {
        BidDownTableViewCell *cell = (BidDownTableViewCell *)[tableView dequeueReusableCellWithIdentifier:BidDownTableSampleIdentifier];
        
        if (cell == nil) {
            NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"BidDownTableViewCell" owner:self options:nil];
            
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[BidDownTableViewCell class]]) {
                    cell = (BidDownTableViewCell *)oneObject;
                }
            }
            cell.valueGame = 0;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.bidDownCellButtonDelegate = self;
            cell.valueAlarmLabel.textColor = MBPGreenColor;
            cell.AlarmLabel.textColor = MBPGreenColor;
            cell.editButton.hidden = YES;
        }
        
        
        cell.cycleNumberLabel.text = [[self.myDataArray objectAtIndex:indexPath.section] objectForKey:@"cycleNumber"];
        cell.participantNumberLabel.text = [[self.myDataArray objectAtIndex:indexPath.section] objectForKey:@"participantNumber"];
        
        int biddingMethodTag = [[[self.myDataArray objectAtIndex:indexPath.section] objectForKey:@"biddingMethod"] intValue];
        if (biddingMethodTag == 0) {
            cell.biddingMethodLabel.text = @"往下标1";
        } else if (biddingMethodTag == 1) {
            cell.biddingMethodLabel.text = @"往下标2";
        } else if (biddingMethodTag == 2) {
            cell.biddingMethodLabel.text = @"往下标3";
        }else if (biddingMethodTag == 3) {
            cell.biddingMethodLabel.text = @"往上标";
        }


        [cell.topLineInterestButton setTitle:[[self.myDataArray objectAtIndex:indexPath.section] objectForKey:@"topLineInterest"]  forState:UIControlStateNormal];
        [cell.bottomLineInterestButton setTitle:[[self.myDataArray objectAtIndex:indexPath.section] objectForKey:@"bottomLineInterest"]  forState:UIControlStateNormal];
        [cell.startTimeButton setTitle:[[self.myDataArray objectAtIndex:indexPath.section] objectForKey:@"startTime"]  forState:UIControlStateNormal];
        
        
        return cell;
    }
    
    
    
    //    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section %ld and row:%d",(long)indexPath.section,indexPath.row);
    //    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    ResultViewController *aResultVC =[[ResultViewController alloc]init];
    aResultVC.indexFrom = 0;
    aResultVC.detailBidData =[self.myDataArray  objectAtIndex:indexPath.section];
    aResultVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aResultVC animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100.f;
    }
    else {
        return 250.f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}
#pragma mark - BidDownCellButtonDelegate
//点击下拉cell的里的按钮
-(void)clickBidDownCellMethod:(int)row{
    
    if (row == 0) {
        [UserMessage sharedUserMessage ].tagBidDown = 0;
        CycleSettingViewController *aCycleSetting =[[CycleSettingViewController alloc]init];
        aCycleSetting.myBidDetailData = [self.myDataArray objectAtIndex:selectedIndex];
        aCycleSetting.indexChoosen = 0;
         aCycleSetting.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aCycleSetting animated:YES];
        
    }else if(row == 1){
        [UserMessage sharedUserMessage ].tagBidDown = 1;
        CycleSettingViewController *aCycleSettingV =[[CycleSettingViewController alloc]initWithNibName:@"CycleSettingViewController" bundle:nil];
         aCycleSettingV.hidesBottomBarWhenPushed = YES;
        aCycleSettingV.myBidDetailData = [self.myDataArray objectAtIndex:selectedIndex];
        aCycleSettingV.indexChoosen = 1;
        [self.navigationController pushViewController:aCycleSettingV animated:YES];
    }else if(row == 2) {
        [UserMessage sharedUserMessage ].tagBidDown = 2;
        CycleSettingViewController *aCycleSettingVC =[[CycleSettingViewController alloc]init];
        aCycleSettingVC.myBidDetailData = [self.myDataArray objectAtIndex:selectedIndex];
        aCycleSettingVC.indexChoosen = 2;
         aCycleSettingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aCycleSettingVC animated:YES];
    }else if(row == 3) {
        
        //提醒选择器
//       [self GetAdjacentDate];
        
        
    }
    
    
}


#pragma mark - DropDownCellDelegate

//点击展开下拉cell方法
- (void)dropDownCellMethod:(FootBidTableViewCell *)cell {
    //只允许展开一行
    selectedIndex = [self.tableView indexPathForCell:cell].section; //选中的行
    NSInteger index =[self.tableView indexPathForCell:cell].section;
    NSNumber *previous=[self.openCell anyObject];
    if([self.openCell count]>0){//有cell已经展开
        [self.openCell removeAllObjects];
        if ([previous integerValue] == index) { //展开的cell和当前点击的一致，操作为收起cell
            [self deleteActionCell:[previous integerValue] tableView:self.tableView];
        }else{//操作:展开新的cell,收起旧的cell
            [self deleteActionCell:[previous integerValue] tableView:self.tableView];
            [self.openCell addObject:[NSNumber numberWithInt:(int)index]];
            [self insertActionCell:index tableView:self.tableView];
        }
    }else{
        //没有cell展开，只需展开当前cell即可
        [self.openCell addObject:[NSNumber numberWithInt:(int)index]];
        [self insertActionCell:index tableView:self.tableView];
    }
    
}
- (void)insertActionCell:(NSInteger)section tableView:(UITableView *)tableView
{
    //    NSIndexPath *cellPath=[NSIndexPath indexPathForRow:0 inSection:section];
    //    FootBidTableViewCell *cell=(FootBidTableViewCell*)[tableView cellForRowAtIndexPath:cellPath];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    //    NSInteger currentCount = [self.myDataArray[section] count];
    for (int i = 0; i < 1; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i + 1 inSection:section]];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:section];
    [tableView beginUpdates];
    [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [tableView endUpdates];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionNone
                                  animated:YES];
}

- (void)deleteActionCell:(NSInteger)section tableView:(UITableView *)tableView{
    //    NSIndexPath *cellPath=[NSIndexPath indexPathForRow:0 inSection:section];
    //    FootBidTableViewCell *cell=(FootBidTableViewCell*)[tableView cellForRowAtIndexPath:cellPath];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    //    NSInteger currentCount = [self.myDataArray[section] count];
    for (int i = 0; i < 1; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i + 1 inSection:section]];
    }
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [tableView endUpdates];
}





#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    BidDownTableViewCell *aBidDownCell =(BidDownTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:selectedIndex]];
    aBidDownCell.valueAlarmLabel.text = resultString;
    NSLog(@"date:%@ and%@",pickView.alertDate,aBidDownCell.startTimeButton.titleLabel.text);
    NSString *alertDate =[NSString  stringWithFormat:@"%@ %@",pickView.alertDate,aBidDownCell.startTimeButton.titleLabel.text];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setLocale:[NSLocale currentLocale ]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *alertDateForm = [dateFormatter dateFromString:alertDate];
    
    if ([resultString  isEqualToString:@"前15分钟"]) {
        [AppDelegate  addLocalNotification:alertDateForm andTimeSecondInterval:-15*60];
    }else if ([resultString  isEqualToString:@"前30分钟"]){
        [AppDelegate  addLocalNotification:alertDateForm andTimeSecondInterval:-30*60];
    } else if ([resultString  isEqualToString:@"前60分钟"]){
        [AppDelegate  addLocalNotification:alertDateForm andTimeSecondInterval:-60*60];
    } else if ([resultString  isEqualToString:@"前120分钟"]){
        [AppDelegate  addLocalNotification:alertDateForm andTimeSecondInterval:-120*60];
    }
    
    if (![resultString isEqualToString:@"不提醒"]) {
        [[UserMessage sharedUserMessage].alertBiddingArray addObject:[self.myDataArray objectAtIndex:selectedIndex]];
    }
    
    NSLog(@"result string :%@",resultString);
}


-(void )GetAdjacentDate{
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];

    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
        __block NSString *resultVaule =[[NSString alloc]init];
        
    [HUD showAnimated:YES whileExecutingBlock:^{
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:[[self.myDataArray objectAtIndex:selectedIndex] objectForKey:@"gameId"] forKey:@"game_id"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPGetAdjacentDate] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary  *resultResponse =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
    //提醒PickView
             resultVaule = [[resultResponse allValues] objectAtIndex:0];
            if ([resultVaule isEqualToString:@"105"]) {
                ALERTView(@"输入会子id不合法");
                return;
            } else if ([resultVaule isEqualToString:@"212"]){
                ALERTView(@"周期不存在");
                return;
            } else{
                
                NSArray * pickArray =[NSArray arrayWithObjects:@"不提醒",@"前15分钟",@"前30分钟",@"前60分钟",@"前120分钟", nil];
                _pickview=[[ZHPickView alloc] initPickviewWithArray:pickArray isHaveNavControler:NO];
                _pickview.tagVaule = 2;
                _pickview.alertDate = resultVaule;
                _pickview.delegate=self;
                
                [_pickview show];
                
            }
            
            
            
            
    //        if ([[[resultResponse allKeys] objectAtIndex:0] isEqualToString:@"status"]) {
    ////            return
    //        } else if ([[[resultResponse allKeys] objectAtIndex:0] isEqualToString:@"date"]){
    //            
    //        }

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];

}


-(void)getFootBidData:(NSString *)currentPage {
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:currentPage forKey:@"current_page"];
        [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone] forKey:@"phone_number"];
        
        NSLog(@"foot bid :%@%@?current_page=%@&phone_number=%@",APPBaseURL,APPShowAllGame,currentPage,[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone]);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPShowAllGame] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([resuldId isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 100)  {
                    ALERTView(@"输入手机号不合法");
                }else if (statusValue ==106)  {
                    ALERTView(@"输入当前页码不合法");
                }
                //            else  if (statusValue ==206)  {
                //                ALERTView(@"更新失败");
                //            }
                
                
            } else if([resuldId isKindOfClass:[NSArray class]]){
                NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (page == 1) {
                    self.myDataArray = [NSMutableArray arrayWithArray:json];
                }else{
                    
                   [self.myDataArray addObjectsFromArray:json];
                }
                

                [self.tableView reloadData];
                
            }
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
        
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
    
    
    
}

//通讯录
-(void)getAddressBooks{
    NSMutableArray *addressBookTemp =[[NSMutableArray alloc]init];
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
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
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        TKAddressBook *addressBook = [[TKAddressBook alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.telephone = (__bridge NSString*)value;
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [addressBookTemp addObject:addressBook];
        
        
    }
    
    UserMessage *aUser =[UserMessage sharedUserMessage];
    aUser.addressBooks = addressBookTemp;
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
