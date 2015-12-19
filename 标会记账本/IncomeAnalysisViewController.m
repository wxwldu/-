//
//  IncomeAnalysisViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/21.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "IncomeAnalysisViewController.h"
#import "MBPConfig.h"
#import "IncomeAnalysisViewCell.h"
#import "BidIncomeAnalyTableViewCell.h"

@interface IncomeAnalysisViewController (){
    int currentPage ;
}
@property (nonatomic,strong) NSArray *myDataByTimeArray;
@property (nonatomic,strong) NSMutableArray *myDataByGameArray;
@end

@implementation IncomeAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage =1;
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"收益分析";
    [self setBackButton];
    self.hidesBottomBarWhenPushed = YES;
    
//    [self.navigationItem.leftBarButtonItem set];
    self.mySegmentControll.selectedSegmentIndex = 0;
    [self setupRefresh];
    [self ShowProfitByTimeButtonAction:nil];
    self.mySegmentControll.tintColor = PorjectGreenColor;
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
}

- (IBAction)selectViewAction:(id)sender {
    int selectIndex =[(UISegmentedControl *)sender selectedSegmentIndex];
    
    switch (selectIndex) {
        case 0:
        {
//            self.myTableView.tableHeaderView = self.myHeadView;
            [self ShowProfitByTimeButtonAction:nil];
            [self.myTableView reloadData];
        }
            break;
        case 1:
        {
            self.myTableView.tableHeaderView =nil;
            [self ShowProfitByGameButtonAction:[NSString stringWithFormat:@"%d",currentPage]];
            [self.myTableView reloadData];
            self.myTableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
            
        }
            break;
            
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.mySegmentControll.selectedSegmentIndex == 0) {
        if (section == 0) {
            
                return  self.myHeadView;
            
        }
    }
    
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.mySegmentControll.selectedSegmentIndex == 1) {
        return self.myDataByGameArray.count;
    } else  if (self.mySegmentControll.selectedSegmentIndex == 0) {
        return self.myDataByTimeArray.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"BidIncomeAnalyTableViewCell";
    static NSString *BidIdentifier = @"IncomeAnalysisViewCell";
    
    if (self.mySegmentControll.selectedSegmentIndex == 1) {
        BidIncomeAnalyTableViewCell *cell = (BidIncomeAnalyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
        
        if (cell == nil) {
            NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"BidIncomeAnalyTableViewCell" owner:self options:nil];
            
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[BidIncomeAnalyTableViewCell class]]) {
                    cell = (BidIncomeAnalyTableViewCell *)oneObject;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        NSLog(@"databyGame:%@",[self.myDataByGameArray objectAtIndex:indexPath.row]);
        
        NSString *firstDate =[[self.myDataByGameArray objectAtIndex:indexPath.row] objectForKey:@"firstDate"];
        if ([[[self.myDataByGameArray objectAtIndex:indexPath.row] objectForKey:@"calendarType"] isEqualToString:@"0"]) {
            
            cell.firstDateLabel.text = [NSString stringWithFormat:@"农历 %@",firstDate];
            
        } else {
            cell.firstDateLabel.text = [NSString stringWithFormat:@"阳历 %@",firstDate];
        }
        cell.createNameLabel.text = [[self.myDataByGameArray objectAtIndex:indexPath.row] objectForKey:@"creatorName"];
        cell.baselineMoneyLabel.text = [[self.myDataByGameArray objectAtIndex:indexPath.row] objectForKey:@"baselineMoney"];
        
        cell.incomeLabel.text = [[self.myDataByGameArray objectAtIndex:indexPath.row] objectForKey:@"income"];
        cell.outcomeLabel.text = [[self.myDataByGameArray objectAtIndex:indexPath.row] objectForKey:@"outcome"];
        
        
        [cell.contentView.layer setMasksToBounds:YES];
        [cell.contentView.layer setCornerRadius:10];
        
        
        return cell;
        
    } else {
        IncomeAnalysisViewCell *cell = (IncomeAnalysisViewCell *)[tableView dequeueReusableCellWithIdentifier:BidIdentifier];
        
        if (cell == nil) {
            NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"IncomeAnalysisViewCell" owner:self options:nil];
            
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[IncomeAnalysisViewCell class]]) {
                    cell = (IncomeAnalysisViewCell *)oneObject;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.myTimeLabel.text = [[self.myDataByTimeArray objectAtIndex:indexPath.row] objectForKey:@"time"];
        cell.incomeLabel.text = [[self.myDataByTimeArray objectAtIndex:indexPath.row] objectForKey:@"income"];
        cell.outcomeLabel.text = [[self.myDataByTimeArray objectAtIndex:indexPath.row] objectForKey:@"outcome"];
        cell.profitLabel.text = [[self.myDataByTimeArray objectAtIndex:indexPath.row] objectForKey:@"profit"];
        
        return cell;
    }
    
    
    
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.mySegmentControll.selectedSegmentIndex == 0) {
    
        if (section == 0) {
            return 35;
        }
    }
    
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.mySegmentControll.selectedSegmentIndex == 0) {
        return 40;
    }
    else{
        return 100;
    }
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section %d and row:%d",indexPath.section,indexPath.row);
    //    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//按照时间
-(void)ShowProfitByTimeButtonAction:(id)sender{

            //
            NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];

            [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:KUserPhone] forKey:@"phone_number"];
            
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            [manager POST:[APPBaseURL stringByAppendingString:APPShowProfitByTime] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
                
                id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
                if ([resuldId isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    int statusValue = [[json objectForKey:@"status"] intValue];
                     if (statusValue == 100)  {
                        
                        ALERTView(@"输入手机号不合法");
                        
                    }
                    
                }else if ([resuldId isKindOfClass:[NSArray class]]) {
                    NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    self.myDataByTimeArray = [NSArray arrayWithArray:json];
                    [self.myTableView reloadData];
                    
                }

            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"error");
            }];
    
}




-(void)ShowProfitByGameButtonAction:(NSString *)Page{
    
    //
    NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:KUserPhone] forKey:@"phone_number"];
    [parameter setObject:Page forKey:@"current_page"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[APPBaseURL stringByAppendingString:APPShowProfitByGame] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([resuldId isKindOfClass:[NSDictionary class]]) {
            NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            int statusValue = [[json objectForKey:@"status"] intValue];
            if (statusValue == 100)  {
                
                ALERTView(@"输入手机号不合法");
                
            }else if (statusValue == 106)  {
                
                ALERTView(@"输入当前页码不合法");
                
            }
            
        }else if ([resuldId isKindOfClass:[NSArray class]]) {
            NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([Page isEqualToString:@"1"]) {
                self.myDataByGameArray = [NSMutableArray arrayWithArray:json];
            }else{
                [self.myDataByGameArray addObjectsFromArray:json];
            }
            
            [self.myTableView reloadData];
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    
    

    
    
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.myTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.myTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.myTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.myTableView.headerPullToRefreshText = @"下拉可刷新";
    self.myTableView.headerReleaseToRefreshText = @"松开马上刷新";
    self.myTableView.headerRefreshingText = @"刷新中...";
    
    self.myTableView.footerPullToRefreshText = @"上拉加载数据";
    self.myTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.myTableView.footerRefreshingText = @"刷新中...";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加数据
    if (self.mySegmentControll.selectedSegmentIndex==0) {
        [self ShowProfitByTimeButtonAction:nil];
    }else{
        
        [self ShowProfitByGameButtonAction:[NSString stringWithFormat:@"%d",currentPage]];
    }
    
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.myTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.myTableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    currentPage ++;
    // 1.添加数据
    if (self.mySegmentControll.selectedSegmentIndex==0) {
        [self ShowProfitByTimeButtonAction:nil];
    }else{
        [self ShowProfitByGameButtonAction:[NSString stringWithFormat:@"%d",currentPage]];
    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.myTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.myTableView footerEndRefreshing];
    });
}

@end
