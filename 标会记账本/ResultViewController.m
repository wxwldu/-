//
//  ResultViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultBidTableViewCell.h"
#import "MBPConfig.h"
#import "RecordResultBidVC.h"
#import "ResultTableViewCell.h"
#import "UIButton+Bootstrap.h"
#import "BidGameViewController.h"
#import "BidCaculatorObject.h"
#import "resultBiddingObject.h"

@interface ResultViewController (){
    int currentPage;
    resultBiddingObject *aBiddingResultObj;
    
}
//@property (strong,nonatomic) NSMutableArray  *myDataArray;
@property (strong,nonatomic) NSMutableArray *myCandidateArray; //会脚－获取会脚人
@property (strong,nonatomic) NSArray *BiddingCandidateArray; //获取竞标人

@property (strong,nonatomic) NSMutableArray  *myEditDataResult;; //竞标结果－修改或添加过的
@end

@implementation ResultViewController
@synthesize  detailBidData;

- (void)viewDidLoad {
    self.myCandidateArray =[[NSMutableArray alloc] init];
    //     self.myDataArray =[[NSMutableArray alloc] init];
    self.myEditDataResult =[[NSMutableArray alloc] init];
    currentPage = 1;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"竞标结果";
    self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self setBackButton];
    //    self.detailBidData =[[NSDictionary alloc]init];
    //    NSLog(@"dddd%@",self.detailBidData);
    
    
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    //    self.tableView.tableHeaderView = self.myHeadTableView;
    
    [self.mySaveHeadFootButton normalStyle];
    
    //会脚详情 获取会脚人
    [self getShowParticipantInfoData:[self.detailBidData objectForKey:@"gameId"]];
    [self setupRefresh];
    [self getResultFootBidData:[NSString stringWithFormat:@"%d",currentPage]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSLog(@"标金%@",[self.detailBidData objectForKey:@"baselineMoney"]); //标金
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
    //    [self.myEditDataResult removeAllObjects];
    // 1.添加数据
    [self getResultFootBidData:@"1"];
    
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
    currentPage ++;
    
    // 1.添加数据
    [self getResultFootBidData:[NSString stringWithFormat:@"%d",currentPage]];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}




#pragma mark  UITableViewDataSource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.myHeadTableView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_indexFrom == 1) {
        if (section == 0) {
            return self.myHeadFootView;
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myEditDataResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *TableSampleIdentifier = @"Identifier";
    
    ResultTableViewCell *cell =(ResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if (cell == nil) {
        NSArray *nibs =[[NSBundle mainBundle] loadNibNamed:@"ResultTableViewCell" owner:self options:nil];
        
        for (id oneObject in nibs) {
            //            if ([oneObject isKindOfClass:[ResultBidTableViewCell class]]) {
            //                cell = (ResultBidTableViewCell *)oneObject;
            if ([oneObject isKindOfClass:[ResultTableViewCell class]]) {
                cell = (ResultTableViewCell *)oneObject;
                
                //            }
            }
        }
        
        
    }
    UIButton *accessroyButton =[UIButton buttonWithType:UIButtonTypeCustom];
    accessroyButton.frame = CGRectMake(cell.frame.size.width-120, cell.frame.size.height-38, 120, 30) ;
//    [accessroyButton setBackgroundColor:[UIColor redColor]];
    
    
    [accessroyButton normalStyle];
    [accessroyButton addTarget:self action:@selector(clickDetailButtonAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:accessroyButton];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    accessroyButton.tag =indexPath.row; // 传值
    
    aBiddingResultObj = [self.myEditDataResult objectAtIndex:indexPath.row];
    cell.myNumberLabel.text = [NSString stringWithFormat:@"第%@期",aBiddingResultObj.number];
    
    if (_indexFrom == 0) {
        if ([aBiddingResultObj.biddenMoney length]==0) {
            [cell.myBiddenMoneyButton setTitle:@"一一" forState:UIControlStateNormal];
            
        }else{
            [cell.myBiddenMoneyButton setTitle:aBiddingResultObj.biddenMoney forState:UIControlStateNormal];
            
        }
        if ([aBiddingResultObj.totalMoney length]==0) {
            cell.totalMoneyLabel.text = @"一一";
        }else{
            cell.totalMoneyLabel.text = aBiddingResultObj.totalMoney;
        }
        if ([aBiddingResultObj.name length]==0) {
            [cell.nameLabelButton setTitle:@"一一" forState:UIControlStateNormal];
            
        }else{
            [cell.nameLabelButton setTitle:aBiddingResultObj.name forState:UIControlStateNormal];
        }
        
        
        
        if ([aBiddingResultObj.isOpen isEqualToString:@"0"]) {
            
            //            [cell.myBiddenMoneyButton setTitle:@"一一" forState:UIControlStateNormal];
            //            cell.totalMoneyLabel.text = @"一一";
            //            [cell.nameLabelButton setTitle:@"一一" forState:UIControlStateNormal];
            accessroyButton.tag =[aBiddingResultObj.cycleId intValue]; // 传值
            [accessroyButton setTitle:@"竞标" forState:UIControlStateNormal];
            
        } else if ([aBiddingResultObj.isOpen isEqualToString:@"1"]){
            
            
            
            [accessroyButton setTitle:@"竞标记录" forState:UIControlStateNormal];
            
        }
        
    } else if (_indexFrom == 1){
        
        //会头
        [cell.myBiddenMoneyButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];
        [cell.nameLabelButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];
        
        [cell.myBiddenMoneyButton addTarget:self action:@selector(setMoneyBidding:) forControlEvents:UIControlEventTouchUpInside];
        cell.myBiddenMoneyButton.tag = indexPath.row;
        
        
        [cell.nameLabelButton addTarget:self action:@selector(setNameBidding:) forControlEvents:UIControlEventTouchUpInside];
        cell.nameLabelButton.tag = indexPath.row;
        
        
        
        aBiddingResultObj =[self.myEditDataResult objectAtIndex:indexPath.row];
        if ([aBiddingResultObj.biddenMoney length]==0) {
            [cell.myBiddenMoneyButton setTitle:@"一一" forState:UIControlStateNormal];
            
        }else{
            [cell.myBiddenMoneyButton setTitle:aBiddingResultObj.biddenMoney  forState:UIControlStateNormal];
            
        }
        if ([aBiddingResultObj.totalMoney length]==0) {
            cell.totalMoneyLabel.text = @"一一";
        }else{
            cell.totalMoneyLabel.text = aBiddingResultObj.totalMoney;
        }
        
        if ([aBiddingResultObj.name length]==0) {
            [cell.nameLabelButton setTitle:@"一一" forState:UIControlStateNormal];
            
        }else{
            [cell.nameLabelButton setTitle:aBiddingResultObj.name forState:UIControlStateNormal];
        }
        
        if ([aBiddingResultObj.isOpen isEqualToString:@"0"]) {
            
            [accessroyButton setEnabled:NO];
            //                [accessroyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [accessroyButton setTitle:@"竞标记录" forState:UIControlStateNormal];
            [accessroyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        } else if ([aBiddingResultObj.isOpen isEqualToString:@"1"]){
            
            [accessroyButton setEnabled:YES];
            [accessroyButton setTitle:@"竞标记录" forState:UIControlStateNormal];
            
        }
        
        
        
        
        
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //  获取下一页数据
    if (indexPath.row == self.myEditDataResult.count -1) {
        NSLog(@"6666:%fand:%f and:%@",ceil([[self.detailBidData objectForKey:@"cycleNumber"] floatValue]/20.0),[[self.detailBidData objectForKey:@"cycleNumber"] floatValue],[self.detailBidData objectForKey:@"cycleNumber"]);
        
        float totalPage =  ceil([[self.detailBidData objectForKey:@"cycleNumber"] intValue]/20.0);
        if (currentPage < totalPage) {
            currentPage ++;
            [self getResultFootBidData:[NSString stringWithFormat:@"%d",currentPage]];
        }
        
        
    }
    
}
#pragma mark  ---- 设置中标标金  money bid
-(void)setMoneyBidding:(id)sender{
    
    
    UIButton *aButton = (UIButton *)sender;
    if (aButton.tag == 0) {
        ALERTView(@"第一期的标金必须为会头钱，不允许修改");
    }else if (aButton.tag == self.myEditDataResult.count-1) {
        ALERTView(@"最后一期的标金为会头钱");
        resultBiddingObject *abiddingObj =[self.myEditDataResult objectAtIndex:0];
        [aButton setTitle:abiddingObj.biddenMoney forState:UIControlStateNormal];
        
        resultBiddingObject *abidObj =[self.myEditDataResult objectAtIndex:aButton.tag];
        abidObj.biddenMoney = abiddingObj.biddenMoney;
    }else{
        
        
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"中标标金" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"添加",nil];
        [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
        dialog.tag = aButton.tag;
        [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
        [dialog show];
        
    }
    
    
}
#pragma mark  ----设置中标人 name
-(void)setNameBidding:(id)sender{
    UIButton *aButton = (UIButton *)sender;
    
    if (aButton.tag == 0) {
        ALERTView(@"第一期的中标人必须为会头，不允许修改");
    }
    //    else if (aButton.tag == self.myDataArray.count-1) {
    //        ALERTView(@"最后一期的标金为会头钱");
    //    }
    else  {
        //选择器
        NSMutableArray *aBidNameMutableArray =[[NSMutableArray alloc] init];
        for (NSDictionary *aBidName in self.myCandidateArray) {
            NSString *nameStr =[aBidName objectForKey:@"name"];
            [aBidNameMutableArray addObject:nameStr];
        }
        _pickview=[[ZHPickView alloc] initPickviewWithArray:aBidNameMutableArray isHaveNavControler:NO];
        _pickview.tagVaule = aButton.tag;
        _pickview.delegate=self;
        
        [_pickview show];
    }
    
    
}


#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1002) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }else{
        if (buttonIndex == 1) {
            NSString *biddingS = [alertView textFieldAtIndex:0].text;
            
            //判断利息是否合法，合法则赋值
            int  incomeValue = [UserMessage calculteIncomeBid:[self.detailBidData objectForKey:@"biddingMethod"] andBidMoney:biddingS andheadMoney:[self.detailBidData objectForKey:@"baselineMoney"]];
            if (incomeValue <= [[self.detailBidData objectForKey:@"topLineInterest"] intValue] &&incomeValue >= [[self.detailBidData objectForKey:@"bottomLineInterest"] intValue]) {
                
                NSIndexPath *indexPathValue =[NSIndexPath indexPathForRow:alertView.tag inSection:0];
                ResultTableViewCell *aResultTVC =[self.tableView cellForRowAtIndexPath:indexPathValue];
                [aResultTVC.myBiddenMoneyButton setTitle:biddingS forState:UIControlStateNormal];
                
                resultBiddingObject *aBidResultObj =[self.myEditDataResult objectAtIndex:alertView.tag];
                //                aBidResultObj.biddeninterest = [NSString stringWithFormat:@"%d",[UserMessage caculateInterestWithbidMoney:[aResultTVC.myBiddenMoneyButton.titleLabel.text intValue] AndbiddingMethod:[[self.detailBidData objectForKey:@"biddingMethod"] intValue] AndBaselineMoney:[[self.detailBidData objectForKey:@"baselineMoney"] intValue]]];
                
                aBidResultObj.biddeninterest = [NSString stringWithFormat:@"%d",incomeValue]; //利息
                aBidResultObj.biddenMoney = biddingS; //中标标金
                
                
                NSLog(@"bid result objec%@ and %@",aBidResultObj.biddeninterest,aBidResultObj.biddenMoney);
                //需付会款 －－－ 处理
                //                aResultTVC.myBiddenMoneyButton
                if (![aResultTVC.nameLabelButton.titleLabel.text isEqualToString:@"一一"]) {
                    //计算需付会款
                    
                    //                    aBidResultObj.biddenMoney = aResultTVC.myBiddenMoneyButton.titleLabel.text; //标金
                    //                    aBidResultObj.biddeninterest = [NSString stringWithFormat:@"%d",incomeValue];
                    //                    NSLog(@"bid result objec%@ and %@",aBidResultObj.biddeninterest,aBidResultObj.biddenMoney);
                    
                    int totalMoney = [BidCaculatorObject caculateTotalMoneyWithnumber:alertView.tag +1 AndtotalNum:self.myEditDataResult.count AndcreatorId:[[self.detailBidData objectForKey:@"participantId"] intValue] AndbiddingMethod:[self.detailBidData objectForKey:@"biddingMethod"] AndParticipant:self.myCandidateArray AndBidResult:self.myEditDataResult AndbiddenMoney:[biddingS intValue] AndbaseLineMoney:[[self.detailBidData objectForKey:@"baselineMoney"] intValue]];
                    
                    aResultTVC.totalMoneyLabel.text = [NSString stringWithFormat:@"%d",totalMoney];
                    
                    //修改状态
                    aBidResultObj.totalMoney = [NSString stringWithFormat:@"%d",totalMoney];
                    
                }
                
                //修改标金之后，后面的周期也自检更新
                int yy = alertView.tag + 1;
                for ( yy ; yy < self.myEditDataResult.count; yy ++) {
                    
                    NSIndexPath *indexPathUpdateValue =[NSIndexPath indexPathForRow:yy inSection:0];
                    
                    ResultTableViewCell *aResultUpdateCell =[self.tableView cellForRowAtIndexPath:indexPathUpdateValue];
                    
                    //需付会款 －－－ 处理
                    NSString *titleStr = aResultUpdateCell.nameLabelButton.titleLabel.text;
                    if (titleStr.length !=0)
                        if (![titleStr isEqualToString:@"一一"]) {
                            //计算需付会款
                            
                            int totalUpdateMoney = [BidCaculatorObject caculateTotalMoneyWithnumber:yy+1 AndtotalNum:self.myEditDataResult.count AndcreatorId:[[self.detailBidData objectForKey:@"participantId"] intValue] AndbiddingMethod:[self.detailBidData objectForKey:@"biddingMethod"] AndParticipant:self.myCandidateArray AndBidResult:self.myEditDataResult AndbiddenMoney:[aResultUpdateCell.myBiddenMoneyButton.titleLabel.text intValue] AndbaseLineMoney:[[self.detailBidData objectForKey:@"baselineMoney"] intValue]];
                            
                            aResultUpdateCell.totalMoneyLabel.text = [NSString stringWithFormat:@"%d",totalUpdateMoney];
                            
                            //修改状态
                            resultBiddingObject *aBidResultObj =[self.myEditDataResult objectAtIndex:yy];
                            aBidResultObj.totalMoney = aResultUpdateCell.totalMoneyLabel.text;

                        }
                    
                    
                }
                
                
            } else {
                ALERTView(@"利息应在顶标利息和底标利息之间，否则不合法");
            }
            
            
        }
        
    }
}


#pragma mark  UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    ResultViewController *aResultVC =[[ResultViewController alloc]init];
    //
    //    [self.navigationController pushViewController:aResultVC animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_indexFrom == 1) {
        if (section == 0) {
            return 55;
        }
    }
    return 0;
}



//number": "第几期",
//"biddenMoney": "标金",（还未开标则为空串）
//"totalMoney": "总会款",（还未开标则为空串）
//"name": "中标人名字",（还未开标则为空串）
//"participantId": "中标人id",（还未开标则为空串）
//"cycleId": " 周期id",
//"isOpen": " 是否开标"（0表示未开标，1表示已开标）,
//"date": " 开标日期"（年月日）


#pragma mark ----竞标 竞标记录
-(void)clickDetailButtonAct:(id)sender
{
    UIButton *aButton =(UIButton *)sender;
    
    if ([aButton.titleLabel.text isEqual:@"竞标记录"]) {
        RecordResultBidVC *aRecordresultVC =[[RecordResultBidVC alloc]init];
        aRecordresultVC.aBiddingResultObject =[self.myEditDataResult objectAtIndex:aButton.tag];
        aRecordresultVC.indexFrom = self.indexFrom;
        aRecordresultVC.gameID = [self.detailBidData objectForKey:@"gameId"] ;
        
        [self.navigationController pushViewController:aRecordresultVC animated:YES];
        
    } else if ([aButton.titleLabel.text isEqual:@"竞标"]){
        BidGameViewController *aBidGameVC =[[BidGameViewController alloc]init];
        aBidGameVC.bidDetailDictionary = self.detailBidData;
        aBidGameVC.gameID = [self.detailBidData objectForKey:@"gameId"];
        aBidGameVC.cycleID =[NSString stringWithFormat:@"%ld",(long)aButton.tag];
        //        aBidGameVC.indexFrom = self.indexFrom;
        [self.navigationController pushViewController:aBidGameVC animated:YES];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -保存按钮
- (IBAction)saveHeadFootAction:(id)sender {
    NSMutableArray *newMutableArray =[[NSMutableArray alloc] init];
    
    NSMutableArray *sortArray =[NSMutableArray arrayWithArray:self.myEditDataResult];
    for (int i = 0; i < sortArray.count; i ++) {
        resultBiddingObject *aDic =[sortArray objectAtIndex:i];
        
        NSMutableArray *tempArray =[[NSMutableArray alloc] init];
        [tempArray addObject:aDic];
        
        for (int j = i + 1; j < sortArray.count ; j ++) {
            resultBiddingObject *secondDic =[sortArray objectAtIndex:j];
            
            if ([aDic.name isEqualToString:secondDic.name]) {
                [tempArray addObject:secondDic];
                [sortArray removeObjectAtIndex:j];
            }
        }
        [newMutableArray addObject:tempArray];
    }
    
    for (NSArray *array in newMutableArray ) {
        //        NSString *string =[[array objectAtIndex:0] objectForKey:@"name"];
        resultBiddingObject *aObject =[array objectAtIndex:0];
        
        for (int x = 0; x< self.myCandidateArray.count; x ++) {
            NSString *nameStr=[[self.myCandidateArray objectAtIndex:x] objectForKey:@"name"];
            if ([aObject.name isEqualToString:nameStr]) {
                if (array.count >[[[self.myCandidateArray objectAtIndex:x] objectForKey:@"totalNumber"] intValue]) {
                    
                    if ([[[self.myCandidateArray objectAtIndex:0] objectForKey:@"name"] isEqualToString:aObject.name]) {
                        //不可见时会头可突破
                        if ([[[self.detailBidData objectForKey:@"showAll"] stringValue] isEqualToString:@"1"]) {
                            NSString *tips =[NSString stringWithFormat:@"%@活标已用完，请重新选择",[[self.myCandidateArray objectAtIndex:x] objectForKey:@"name"]];
                            ALERTView(tips);
                            return ;
                        }
                        
                    }else{
                        NSString *tips =[NSString stringWithFormat:@"%@活标已用完，请重新选择",[[self.myCandidateArray objectAtIndex:x] objectForKey:@"name"]];
                        ALERTView(tips);
                        return ;
                    }
                    
                    
                    
                }
            }
        }
        
    }
    
    [self getEditBiddingResult:self.myEditDataResult];
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 
 */
//"number": "第几期",
//"biddenMoney": "标金",（还未开标则为空串）
//"totalMoney": "总会款",（还未开标则为空串）
//"name": "中标人名字",（还未开标则为空串）
//"participantId": "中标人id",（还未开标则为空串）
//"cycleId": " 周期id",
//"isOpen": " 是否开标"（0表示未开标，1表示已开标）,
//"date": " 开标日期"（年月日）

-(void)getResultFootBidData:(NSString *)currPage {
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:[self.detailBidData objectForKey:@"gameId"] forKey:@"game_id"];
        [parameter setObject:[self.detailBidData objectForKey:@"startTime"] forKey:@"start_time"];
        [parameter setObject:currPage forKey:@"current_page"];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPShowBiddingResult] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            id resultResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([resultResponse isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 105)  {
                    ALERTView(@"输入会子id不合法");
                }else if (statusValue ==106)  {
                    ALERTView(@"输入当前页码不合法");
                }
                
            } else if([resultResponse isKindOfClass:[NSArray class]]){
                NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                //                [self.myDataArray addObjectsFromArray:json];
                
                
                for (NSDictionary *aDict in json) {
                    
                    resultBiddingObject *aResultObj =[[resultBiddingObject alloc] initWithResultDictonary:aDict];
                    
                    aResultObj.biddingmethod =[self.detailBidData objectForKey:@"biddingMethod"];//标类型
                    aResultObj.participantId = [self.detailBidData objectForKey:@"participantId"];//会头ID
                    aResultObj.gameid = [self.detailBidData objectForKey:@"gameId"];//会子ID
                    aResultObj.baselineMoney =[self.detailBidData objectForKey:@"baselineMoney"];//回头钱
                    
                    NSLog(@"participantId:%@",aResultObj.participantId);
                    
                    //计算利息
                    if (aResultObj.biddenMoney.length!=0&&aResultObj.totalMoney.length!=0) {
                        int  incomeValue = [UserMessage calculteIncomeBid:[self.detailBidData objectForKey:@"biddingMethod"] andBidMoney:aResultObj.biddenMoney andheadMoney:[self.detailBidData objectForKey:@"baselineMoney"]];
                        
                        aResultObj.biddeninterest =[NSString stringWithFormat:@"%d",incomeValue];
                    }

                    
                    [self.myEditDataResult addObject:aResultObj];
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


#pragma mark --- 显示会脚详情获取会脚人
-(void)getShowParticipantInfoData:(NSString *)gameid {
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:gameid forKey:@"game_id"];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPShowParticipantInfo] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([resuldId isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 105)  {
                    ALERTView(@"输入会子id不合法");
                }
                //   else  if (statusValue ==206)  {
                //     ALERTView(@"更新失败");
                //   }
                
                
            } else if([resuldId isKindOfClass:[NSArray class]]){
                NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                self.myCandidateArray  = json;
                //                [self.mytableView reloadData];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
}


//"results": "json字符串，格式如下（按照number从小到大排）"
//[
//{
//    "old_participant_id": "原中标人id",（若没有就传-1）
//    "new_participant_id": "现中标人id",（若没有就传-1）
//    "bidden_money": "标金",
//    "bidden_interest": "利息",
//    "total_money": "总会款",
//    "game_id": "会子id",
//    "cycle_id": " 周期id",
//    "number": "第几期",
//    "bidding_method": "标类型",
//    "baseline_money": "会头钱",
//    "participant_id ": "会头id"
//}
// …若干个
// ]
#pragma mark --- EditBiddingResult.php 编辑竞标结果：
-(void)getEditBiddingResult:(NSArray *)biddingResult {
    for (resultBiddingObject *aBidResultObj in biddingResult){
        
        NSLog(@"1118888old:%@,new:%@,money:%@,total:%@,interest:%@,game:%@,cycle:%@,number:%@,method:%@,baseline:%@,parti:%@",aBidResultObj.oldparticipantId,aBidResultObj.newparticipantId,aBidResultObj.biddenMoney,aBidResultObj.totalMoney,aBidResultObj.biddeninterest,aBidResultObj.gameid,aBidResultObj.cycleId,aBidResultObj.number,aBidResultObj.biddingmethod,aBidResultObj.baselineMoney,aBidResultObj.participantId);
        
    }
    //    return;
    
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        NSMutableArray *aMutableArray=[[NSMutableArray alloc] init];
        for (resultBiddingObject *aBidResultObj in biddingResult) {
            if (!([aBidResultObj.oldparticipantId isEqualToString:@"-1"] && [aBidResultObj.newparticipantId isEqualToString:@"-1"])) {
                NSMutableDictionary *aDic =[[NSMutableDictionary alloc] init];
                [aDic setObject:aBidResultObj.oldparticipantId forKey:@"old_participant_id"];
                [aDic setObject:aBidResultObj.newparticipantId forKey:@"new_participant_id"];
                
                NSLog(@"bidden money:%@",aBidResultObj.biddenMoney);
                if (aBidResultObj.biddenMoney.length!=0) {
                    [aDic setObject:aBidResultObj.biddenMoney forKey:@"bidden_money"];
                }else{
                    [aDic setObject:@"0" forKey:@"bidden_money"];
                }
                
                //没有中标人
                if (aBidResultObj.biddeninterest.length!=0) {
                    [aDic setObject:aBidResultObj.biddeninterest forKey:@"bidden_interest"];
                }else{
                    [aDic setObject:@"0" forKey:@"bidden_interest"];
                }
                if (aBidResultObj.totalMoney.length!=0) {
                    [aDic setObject:aBidResultObj.totalMoney forKey:@"total_money"];
                }else{
                    [aDic setObject:@"0" forKey:@"total_money"];
                }
                
                [aDic setObject:aBidResultObj.gameid forKey:@"game_id"];
                [aDic setObject:aBidResultObj.cycleId forKey:@"cycle_id"];
                [aDic setObject:aBidResultObj.number forKey:@"number"];
                [aDic setObject:aBidResultObj.biddingmethod forKey:@"bidding_method"];
                [aDic setObject:aBidResultObj.baselineMoney forKey:@"baseline_money"];
                [aDic setObject:aBidResultObj.participantId forKey:@"participant_id"];
                
                [aMutableArray addObject:aDic];

            }
        }
        
        NSData *editBiddingResult =[NSJSONSerialization dataWithJSONObject:aMutableArray options:0 error:nil];
        NSString *InfoDatestring =[[NSString alloc]initWithData:editBiddingResult encoding:NSUTF8StringEncoding];
        
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSMutableDictionary *parameterDic =[[NSMutableDictionary alloc] init];
        [parameterDic setObject:InfoDatestring forKey:@"results"];
        NSLog(@"7777%@%@?results=%@",APPBaseURL,APPEditBiddingResult,InfoDatestring);
        [manager POST:[APPBaseURL stringByAppendingString:APPEditBiddingResult] parameters:parameterDic  success:^(NSURLSessionDataTask *task, id responseObject) {
            id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([resuldId isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 112)  {
                    ALERTView(@"输入的编辑参数不合法");
                }else if (statusValue == 0)  {
                    
                    ALERTView(@"编辑成功");
                    //                    UIAlertView *successAlertView =[[UIAlertView alloc] initWithTitle:@"成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    //                    successAlertView.tag = 1002;
                    //                    [successAlertView show];
                    
                    //更新界面数据
                    [self.myEditDataResult removeAllObjects];
                    
                    currentPage = 1;
                    [self getResultFootBidData:@"1"];
                    
                }else if (statusValue == 211)  {
                    ALERTView(@"编辑失败");
                }
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
}


#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    NSLog(@"result string :%@",resultString);
    if (resultString.length != 0) {
        ResultTableViewCell *aResultVCell =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:pickView.tagVaule inSection:0]];
        [aResultVCell.nameLabelButton setTitle:resultString forState:UIControlStateNormal];
        
        //中标人修改，状态变
        resultBiddingObject *aBidResultObj =[self.myEditDataResult objectAtIndex:pickView.tagVaule];
        if ([aBidResultObj.newparticipantId isEqualToString:@"-1"]) {
            aBidResultObj.newparticipantId = [[self.myCandidateArray objectAtIndex:pickView.selectRow] objectForKey:@"participantId"];
            //            aBiddingResultObj.oldparticipantId = @"-1";
        }else{
            
            //            aBidResultObj.oldparticipantId = aBidResultObj.newparticipantId;
            aBidResultObj.newparticipantId = [[self.myCandidateArray objectAtIndex:pickView.selectRow] objectForKey:@"participantId"];
            
        }
        
        aBidResultObj.name = resultString;
        aBidResultObj.newparticipantId =[[self.myCandidateArray objectAtIndex:pickView.selectRow] objectForKey:@"participantId"];
        NSLog(@"abidResultObj participantid:%@",aBidResultObj.participantId);
        
        if ([aResultVCell.myBiddenMoneyButton.titleLabel.text isEqualToString:@"一一"]) {
            ALERTView(@"请填写标金");
            return;
        }
        
        
        //计算需付会款
        int totalMoney =[BidCaculatorObject caculateTotalMoneyWithnumber:pickView.tagVaule+1 AndtotalNum:self.myEditDataResult.count AndcreatorId:[[self.detailBidData objectForKey:@"participantId"] intValue] AndbiddingMethod:[self.detailBidData objectForKey:@"biddingMethod"] AndParticipant:self.myCandidateArray AndBidResult:self.myEditDataResult AndbiddenMoney:[aResultVCell.myBiddenMoneyButton.titleLabel.text intValue] AndbaseLineMoney:[[self.detailBidData objectForKey:@"baselineMoney"] intValue]] ;
        
        aResultVCell.totalMoneyLabel.text = [NSString stringWithFormat:@"%d",totalMoney];
        aBidResultObj.totalMoney = [NSString stringWithFormat:@"%d",totalMoney] ;
        NSLog(@"total money:%@,name:%@,bid:%@",aBidResultObj.totalMoney,aBidResultObj.name,aBidResultObj.biddenMoney);
        
        
        
        //修改标金之后，后面的周期也自检更新
        int yy = pickView.tagVaule + 1;
        for ( yy ; yy < self.myEditDataResult.count; yy ++) {
            
            NSIndexPath *indexPathUpdateValue =[NSIndexPath indexPathForRow:yy inSection:0];
            
            ResultTableViewCell *aResultUpdateCell =[self.tableView cellForRowAtIndexPath:indexPathUpdateValue];
            
            NSLog(@"my bidden money:%@ andtag:%d",aResultUpdateCell.myBiddenMoneyButton.titleLabel.text,yy);
            //需付会款 －－－ 处理
                    
                    
            NSString *titleStr = aResultUpdateCell.myBiddenMoneyButton.titleLabel.text;
                
                if (titleStr.length !=0)
                    if (![titleStr isEqualToString:@"一一"]) {
                        //计算需付会款
                        int totalUpdateMoney = [BidCaculatorObject caculateTotalMoneyWithnumber:yy+1 AndtotalNum:self.myEditDataResult.count AndcreatorId:[[self.detailBidData objectForKey:@"participantId"] intValue] AndbiddingMethod:[self.detailBidData objectForKey:@"biddingMethod"] AndParticipant:self.myCandidateArray AndBidResult:self.myEditDataResult AndbiddenMoney:[aResultUpdateCell.myBiddenMoneyButton.titleLabel.text intValue] AndbaseLineMoney:[[self.detailBidData objectForKey:@"baselineMoney"] intValue]];
                        
                        aResultUpdateCell.totalMoneyLabel.text = [NSString stringWithFormat:@"%d",totalUpdateMoney];
                        
                        //修改状态
                        resultBiddingObject *aBidResultObjUpdate =[self.myEditDataResult objectAtIndex:yy];
                        aBidResultObjUpdate.totalMoney = [NSString stringWithFormat:@"%d",totalUpdateMoney];
                        
                    }
                
            }
            
            
        }
        
        
}


@end
