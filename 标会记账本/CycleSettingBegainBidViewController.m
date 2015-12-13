//
//  CycleSettingBegainBidViewController.m
//  标会记账本
//
//  Created by Siven on 15/10/8.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "CycleSettingBegainBidViewController.h"
#import "CycleSettingTableViewCell.h"

@interface CycleSettingBegainBidViewController ()<ZHPickViewDelegate>

@property (nonatomic, strong)  NSMutableArray *myCycleSettingArray;

@end

@implementation CycleSettingBegainBidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myCycleSettingArray = [[ NSMutableArray alloc] init];
    
     self.mytableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.title = @"周期设定";
   
    [self.saveCycleBidButton normalStyle];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    for (int y = 0; y < self.allCount; y ++) {
        
        NSString *calType =  [[UserMessage sharedUserMessage].BegainHeaderBidDic objectForKey:@"calendar_type"];
        NSString *calendarDate =  [[UserMessage sharedUserMessage].BegainHeaderBidDic objectForKey:@"first_date"];
        NSDate *date =[UserMessage StringFormatToData:calendarDate];
        NSString *stringDate = [UserMessage DataFormatToString:[UserMessage NextDateFromDate:date andmoth:y]];
        
        if ([calType isEqualToString:@"0"]) {

            [self.myCycleSettingArray addObject:[NSString stringWithFormat:@"农历%@",stringDate]];
        } else if ([calType isEqualToString:@"1"]){

             [self.myCycleSettingArray addObject:[NSString stringWithFormat:@"阳历%@",stringDate]];
        }
    }
    

}
#pragma mark ----UITableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;  //在这里是几行
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.saveFootBidButton;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        
            UIView *aView =[[UIView alloc] init];
            aView.backgroundColor =[UIColor clearColor];
            return aView;
        
        
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 35;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allCount;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *OneIdentifier = @"OneIdentifier";
    
   
        CycleSettingTableViewCell *cell = (CycleSettingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:OneIdentifier];
        
        if (cell == nil) {
            NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"CycleSettingTableViewCell" owner:self options:nil];
            
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[CycleSettingTableViewCell class]]) {
                    cell = (CycleSettingTableViewCell *)oneObject;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
    
    [cell.timeButton setTitle:[self.myCycleSettingArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];

    
        if (indexPath.row == 0) {
            
            cell.countLabel.text =@"会头钱";
            
        }else{
            
            cell.countLabel.text = [NSString stringWithFormat:@"第%d期",indexPath.row+1];
            [cell.timeButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];

            [cell.timeButton addTarget:self action:@selector(setTimeBiddingButton:) forControlEvents:UIControlEventTouchUpInside];
            cell.timeButton.tag = indexPath.row;
        }
        

        return cell;
        
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"section %d and row:%d",indexPath.section,indexPath.row);
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}



#pragma mark - 开标时间
-(void)setTimeBiddingButton:(id)sender{
    UIButton *aTimeButton =(UIButton *)sender;
    
    NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:aTimeButton.tag inSection:0];
    CycleSettingTableViewCell *aCycleSettingCell =(CycleSettingTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
    NSString *calendarDate =[NSString stringWithFormat:@"%@",[aCycleSettingCell.timeButton.titleLabel.text substringFromIndex:2]];
    
    NSString *calType =  [[UserMessage sharedUserMessage].BegainHeaderBidDic objectForKey:@"calendar_type"];
//    NSString *calendarDate =  [[UserMessage sharedUserMessage].BegainHeaderBidDic objectForKey:@"first_date"];
    NSDate *dateSelect =[UserMessage StringFormatToData:calendarDate];
//    NSDate *stringDate = [UserMessage NextDateFromDate:date andmoth:aTimeButton.tag];
    NSDate *stringDate = [UserMessage NextDateFromDate:dateSelect andmoth:0];
    
    
    ///时间上限
    NSIndexPath *indexPathcellTwo =[NSIndexPath indexPathForRow:aTimeButton.tag-1 inSection:0];
    CycleSettingTableViewCell *aCycleSettingCellTwo =(CycleSettingTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcellTwo];
    NSString *lastDateStr =[NSString stringWithFormat:@"%@",[aCycleSettingCellTwo.timeButton.titleLabel.text substringFromIndex:2]];
    
    NSDate *minLimitDate =[UserMessage StringFormatToData:lastDateStr];
    
    ZHPickView *_pickview =[[ZHPickView alloc] initLimitStartDatePickWithStartDate:minLimitDate andLargeDate:nil andDefaulDate:stringDate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    
//    ZHPickView *_pickview  =[[ZHPickView alloc] initDatePickWithStartDate:stringDate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    _pickview.tagVaule = aTimeButton.tag;
    _pickview.delegate=self;
//  _pickview setma
    if ([calType isEqualToString:@"0"]) {
        [_pickview.segmentControl setEnabled:NO forSegmentAtIndex:1];
        _pickview.segmentControl.selectedSegmentIndex = 0;
    } else if ([calType isEqualToString:@"1"]){
        [_pickview.segmentControl setEnabled:NO forSegmentAtIndex:0];
        _pickview.segmentControl.selectedSegmentIndex = 1;
    }
    [_pickview show];
        
}

#pragma mark --------ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    NSLog(@"bid begain result string :%@ and%d",resultString,pickView.tagVaule);
    
    NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:pickView.tagVaule inSection:0];
    CycleSettingTableViewCell *aDetailBidVCell =(CycleSettingTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
    

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *destDate= [dateFormatter dateFromString:resultString];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss Z"];
    NSString *resultDateString =[dateFormat stringFromDate:destDate];
    
    
    
    if (pickView.segmentControl.selectedSegmentIndex == 0) {
//        NSString
        [aDetailBidVCell.timeButton setTitle:[NSString stringWithFormat:@"农历%@",[resultDateString substringToIndex:10]] forState:UIControlStateNormal];
        [self.myCycleSettingArray replaceObjectAtIndex:indexPathcell.row withObject:[NSString stringWithFormat:@"农历%@",[resultDateString substringToIndex:10]]];
    }else {
        [aDetailBidVCell.timeButton setTitle:[NSString stringWithFormat:@"阳历%@",[resultDateString substringToIndex:10]] forState:UIControlStateNormal];
        [self.myCycleSettingArray replaceObjectAtIndex:indexPathcell.row withObject:[NSString stringWithFormat:@"阳历%@",[resultDateString substringToIndex:10]]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)startBidGameAction:(id)sender {
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"加载...";
    
    
    
    NSMutableArray *cycleListArray =[[NSMutableArray alloc]init];
    for (int y =0; y<self.allCount; y++) {
        
        NSString *countString =[NSString stringWithFormat:@"%d",y+1];
        NSString *timeString =[[self.myCycleSettingArray objectAtIndex:y] substringFromIndex:2];
        
        NSMutableDictionary *aCycleDic =[[NSMutableDictionary alloc]initWithObjectsAndKeys:countString,@"count",timeString ,@"time", nil];
        [cycleListArray addObject:aCycleDic];
        
    }
    NSData *cycleDate =[NSJSONSerialization dataWithJSONObject:cycleListArray options:0 error:nil];
    NSString *cyclestring =[[NSString alloc]initWithData:cycleDate encoding:NSUTF8StringEncoding];
    
    //participant list
    NSData *participantDate =[NSJSONSerialization dataWithJSONObject:[UserMessage sharedUserMessage].BegainHeaderBidFootDetail options:0 error:nil];
    NSString *participantstring =[[NSString alloc]initWithData:participantDate encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *participantCycle =[[NSMutableDictionary alloc]initWithObjectsAndKeys:cyclestring,@"cycle_list", participantstring,@"participant_list",nil];
    
    NSMutableDictionary *gameInfoDic =[[NSMutableDictionary alloc] initWithDictionary:[UserMessage sharedUserMessage].BegainHeaderBidDic];
    [gameInfoDic addEntriesFromDictionary:participantCycle];
    //Json字符串
    NSData *gameInfoDate =[NSJSONSerialization dataWithJSONObject:gameInfoDic options:0 error:nil];
    NSString *gameInfoDatestring =[[NSString alloc]initWithData:gameInfoDate encoding:NSUTF8StringEncoding];
    
    
    
   
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:gameInfoDatestring forKey:@"game_info"];

        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        NSLog(@"base url :%@",[APPBaseURL stringByAppendingString:APPCreateGame]);
        [manager POST:[APPBaseURL stringByAppendingString:APPCreateGame] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {

            id json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([json isKindOfClass:[NSArray class]]) {
                
            }else if ([json isKindOfClass:[NSDictionary class]]){
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 0) {
                    
                    UIAlertView *aAlertView =[[UIAlertView alloc] initWithTitle:@"起会成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [aAlertView show];
                    
                }else if (statusValue == 215)  {
                    ALERTView(@"起会失败");
                }else if (statusValue == 100)  {
                    ALERTView(@"会头手机号不合法");
                }else if (statusValue ==115)  {
                    ALERTView(@"输入会头姓名不合法");
                }else if (statusValue ==116)  {
                    ALERTView(@"输入会头钱不合法");
                }else  if (statusValue ==117)  {
                    ALERTView(@"输入竞标方式不合法");
                }else if (statusValue ==118)  {
                    ALERTView(@"输入顶标利息不合法");
                }else if (statusValue == 119)  {
                    ALERTView(@"输入底标利息不合法");
                }else  if (statusValue ==120)  {
                    ALERTView(@"输入首期日期不合法");
                }else if (statusValue ==121)  {
                    ALERTView(@"输入开标时间不合法");
                }else if (statusValue ==122)  {
                    ALERTView(@"输入历法类型不合法");
                }else  if (statusValue ==123)  {
                    ALERTView(@"输入会脚列表不合法");
                }else if (statusValue ==124)  {
                    ALERTView(@"输入周期列表不合法");
                }else if (statusValue ==125)  {
                    ALERTView(@"输入会脚可见不合法");
                }

                
            }
            
           
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"error");
        }];
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
