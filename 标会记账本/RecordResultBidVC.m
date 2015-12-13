//
//  RecordResultBidVC.m
//  标会记账本
//
//  Created by Siven on 15/10/18.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import "RecordResultBidVC.h"
#import "MBPConfig.h"
#import "recordTableViewCell.h"
#import "recordFirstTableViewCell.h"
#import "UIButton+Bootstrap.h"
#import "ZHPickView.h"

@interface RecordResultBidVC ()<ZHPickViewDelegate>
@property (nonatomic, strong) NSArray *BiddingCandidateArray; //竞标人
@property (nonatomic, strong) NSArray *DrawingResultArray; //竞标记录

@property (nonatomic, strong) NSArray *HavingOpenArray; //活会的会脚
@property (nonatomic, strong) NSArray *HavingNoBidArray; //未中过标的会脚

@property (nonatomic, strong) ZHPickView *pickview;
@end

@implementation RecordResultBidVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  MBPLightGrayColor;
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"竞标记录";
    [self setBackButton];
    self.hidesBottomBarWhenPushed = YES;
    
    self.recordtableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    //    self.tableView.tableFooterView = self.footTableView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.scopeButton normalStyle];
    
    [self ShowBiddingCandidateButtonAction:nil]; //获取数据
    [self ShowDrawingResultButtonAction:nil];
    
    
    [self ShowCandidateHavingNoBid];  //获取未中过标的会脚
    [self ShowCandidateHavingOpening]; //获取有活会的会脚
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ------- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.BiddingCandidateArray.count == 0) {
            return 1;
        }
        return self.BiddingCandidateArray.count;
    }
    return self.DrawingResultArray.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 35;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.indexFrom == 1) {
        if (section == 1) {
            return 145;
        }
    }
    
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    int allCellCount = self.BiddingCandidateArray.count + self.DrawingResultArray.count;
    //    int tag = indexPath.row + self.BiddingCandidateArray.count;
    if (indexPath.section == 0) {
        static NSString *TableSampleIdentifier = @"tableViewCell";
        recordFirstTableViewCell *cell = (recordFirstTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
        
        if (cell == nil) {
            NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"recordFirstTableViewCell" owner:self options:nil];
            
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[recordFirstTableViewCell class]]) {
                    cell = (recordFirstTableViewCell *)oneObject;
                }
            }
            
            
        }
        if (self.BiddingCandidateArray.count == 0) {
            cell.nameBidLabel.text = @"暂无";
            cell.biddingInterestLabel.text = @"一一";
            cell.biddingMoneyLabel.text = @"一一";
        }else{
            
            cell.nameBidLabel.text = [[self.BiddingCandidateArray objectAtIndex:indexPath.row] objectForKey:@"name"];
            cell.biddingInterestLabel.text = [[self.BiddingCandidateArray objectAtIndex:indexPath.row] objectForKey:@"biddingInterest"];
            cell.biddingMoneyLabel.text = [[self.BiddingCandidateArray objectAtIndex:indexPath.row] objectForKey:@"biddingMoney"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else {
        static NSString *TableSampleIdentifier = @"Identifier";
        recordTableViewCell *cell = (recordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
        
        if (cell == nil) {
            NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"recordTableViewCell" owner:self options:nil];
            
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[recordTableViewCell class]]) {
                    cell = (recordTableViewCell *)oneObject;
                }
            }
            
        }
        
        //        "抽签范围"（0同时最高利息，1所有活会的会脚，2未中过标的会脚，1和2都是针对本周期没有人竞标的情况）
        
//        int currentTag = indexPath.row - self.BiddingCandidateArray.count;
        cell.countLabel.text = [NSString stringWithFormat:@"第%ld次",(long)indexPath.row+1];
        cell.nameSelectLabel.text = [[self.DrawingResultArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        NSString *scopeString = [[self.DrawingResultArray objectAtIndex:indexPath.row] objectForKey:@"scope"];
        
        if ([scopeString intValue ] ==0) {
            cell.scopeSelectLabel.text = @"同时最高利息";
        } else if ([scopeString intValue ] ==1) {
            cell.scopeSelectLabel.text = @"所有活会的会脚";
        }if ([scopeString intValue ] ==2) {
            cell.scopeSelectLabel.text = @"未中过标的会脚";
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    return nil;
}


#pragma mark  UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        self.headTableView.backgroundColor = [UIColor whiteColor];
        return self.headTableView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.indexFrom == 1) {
        if (section == 1) {
            
            return self.footTableView;
        }
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 35;
    } else {
        return 80;
    }
    return  0;
}

#pragma mark -----抽签范围
- (IBAction)myScopeChoseAction:(id)sender {
    NSArray * pickArray =[NSArray arrayWithObjects:@"同时最高利息",@"所有活会的会脚",@"未中过标的会脚", nil];
    
    _pickview=[[ZHPickView alloc] initPickviewWithArray:pickArray isHaveNavControler:NO];
    _pickview.tagVaule = 2;
    //    _pickview.alertDate = resultVaule;
    _pickview.delegate=self;
    
    [_pickview show];
    
}

#pragma mark -----抽签
- (IBAction)myClickAction:(id)sender {
 
    if ([self.myScopeLabel.text isEqualToString:@"同时最高利息"]) {
        if (self.BiddingCandidateArray.count ==0) {
            ALERTView(@"无人竞标时，不能按照同时最高利息抽签，请选择其他抽签方式");
            return;
        }else{
            
            NSMutableArray *maxSortArray =[NSMutableArray arrayWithArray:self.BiddingCandidateArray];
            //取得两个值比较大的一个
            NSComparator cmptr = ^(id obj1, id obj2){
                if ([[obj1 objectForKey:@"biddingInterest"] integerValue] > [[obj2 objectForKey:@"biddingInterest"] integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if ([[obj1 objectForKey:@"biddingInterest"] integerValue] < [[obj2 objectForKey:@"biddingInterest"] integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            };
            
            
            NSArray *array = [maxSortArray sortedArrayUsingComparator:cmptr];
            NSDictionary  *max = [array lastObject];
 [self BidDrawAction:@"0" AndparticipantId:[[array lastObject] objectForKey:@"participantId"]];
            
//            
//            NSMutableArray *sortArray =[[NSMutableArray alloc ] init];
//            for (int i=0 ; i< self.BiddingCandidateArray.count; i++) {
//                
//                NSMutableArray *tempArray =[[NSMutableArray alloc] init];
//                int tempValue =[[[self.BiddingCandidateArray objectAtIndex:i] objectForKey:@"biddingInterest"] intValue];
//                
//                for (int y = i+1; y<self.BiddingCandidateArray.count; y++) {
//                    
//                    int second =[[[self.BiddingCandidateArray objectAtIndex:y] objectForKey:@"biddingInterest"] intValue];
//                    if (tempValue < second) {
//                        
//                        [tempArray addObject:[self.BiddingCandidateArray objectAtIndex:y]];
//                        
//                    }
//              }
//                
//                [sortArray addObject:tempArray];
//            }
//            
//            
//            
//            if (self.BiddingCandidateArray.count ==1) {
////                int x = arc4random() % sortArray.count;
//                [self BidDrawAction:@"0" AndparticipantId:[[self.BiddingCandidateArray objectAtIndex:0] objectForKey:@"participantId"]];
//            } else {
//                int x = arc4random() % sortArray.count;
//                [self BidDrawAction:@"0" AndparticipantId:[[sortArray objectAtIndex:x] objectForKey:@"participantId"]];
//            }
//            
        }
        
    } else if ([self.myScopeLabel.text isEqualToString:@"所有活会的会脚"]){
        if (self.HavingOpenArray.count!=0) {
            int x = arc4random() % self.HavingOpenArray.count;
            [self BidDrawAction:@"1" AndparticipantId:[[self.HavingOpenArray objectAtIndex:x] objectForKey:@"participantId"]];
        } else {
            ALERTView(@"没有活会的会脚");
        }
        
    } else if ([self.myScopeLabel.text isEqualToString:@"未中过标的会脚"]){
        if (self.HavingNoBidArray.count!=0) {
            int x = arc4random() % self.HavingNoBidArray.count;
            [self BidDrawAction:@"2" AndparticipantId:[[self.HavingNoBidArray objectAtIndex:x] objectForKey:@"participantId"]];
        } else {
            ALERTView(@"未中过标的会脚");
        }
    }else {
        ALERTView(@"请选择抽签范围");
    }

}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    NSLog(@"its  :%d",pickView.tag);
    self.myScopeLabel.text = resultString;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark ---  竞标记录（获取抽签结果）：
-(void)ShowDrawingResultButtonAction:(id)sender{
    
    //
    NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
    [parameter setObject:_aBiddingResultObject.cycleId forKey:@"cycle_id"];
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[APPBaseURL stringByAppendingString:APPShowDrawingResult] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([resuldId isKindOfClass:[NSDictionary class]]) {
            NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            int statusValue = [[json objectForKey:@"status"] intValue];
            if (statusValue == 104)  {
                
                ALERTView(@"输入周期id不合法");
                
            }
            
        }else if ([resuldId isKindOfClass:[NSArray class]]) {
            NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            self.DrawingResultArray = [NSArray arrayWithArray:json];
            [self.recordtableView reloadData];
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    
    
}

//"name": "竞标人名字",
//"biddingMoney": "标金",
//"biddingInterest": "利息",
//"participantId": "竞标人id"

#pragma mark ---  竞标记录（获取竞标人）
-(void)ShowBiddingCandidateButtonAction:(id)sender{
    
    //
    NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
    [parameter setObject:_aBiddingResultObject.cycleId forKey:@"cycle_id"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[APPBaseURL stringByAppendingString:APPShowBiddingCandidate] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([resuldId isKindOfClass:[NSDictionary class]]) {
            NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            int statusValue = [[json objectForKey:@"status"] intValue];
            if (statusValue == 104)  {
                
                ALERTView(@"输入周期id不合法");
                
            }
            
        }else if ([resuldId isKindOfClass:[NSArray class]]) {
            NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            self.BiddingCandidateArray = [NSArray arrayWithArray:json];
            [self.recordtableView reloadData];
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    
    
    
    
}


#pragma mark ---  竞标记录（抽签）
-(void)BidDrawAction:(NSString *)scope AndparticipantId:(NSString *)participantId{
    
    //
    NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
    [parameter setObject:self.gameID forKey:@"game_id"];
    [parameter setObject:_aBiddingResultObject.cycleId forKey:@"cycle_id"];
    [parameter setObject:participantId forKey:@"participant_id"];
    [parameter setObject:scope forKey:@"scope"];
    
    NSLog(@"bid :%@%@?game_id=%@&cycle_id=%@&participant_id=%@&scope=%@",APPBaseURL,APPDraw,self.gameID,self.aBiddingResultObject.cycleId,participantId,scope);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[APPBaseURL stringByAppendingString:APPDraw] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([resuldId isKindOfClass:[NSDictionary class]]) {
            NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            int statusValue = [[json objectForKey:@"status"] intValue];
            if (statusValue == 104)  {
                ALERTView(@"输入周期id不合法");
            }else if (statusValue == 105){
                ALERTView(@"输入会子id不合法");
            }else if (statusValue == 107){
                ALERTView(@"输入会脚id不合法");
            }else if (statusValue == 108){
                ALERTView(@"输入抽签范围不合法");
            }else if (statusValue == 0){
                ALERTView(@"成功");
                [self ShowDrawingResultButtonAction:nil];
                
            }
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    
    
}

#pragma mark ---  竞标记录（获取有活会的会脚）
-(void)ShowCandidateHavingOpening {
    
    //
    NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
    [parameter setObject:self.gameID forKey:@"game_id"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"%@%@?game_id=%@",APPBaseURL,APPShowCandidateHavingOpening,self.gameID);
    
    [manager POST:[APPBaseURL stringByAppendingString:APPShowCandidateHavingOpening] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([resuldId isKindOfClass:[NSDictionary class]]) {
            NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            int statusValue = [[json objectForKey:@"status"] intValue];
            if (statusValue == 105){
                ALERTView(@"输入会子id不合法");
            }
            
        }else if ([resuldId isKindOfClass:[NSArray class]]){
            NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            self.HavingOpenArray = [NSArray arrayWithArray:json];
            
        }
        

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    
    
}

#pragma mark ---  竞标记录（获取未中过标的会脚）
-(void)ShowCandidateHavingNoBid{
    
    //
    NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
    [parameter setObject:self.gameID forKey:@"game_id"];

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"%@%@?game_id=%@",APPBaseURL,APPShowCandidateHavingNoBid,self.gameID);
    
    [manager POST:[APPBaseURL stringByAppendingString:APPShowCandidateHavingNoBid] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([resuldId isKindOfClass:[NSDictionary class]]) {
            NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            int statusValue = [[json objectForKey:@"status"] intValue];
            
            if (statusValue == 105){
                ALERTView(@"输入会子id不合法");
            }
            
            
        }else if ([resuldId isKindOfClass:[NSArray class]]){
            NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            self.HavingNoBidArray = [NSArray arrayWithArray:json];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    
    
}

@end
