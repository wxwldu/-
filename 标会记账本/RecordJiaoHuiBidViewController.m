//
//  RecordFootBidViewController.m
//  标会记账本
//
//  Created by Siven on 15/10/7.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "RecordJiaoHuiBidViewController.h"
#import "RecordJiaoHuiBidCell.h"

@interface RecordJiaoHuiBidViewController ()
@property (strong,nonatomic) NSMutableArray *myDataArray;
@property (strong,nonatomic) NSMutableArray *myEditPaymentArray; //编辑交会记录
@end

@implementation RecordJiaoHuiBidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交会记录";
    // Do any additional setup after loading the view from its nib.
    self.myDataArray =[[NSMutableArray alloc] init];
    self.myEditPaymentArray =[[NSMutableArray alloc] init];
    self.myTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    [self.mySaveButton normalStyle];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getShowPaymentPerCycleData];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.myRecodTableHeadView;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    //如果cell打开，则多显示一个cell
//    if (_indexChoosen ==2) {
//        return  self.theStyleBid.count;
//    }else{
//        return self.myDataArray.count;
//    }
//    return 0;
    
    return self.myDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"Identifier";
    
        RecordJiaoHuiBidCell *cell = (RecordJiaoHuiBidCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"RecordJiaoHuiBidCell" owner:self options:nil];
            
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[RecordJiaoHuiBidCell class]]) {
                    cell = (RecordJiaoHuiBidCell *)oneObject;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
    
    cell.mynameLabel.text =[[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.bidCountLabel.text = [[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"bidCount"];
    cell.moneyLabel.text= [[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"money"];
   
//    cell.dealOrNotButton.selected = [[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"dealOrNot"]; //0未交 1交了
    NSLog(@"select :%@",[[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"dealOrNot"]);
    
    if ([[[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"dealOrNot"] isEqualToString:@"1"]) {
        [cell.myImageView setImage:[UIImage imageNamed:@"tick.png"]];
        cell.dealOrNotButton.selected= YES;
        
    }else{
        
        [cell.myImageView setImage:[UIImage imageNamed:@"white.png"]];
        cell.dealOrNotButton.selected = NO;
    }
    
    [cell.dealOrNotButton addTarget:self action:@selector(selectDealOrNot:) forControlEvents:UIControlEventTouchUpInside];
    cell.dealOrNotButton.tag = indexPath.row;
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section %d and row:%d",indexPath.section,indexPath.row);
//    if (_indexChoosen == 2) {
//        
//        if (self.CycleSettingVCCellButtonDelegate && [self.CycleSettingVCCellButtonDelegate respondsToSelector:@selector(clickCycleSettingCellMethod:)]) {
//            [self.CycleSettingVCCellButtonDelegate clickCycleSettingCellMethod:indexPath.row];
//            //0:往下标1  1:往下标2  2:往下标3  3:往下标
//            
//        }
//        
//        [UserMessage sharedUserMessage].modeBidding = self.theStyleBid[indexPath.row][0];
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
    
    //    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    //    IncomeAnalysisViewController *aIncomeVC =[[IncomeAnalysisViewController alloc]init];
    //    [self.navigationController pushViewController:aIncomeVC animated:YES];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if(_indexChoosen == 2){
//        return 100;
//    }else {
//        return 40;
//    }
//    return 0;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)selectDealOrNot:(id)sender{
    UIButton *aButton = (UIButton *) sender;
    
    NSIndexPath *indexPathTag =[NSIndexPath indexPathForRow:aButton.tag inSection:0];
    RecordJiaoHuiBidCell *recordBidCell =(RecordJiaoHuiBidCell *)[self.myTableView cellForRowAtIndexPath:indexPathTag];
    
    if (aButton.selected) {
        aButton.selected = NO;
        [recordBidCell.myImageView setImage:[UIImage imageNamed:@"white.png"]];
    } else {
        aButton.selected = YES;
        [recordBidCell.myImageView setImage:[UIImage imageNamed:@"tick.png"]];
    }
    
    

    
//    if ([[[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"dealOrNot"] isEqualToString:@"1"]) {
//        [cell.myImageView setImage:[UIImage imageNamed:@"tick.png"]];
//        cell.dealOrNotButton.selected= YES;
//        
//    }else{
//        
//        [cell.myImageView setImage:[UIImage imageNamed:@"white.png"]];
    
        
    
//    NSLog(@"%@",aButton.selected);
    
    NSLog(@"3333%d",((UIButton *)sender).tag);
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==10003) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)saveRecordAction:(id)sender {
    
    //交会记录
    for (int x=0; x<self.myDataArray.count; x++) {
        NSIndexPath *indexPathTag =[NSIndexPath indexPathForRow:x inSection:0];
        RecordJiaoHuiBidCell *recordBidCell =(RecordJiaoHuiBidCell *)[self.myTableView cellForRowAtIndexPath:indexPathTag];
        int dealTag =[[[self.myDataArray objectAtIndex:x] objectForKey:@"dealOrNot"] intValue];
        if (recordBidCell.dealOrNotButton.selected !=dealTag) {
            
            NSMutableDictionary *editDic =[[NSMutableDictionary alloc] init];
            [editDic setObject:[[self.myDataArray objectAtIndex:x] objectForKey:@"participantId"] forKey:@"participantId"];
            [editDic setObject:[self.recordDictionary objectForKey:@"countid"] forKey:@"cycleId"];
            [editDic setObject:[NSString stringWithFormat:@"%d",!dealTag] forKey:@"dealOrNot"];
            
            [self.myEditPaymentArray addObject:editDic];
        }
    }
    //Json字符串
    NSData *InfoDate =[NSJSONSerialization dataWithJSONObject:self.myEditPaymentArray options:0 error:nil];
    NSString *gameInfoDatestring =[[NSString alloc]initWithData:InfoDate encoding:NSUTF8StringEncoding];

    
    
    [self getEditPaymentPerCycle:gameInfoDatestring];
}

//展示交会记录信息
-(void)getShowPaymentPerCycleData {
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:[self.recordDictionary objectForKey:@"countid"] forKey:@"cycle_id"];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPShowPaymentPerCycle] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
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
                self.myDataArray = json;
                [self.myTableView reloadData];
                
                
                if (self.myDataArray.count == 0) {
                    self.myNoneLabel.hidden = NO;
                    
                }else{
                    self.myNoneLabel.hidden = YES;
                }
                
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
}


//交会记录信息
-(void)getEditPaymentPerCycle:(NSString *)editString{
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
    
        
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:editString forKey:@"payment_info"];
        
        

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPEditPaymentPerCycle] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([resuldId isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 113)  {
                    ALERTView(@"输入的编辑参数不合法");
                }else  if (statusValue ==0)  {
//                 ALERTView(@"编辑成功");
                    UIAlertView *aSuccessAlertView =[[UIAlertView alloc] initWithTitle:@"编辑成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    aSuccessAlertView.tag = 10003;
                    [aSuccessAlertView show];
                    
                }else  if (statusValue ==203)  {
                    ALERTView(@"编辑失败");
                }
                
                
                
            }
//            else if([resuldId isKindOfClass:[NSArray class]]){
//                NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                self.myDataArray = json;
//                [self.myTableView reloadData];
//                
//                
//                if (self.myDataArray.count == 0) {
//                    self.myNoneLabel.hidden = NO;
//                    
//                }else{
//                    self.myNoneLabel.hidden = YES;
//                }
//                
            
//            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
}



@end
