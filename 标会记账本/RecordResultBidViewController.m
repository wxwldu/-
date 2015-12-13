//
//  RecordSesultHeadBidViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/22.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "RecordResultBidViewController.h"
#import "MBPConfig.h"
#import "recordTableViewCell.h"
#import "recordFirstTableViewCell.h"
#import "UIButton+Bootstrap.h"

@interface RecordResultBidViewController ()
@property (nonatomic, strong) NSArray *BiddingCandidateArray; //竞标人
@property (nonatomic, strong) NSArray *DrawingResultArray; //竞标记录

@end

@implementation RecordResultBidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"竞标记录";
    [self setBackButton];
    self.hidesBottomBarWhenPushed = YES;

    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
//    self.tableView.tableFooterView = self.footTableView;
   
    


}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.scopeButton normalStyle];
    
    [self ShowBiddingCandidateButtonAction:nil]; //获取数据
    [self ShowDrawingResultButtonAction:nil];
    
}

//点击cell展开
-(void)clickDetailButtonAction:(id)sender{
    

    
    
}

/*
#pragma mark  UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
    
    if (section == 0) {
        if (self.BiddingCandidateArray.count== 0) {
            return 1;
        }
        return self.BiddingCandidateArray.count;
    }else{
        return self.DrawingResultArray.count;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameBidLabel.text = [[self.BiddingCandidateArray objectAtIndex:indexPath.row] objectForKey:@"暂无"];
            cell.biddingInterestLabel.text = [[self.BiddingCandidateArray objectAtIndex:indexPath.row] objectForKey:@"一一"];
            cell.biddingMoneyLabel.text = [[self.BiddingCandidateArray objectAtIndex:indexPath.row] objectForKey:@"一一"];
        }else{
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameBidLabel.text = [[self.BiddingCandidateArray objectAtIndex:indexPath.row] objectForKey:@"name"];
            cell.biddingInterestLabel.text = [[self.BiddingCandidateArray objectAtIndex:indexPath.row] objectForKey:@"biddingInterest"];
            cell.biddingMoneyLabel.text = [[self.BiddingCandidateArray objectAtIndex:indexPath.row] objectForKey:@"biddingMoney"];
        }
        
        
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
        int currentTag = indexPath.row - self.BiddingCandidateArray.count;
        cell.countLabel.text = [NSString stringWithFormat:@"第%d次",currentTag+1];
        cell.nameSelectLabel.text = [[self.DrawingResultArray objectAtIndex:currentTag] objectForKey:@"name"];
        NSString *scopeString = [[self.DrawingResultArray objectAtIndex:currentTag] objectForKey:@"scope"];
        
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.headTableView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return self.footTableView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 45;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 150;
    }
    return 0;
}
#pragma mark  UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}


*/



//竞标记录（获取抽签结果）：
-(void)ShowDrawingResultButtonAction:(id)sender{
    
    //
    NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
    [parameter setObject:self.cycleID forKey:@"cycle_id"];

    
    
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
            [self.tableView reloadData];
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    
    
    
    
}

//"name": "竞标人名字",
//"biddingMoney": "标金",
//"biddingInterest": "利息",
//"participantId": "竞标人id"

//竞标记录（获取竞标人）
-(void)ShowBiddingCandidateButtonAction:(id)sender{
    
    //
    NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
    [parameter setObject:self.cycleID forKey:@"cycle_id"];
    
    
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
            [self.tableView reloadData];
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    
    
    
    
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

@end
