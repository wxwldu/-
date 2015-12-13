//
//  HeadBidViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "HeadBidViewController.h"
#import "HeadBidTableViewCell.h"
#import "MBPConfig.h"
#import "BeginBidViewController.h"
#import "ResultViewController.h"
#import "BidDownTableViewCell.h"
#import "CycleSettingViewController.h"
#import "UserMessage.h"

@interface HeadBidViewController ()<HeadBidTableViewCellDelegate,BidDownCellButtonDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ZHPickViewDelegate,CycleSettingViewControllerCellDelegate>{
    BOOL _multyFlag;//是否可多行展开
    
    int page; //当前页数
}
@property(nonatomic,strong)ZHPickView *pickview;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (strong,nonatomic) NSMutableArray *myDataMuArray;

@property (nonatomic, strong) NSMutableSet *openCell;//展开的section index集合
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;

@end

@implementation HeadBidViewController

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
    page=1;
    
//  NSDate *ddddd =   [UserMessage NextDateFromDate:[NSDate date] andmoth:1];
    
    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
    self.myDataMuArray =[[NSMutableArray alloc] init];
    
    
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone];
    NSString *passwordUser = [[NSUserDefaults standardUserDefaults] objectForKey:KUserPassword];
    if (phoneNumber.length != 0 && passwordUser.length != 0) {
        
        [self getHeadBidData:[NSString stringWithFormat:@"%d",page]];
        [self setupRefresh];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"标会记帐本";
    // Do any additional setup after loading the view from its nib.
    reloading = NO;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self tableHeaderView];
    
    
    
}



-(void)tableHeaderView{
    UIView *aHeadView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    UIButton *aButton =[UIButton buttonWithType:UIButtonTypeCustom];
    aButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [aButton setTitleColor:PorjectGreenColor forState:UIControlStateNormal];
    [aButton setTitle:@"我要起会" forState:UIControlStateNormal];
    aButton.frame = CGRectMake(50, 15, aHeadView.frame.size.width- 100, 40);
    aButton.layer.masksToBounds = YES;
    aButton.layer.cornerRadius = 8;
    aButton.layer.borderWidth = 0.8;
    aButton.layer.borderColor = PorjectGreenColor.CGColor;
    [aButton addTarget:self action:@selector(selectHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aHeadView addSubview:aButton];
    
    self.tableView.tableHeaderView = aHeadView;
    
}
//头部跳转
-(void)selectHeadButtonAction:(id)sender{
    
    BeginBidViewController *aResultVC =[[BeginBidViewController alloc]initWithNibName:@"BeginBidViewController" bundle:nil];
    aResultVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aResultVC animated:NO];
    
}


////点击cell展开
//-(void)clickDetailButtonAction:(id)sender{
//    
//    //its detail button
//}

#pragma mark ----UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.myDataMuArray.count;  //在这里是几行
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //如果cell打开，则多显示一个cell
    if (self.myDataMuArray.count == 0) {
        return 0;
    } else{
       return [self.openCell count]>0&&[self.openCell containsObject:[NSNumber numberWithInt:(int)section]] ? 2:1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *TableSampleIdentifier = @"Identifier";
    static NSString *BidDownTableSampleIdentifier = @"BidDownIdentifier";

     if (indexPath.row == 0) {
    HeadBidTableViewCell *cell = (HeadBidTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if (cell == nil) {
        NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"HeadBidTableViewCell" owner:self options:nil];
        
        for (id oneObject in nibs) {
            if ([oneObject isKindOfClass:[HeadBidTableViewCell class]]) {
                cell = (HeadBidTableViewCell *)oneObject;
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.downCellDelegate = self;
            
        }
        
         if (self.myDataMuArray.count != 0) {
             
             cell.nameBidLabel.text = [[self.myDataMuArray objectAtIndex:indexPath.section] objectForKey:@"baselineMoney"]; //标会金额
             
             NSString *firstDateString = [[self.myDataMuArray objectAtIndex:indexPath.section] objectForKey:@"firstDate"];
             NSString *calendarTypeString =[[self.myDataMuArray objectAtIndex:indexPath.section] objectForKey:@"calendarType"];
             
             if ([calendarTypeString isEqualToString:@"0"]) {
                 cell.dateBidLabel.text = [NSString stringWithFormat:@"农历%@",firstDateString];
             } else {
                 cell.dateBidLabel.text = [NSString stringWithFormat:@"阳历%@",firstDateString];
             }

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
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.bidDownCellButtonDelegate = self;
            cell.valueAlarmLabel.textColor = [UIColor blackColor];
            cell.AlarmLabel.textColor = [UIColor blackColor];
            cell.editButton.hidden = NO;
        }
        
        
        cell.cycleNumberLabel.text = [[self.myDataMuArray objectAtIndex:indexPath.section] objectForKey:@"cycleNumber"];
        cell.participantNumberLabel.text = [[self.myDataMuArray objectAtIndex:indexPath.section] objectForKey:@"participantNumber"];
        
        int biddingMethodTag = [[[self.myDataMuArray objectAtIndex:indexPath.section] objectForKey:@"biddingMethod"] intValue];
        if (biddingMethodTag == 0) {
            cell.biddingMethodLabel.text = @"往下标1";
        } else if (biddingMethodTag == 1) {
            cell.biddingMethodLabel.text = @"往下标2";
        } else if (biddingMethodTag == 2) {
            cell.biddingMethodLabel.text = @"往下标3";
        }else if (biddingMethodTag == 3) {
            cell.biddingMethodLabel.text = @"往上标";
        }
        
        
        [cell.topLineInterestButton setTitle:[[self.myDataMuArray objectAtIndex:indexPath.section] objectForKey:@"topLineInterest"]  forState:UIControlStateNormal];
        [cell.bottomLineInterestButton setTitle:[[self.myDataMuArray objectAtIndex:indexPath.section] objectForKey:@"bottomLineInterest"]  forState:UIControlStateNormal];
        [cell.startTimeButton setTitle:[[self.myDataMuArray objectAtIndex:indexPath.section] objectForKey:@"startTime"]  forState:UIControlStateNormal];
        
        
        return cell;
    }
    
}


#pragma mark  UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ResultViewController *aResultVC =[[ResultViewController alloc]init];
    
    if (self.myDataMuArray.count  != 0) {
        aResultVC.indexFrom = 1;
        aResultVC.detailBidData =[self.myDataMuArray  objectAtIndex:indexPath.section];
        aResultVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aResultVC animated:NO];
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 70.f;
    }
    else {
        return 300.f;
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
        aCycleSetting.myBidDetailData = [self.myDataMuArray objectAtIndex:selectedIndex];
        aCycleSetting.indexChoosen = 0;
        aCycleSetting.indexFrom = 1;
        aCycleSetting.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:aCycleSetting animated:YES];
        
    }else if(row == 1){
        [UserMessage sharedUserMessage ].tagBidDown = 1;
        CycleSettingViewController *aCycleSettingV =[[CycleSettingViewController alloc]initWithNibName:@"CycleSettingViewController" bundle:nil];
        aCycleSettingV.myBidDetailData = [self.myDataMuArray objectAtIndex:selectedIndex];
        aCycleSettingV.indexChoosen = 1;
        aCycleSettingV.indexFrom = 1;
        aCycleSettingV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aCycleSettingV animated:YES];
    }
    else if(row == 2) {
        [UserMessage sharedUserMessage ].tagBidDown = 2;
        CycleSettingViewController *aCycleSettingVC =[[CycleSettingViewController alloc]init];
        aCycleSettingVC.myBidDetailData = [self.myDataMuArray objectAtIndex:selectedIndex];
        aCycleSettingVC.indexChoosen = 2;
        aCycleSettingVC.indexFrom = 1;
        aCycleSettingVC.CycleSettingVCCellButtonDelegate = self;
        aCycleSettingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aCycleSettingVC animated:YES];
    }
    else if(row == 5) {
        
        BeginBidViewController *aBeginBidVC =[[BeginBidViewController alloc]init];
        aBeginBidVC.myDataBidDetail = [self.myDataMuArray objectAtIndex:selectedIndex];
        aBeginBidVC.indexValue = 1;
        aBeginBidVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aBeginBidVC animated:NO];
    }
    
    
}

- (void)clickCycleSettingCellMethod:( int ) value{
    //0:往下标1  1:往下标2  2:往下标3  3:往上标
    BidDownTableViewCell *aBidDown =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:value inSection:0]];
    
}

#pragma mark - DropDownCellDelegate

//点击展开下拉cell方法
- (void)dropDownCellMethod:(HeadBidTableViewCell *)cell {
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
    //    NSInteger currentCount = [self.myDataMuArray[section] count];
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
    //    NSInteger currentCount = [self.myDataMuArray[section] count];
    for (int i = 0; i < 1; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i + 1 inSection:section]];
    }
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [tableView endUpdates];
}





#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    [self getHeadBidData:[NSString stringWithFormat:@"%d",page]];
    
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
    
    // 1.添加数据
    [self getHeadBidData:[NSString stringWithFormat:@"%d",page]];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}



-(void)getHeadBidData:(NSString *)currentpage{
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        
        [parameter setObject:currentpage forKey:@"current_page"];
        [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone] forKey:@"phone_number"];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPShowMyGame] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([resuldId isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 100)  {
                    ALERTView(@"输入手机号不合法");
                }else if (statusValue ==106)  {
                    ALERTView(@"输入当前页码不合法");
                }
                
            } else if([resuldId isKindOfClass:[NSArray class]]){
                NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if ([currentpage isEqualToString:@"1"]) {
                    self.myDataMuArray = [NSMutableArray arrayWithArray:json];
                }else{
                    [self.myDataMuArray addObjectsFromArray:json];
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


@end
