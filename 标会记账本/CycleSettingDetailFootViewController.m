//
//  CycleSettingDetailFootViewController.m
//  标会记账本
//
//  Created by Siven on 15/11/14.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import "CycleSettingDetailFootViewController.h"
#import "CycleSettingTableViewCell.h"
#import "RecordJiaoHuiBidViewController.h"

@interface CycleSettingDetailFootViewController ()<UIAlertViewDelegate>{
    NSMutableArray *myEditArray;
}

@property (strong,nonatomic) NSMutableArray *myDataArray;
//@property (strong,nonatomic) NSArray *theStyleBid;//竞标方式
@property (strong,nonatomic) NSMutableArray *theEditCycle;//变动的

@end

@implementation CycleSettingDetailFootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.tabBarController.tabBar.hidden = YES;
    self.myDataArray =[[NSMutableArray alloc] init];
//    self.theEditCycle =[[NSMutableArray alloc] init];
    [self.saveFootBidButton normalStyle];
    
    self.hidesBottomBarWhenPushed = YES;
    //    self.navigationController.hidesBottomBarWhenPushed = YES;
    
    // Do any additional setup after loading the view from its nib.
    
    //    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0) {
    //        self.automaticallyAdjustsScrollViewInsets = NO;
    //    }
//    [self.addFootBidButton normalStyle];
//    [self.saveCycleBidButton normalStyle];
//    [self.saveFootBidButton normalStyle];

    self.title = @"周期设定";
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //        self.mytableView.tableHeaderView = self.myCycleView;
//        CGPoint centerPoint = self.saveCycleBidButton.center;
    
//        centerPoint.x = APPScreenBoundsWidth /2.0;
//        centerPoint.y = (APPScreenBoundsHeight-20) /2.0;
//        self.saveCycleBidButton.center = centerPoint;
//        
//        [self.saveCycleBidButton setFrame:CGRectMake((APPScreenBoundsWidth -150)/2.0, APPScreenBoundsHeight-80-64, 150, 40)];
//        [self.view addSubview:self.saveCycleBidButton];
//    NSLog(@"ddd:%f and%f",self.saveCycleBidButton.frame.origin.y,self.view.frame.size.height);
//    
        [self getShowCycleSettingData];
    
}
-(void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = YES;
//    [super viewWillAppear:YES];
//    NSLog(@"chose form :%d",_indexFrom);
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return self.saveCycleBidView;
    }
    
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
    
        self.myCycleHeadView.backgroundColor =[UIColor whiteColor];
        return  self.myCycleHeadView;

    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }
    return 0;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section ==0) {
//        UIView *footView =[[UIView alloc] init];
//        footView.backgroundColor = [UIColor clearColor];
//        footView.frame = CGRectMake(0, 0, kAppFrameWidth, 40);
//        return footView;
//    }
//    return nil;
//}
#pragma mark ----UITableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;  //在这里是几行
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return self.myDataArray.count;

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
        NSString  *timeString = [[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"time"];
        NSString *countString = [[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"count"];
        
        
        NSCalendar *localeCalendarChin = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
        NSDateComponents *localeComp = [localeCalendarChin components:unitFlags fromDate:[NSDate date]];
        NSLog(@"year:%zd month:%zd day:%zd",localeComp.year-1,localeComp.month-1,localeComp.day-1);
        
        NSCalendar *chinese_cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        [chinese_cal setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
        unsigned unitFlagsign = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
        NSDateComponents *comps = [chinese_cal components:unitFlagsign fromDate:[NSDate new]];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *china_now = [cal dateFromComponents:comps];
        NSLog(@"year:%zd month:%zd day:%zd",comps.year-1,comps.month-1,comps.day-1);
        
        
        if ([[self.myDetailBidData  objectForKey:@"calendarType"] isEqualToString:@"0"]) {

            [cell.timeButton setTitle:[NSString stringWithFormat:@"农历%@",timeString] forState:UIControlStateNormal];
            
        } else if ([[self.myDetailBidData  objectForKey:@"calendarType"] isEqualToString:@"1"]){
            
            [cell.timeButton setTitle:[NSString stringWithFormat:@"阳历%@",timeString] forState:UIControlStateNormal];
        }
        
        if ([countString isEqual:@"1"]) {
            cell.countLabel.text =@"会头钱";
        }else{
            cell.countLabel.text = [NSString stringWithFormat:@"第%@期",countString];
        }
        
        //会头
    
            [cell.timeButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];
            [cell.recordButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];
            [cell.recordButton setTitle:@"交会记录" forState:UIControlStateNormal];
            
            [cell.timeButton addTarget:self action:@selector(setTimeBidding:) forControlEvents:UIControlEventTouchUpInside];
            cell.timeButton.tag = indexPath.row;
            
            [cell.recordButton addTarget:self action:@selector(setRecordBidding:) forControlEvents:UIControlEventTouchUpInside];
            cell.recordButton.tag = indexPath.row;
            
    
        return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}

#pragma mark --------ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    NSLog(@"result string :%@ and%d",resultString,pickView.tagVaule);
    //    NSDate *localTime =[UserMessage getNowDateFromatAnDate:]

        int value = 0;
    
        NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:pickView.tagVaule inSection:0];
        CycleSettingTableViewCell *aCycleSettingCell =(CycleSettingTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
        
        NSDate *date =[UserMessage StringFormatToData:[resultString substringToIndex:10]];
        NSDate *stringDate = [UserMessage NextDateFromDate:date andmoth:value];
        NSString *timeString =[UserMessage DataFormatTwoToString:stringDate];
        NSString *dateBid =[NSString stringWithFormat:@"%@%@",[aCycleSettingCell.timeButton.titleLabel.text substringToIndex:2],[timeString substringToIndex:10]];
        [aCycleSettingCell.timeButton  setTitle:dateBid forState:UIControlStateNormal];
    
    //
    [[self.myDataArray objectAtIndex:pickView.tagVaule] setObject:[timeString substringToIndex:10] forKey:@"date"];
    //当修改新添加的日期时 还是type＝1
    if (![[[myEditArray objectAtIndex:pickView.tagVaule] objectForKey:@"type"] isEqualToString:@"1"]) {
        [[myEditArray objectAtIndex:pickView.tagVaule] setObject:@"0" forKey:@"type"];
    }
    [[myEditArray objectAtIndex:pickView.tagVaule] setObject:[timeString substringToIndex:10] forKey:@"date"];
    
    
        //存储变动的数组
        NSMutableDictionary *mutableDictionry =[[NSMutableDictionary alloc] init];
        NSString *cycleID =[NSString stringWithFormat:@"%ld",pickView.tagVaule+1];
        [mutableDictionry setObject:cycleID forKey:@"cycle_id"];
        [mutableDictionry setObject:[timeString substringToIndex:10] forKey:@"date"];
        [self.theEditCycle addObject:mutableDictionry];
        
        ++ value;
    
        //        }
        
        
    
}
#pragma mark - 确定
- (IBAction)saveCycleAciton:(id)sender {
    
    NSMutableArray *resultMutableArray =[[NSMutableArray alloc]  init];
    
    for (int x=0; x<myEditArray.count; x++) {
        NSMutableDictionary *aNewMutableDic =[[NSMutableDictionary alloc] init];
        if ([[[myEditArray objectAtIndex:x]objectForKey:@"type"] isEqualToString:@"0"]) {
            [aNewMutableDic setObject:[[myEditArray objectAtIndex:x]objectForKey:@"countid"] forKey:@"cycle_id"];
//            [aNewMutableDic setObject:[[myEditArray objectAtIndex:x]objectForKey:@"totalNumber"] forKey:@"total_number"];
            [aNewMutableDic setObject:[[myEditArray objectAtIndex:x]objectForKey:@"time"] forKey:@"date"];
            [aNewMutableDic setObject:@"0" forKey:@"type"];
            
        }else if ([[[myEditArray objectAtIndex:x]objectForKey:@"type"] isEqualToString:@"1"]) {
//            [aNewMutableDic setObject:[[myEditArray objectAtIndex:x]objectForKey:@"participantId"] forKey:@"participant_id"];
//            [aNewMutableDic setObject:[[myEditArray objectAtIndex:x]objectForKey:@"countid"] forKey:@"cycle_id"];
            [aNewMutableDic setObject:[[myEditArray objectAtIndex:x]objectForKey:@"count"] forKey:@"number"];
            [aNewMutableDic setObject:[[myEditArray objectAtIndex:x]objectForKey:@"time"] forKey:@"date"];
            [aNewMutableDic setObject:@"1" forKey:@"type"];
            
        }else if ([[[myEditArray objectAtIndex:x]objectForKey:@"type"] isEqualToString:@"2"]) {
            [aNewMutableDic setObject:[[myEditArray objectAtIndex:x]objectForKey:@"countid"] forKey:@"cycle_id"];
//            [aNewMutableDic setObject:[[myEditArray objectAtIndex:x]objectForKey:@"totalNumber"] forKey:@"total_number"];
            [aNewMutableDic setObject:[[myEditArray objectAtIndex:x]objectForKey:@"time"] forKey:@"date"];
            [aNewMutableDic setObject:@"2" forKey:@"type"];
            
        }
        
        [resultMutableArray addObject:aNewMutableDic];
        
    }
    
    
    //Json字符串
    NSData *parnciInfoDate =[NSJSONSerialization dataWithJSONObject:self.myCycleSettingData options:0 error:nil];
    NSString *InfoDatestring =[[NSString alloc]initWithData:parnciInfoDate encoding:NSUTF8StringEncoding];
    
    //Json字符串
    NSData *resultInfoDate =[NSJSONSerialization dataWithJSONObject:resultMutableArray options:0 error:nil];
    NSString *resultDatestring =[[NSString alloc]initWithData:resultInfoDate encoding:NSUTF8StringEncoding];
    
    [self getEditParticipantInfoDataWithFootBid:InfoDatestring AndCycleBid:resultDatestring];
    
    
}


#pragma mark - 开标日期
-(void)setTimeBidding:(id)sender{
//    UIButton *aButton = (UIButton *) sender;
//    
//    NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:aButton.tag inSection:0];
//    CycleSettingTableViewCell *aCycleSettingCell =(CycleSettingTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
//    NSString *defaulDateStr =[NSString stringWithFormat:@"%@",[aCycleSettingCell.timeButton.titleLabel.text substringFromIndex:2]];
//    //    [aCycleSettingCell.timeButton  setTitle:dateBid forState:UIControlStateNormal];
//    
//    
//    NSString *calType =[self.myDetailBidData objectForKey:@"calendarType"];
//    
//    //    NSString *calendarDate =[[self.myDataArray objectAtIndex:aButton.tag] objectForKey:@"time"];
//    NSDate *defaulDate =[UserMessage StringFormatToData:defaulDateStr];
//    
//    //    NSString *lastDateStr ;
//    NSDate *minDate =[[NSDate alloc] init];
//    if (aButton.tag ==0) {
//        minDate =nil;
//    } else {
//        //        lastDateStr =[[self.myDataArray objectAtIndex:aButton.tag-1] objectForKey:@"time"];
//        NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:aButton.tag-1 inSection:0];
//        CycleSettingTableViewCell *aCycleSettingCell =(CycleSettingTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
//        NSString *lastDateStr =[NSString stringWithFormat:@"%@",[aCycleSettingCell.timeButton.titleLabel.text substringFromIndex:2]];
//        
//        minDate =[UserMessage StringFormatToData:lastDateStr];
//    }
//    //    NSDate *maxDate =[UserMessage NextDateFromDate:date andYear:0 andMonth:1 andDay:1];
//    //    ZHPickView *_pickview =[ZHPickView alloc] init
//    ZHPickView *_pickview =[[ZHPickView alloc] initLimitStartDatePickWithStartDate:minDate andLargeDate:nil andDefaulDate:defaulDate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
//    [_pickview.segmentControl setEnabled:NO forSegmentAtIndex:![calType intValue]];
//    _pickview.tagVaule = aButton.tag;
//    _pickview.delegate=self;
//    [_pickview show];
    
    
    UIButton *aButton = (UIButton *) sender;
    
    NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:aButton.tag inSection:0];
    CycleSettingTableViewCell *aCycleSettingCell =(CycleSettingTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
    NSString *defaulDateStr =[NSString stringWithFormat:@"%@",[aCycleSettingCell.timeButton.titleLabel.text substringFromIndex:2]];
    //    [aCycleSettingCell.timeButton  setTitle:dateBid forState:UIControlStateNormal];
    
    
    NSString *calType =[self.myDetailBidData objectForKey:@"calendarType"];
    
    //    NSString *calendarDate =[[self.myDataArray objectAtIndex:aButton.tag] objectForKey:@"time"];
    NSDate *defaulDate =[UserMessage StringFormatToData:defaulDateStr];
    
    //    NSString *lastDateStr ;
    NSDate *minDate =[[NSDate alloc] init];
    if (aButton.tag ==0) {
        minDate =nil;
    } else {
        //        lastDateStr =[[self.myDataArray objectAtIndex:aButton.tag-1] objectForKey:@"time"];
        NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:aButton.tag-1 inSection:0];
        CycleSettingTableViewCell *aCycleSettingCell =(CycleSettingTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
        NSString *lastDateStr =[NSString stringWithFormat:@"%@",[aCycleSettingCell.timeButton.titleLabel.text substringFromIndex:2]];
        
        minDate =[UserMessage StringFormatToData:lastDateStr];
    }
    //    NSDate *maxDate =[UserMessage NextDateFromDate:date andYear:0 andMonth:1 andDay:1];
    //    ZHPickView *_pickview =[ZHPickView alloc] init
    ZHPickView *_pickview =[[ZHPickView alloc] initLimitStartDatePickWithStartDate:minDate andLargeDate:nil andDefaulDate:defaulDate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    [_pickview.segmentControl setEnabled:NO forSegmentAtIndex:![calType intValue]];
    _pickview.tagVaule = aButton.tag;
    _pickview.delegate=self;
    [_pickview show];
    
    
}
#pragma mark - 交会记录
-(void)setRecordBidding:(id)sender{
    UIButton *aSenderButton = (UIButton *) sender;
    
    RecordJiaoHuiBidViewController *aRecordVC =[[RecordJiaoHuiBidViewController alloc]init];
    aRecordVC.recordDictionary = [self.myDataArray objectAtIndex:aSenderButton.tag];
    [self.navigationController pushViewController:aRecordVC animated:YES];
    
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

#pragma mark --- 展示周期设定
-(void)getShowCycleSettingData {
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:[self.myDetailBidData objectForKey:@"gameId"] forKey:@"game_id"];
        //        [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone] forKey:@"phone_number"];
        NSLog(@"66666%@%@?game_id=%@",APPBaseURL,APPShowCycleSetting,[self.myDetailBidData objectForKey:@"gameId"]);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPShowCycleSetting] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
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
                self.myDataArray = [NSMutableArray arrayWithArray:json];
                
                myEditArray = [NSMutableArray arrayWithArray:json];
                NSString *timeStri =[[json lastObject] objectForKey:@"time"];
                int count =[[[json lastObject] objectForKey:@"count"] intValue]+1;
                
                //周期数的变化
                
                if (self.allCount>json.count) {
//                    [self.myDataArray addObjectsFromArray:json ];
                    int editValue = self.allCount - json.count;
                    int cycleCount =  json.count; //原来的期数
                    
                    for (int xx=0; xx < editValue; xx++) {
                        NSMutableDictionary *aDic =[[NSMutableDictionary alloc] init];
                        [aDic setObject:[NSString stringWithFormat:@"%ld",json.count+xx+1] forKey:@"count"];
                        
                        NSDate *date =[UserMessage StringFormatToData:timeStri];
                         NSString *nextDate = [UserMessage DataFormatToString:[UserMessage NextDateFromDate:date andmoth:xx+1]];
                        [aDic setObject:nextDate forKey:@"time"];
                        [aDic setObject:@"1" forKey:@"type"];
                        [self.myDataArray addObject:aDic];
                        
                        [myEditArray addObject:aDic]; //添加
                        
                    }
                    
                }else{
                    for (int yy =self.allCount; yy<json.count; yy++) {
                        [[myEditArray objectAtIndex:yy] setObject:@"2" forKey:@"type"]; //删除
                        
                    }
                   [self.myDataArray removeObjectsInRange:NSMakeRange(self.allCount, json.count-self.allCount)];
//                 [aDic setObject:@"1" forKey:@"type"]
                }
                
                 [self.mytableView reloadData];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
}


#pragma mark --- 保存周期设定
-(void)SaveEditCycleSetting:(NSArray *)cycleInfo {
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        //
        NSData *InfoDate =[NSJSONSerialization dataWithJSONObject:cycleInfo options:0 error:nil];
        NSString *InfoDatestring =[[NSString alloc]initWithData:InfoDate encoding:NSUTF8StringEncoding];
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:InfoDatestring forKey:@"cycle_info"];
        //        [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone] forKey:@"phone_number"];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPEditCycleSetting] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([resuldId isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 114)  {
                    ALERTView(@"输入的编辑参数不合法");
                }else  if (statusValue ==0)  {
                    ALERTView(@"编辑成功");
                }else  if (statusValue ==214)  {
                    ALERTView(@"编辑失败");
                }
                
                
            }
            //            else if([resuldId isKindOfClass:[NSArray class]]){
            //                NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //                self.myDataArray = json;
            //                [self.mytableView reloadData];
            //
            //            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
}



#pragma mark --- 编辑会脚详情信息（同时还可能会编辑周期设定信息）
-(void)getEditParticipantInfoDataWithFootBid:(NSString *)footBidDate AndCycleBid:(NSString *)cycleBidDate {
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
//        "baselineMoney": "会头钱",
//        "calendarType": "历法类型",(0代表农历，1代表公历)
//        "firstDate": "首期日期",（格式：2015-07-08，涉及到日期的都是一样）
//        "gameId": "会子id",
//        "cycleNumer": "周期数量",
//        "participantNumber": "会脚数量",
//        "biddingMethod": "竞标方式",(0代表内标1，1代表内标2，2代表内标3，3代表外标)
//        "topLineInterest": "顶标利息",
//        "bottomLineInterest": "底标利息",
//        "startTime": "开标时间",（格式：20:10:00）
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:[self.myDetailBidData objectForKey:@"gameId"] forKey:@"game_id"];
        [parameter setObject:[self.myDetailBidData objectForKey:@"participantId"] forKey:@"creator_id"];
        [parameter setObject:[self.myDetailBidData objectForKey:@"baselineMoney"] forKey:@"baseline_money"];
        [parameter setObject:[self.myDetailBidData objectForKey:@"biddingMethod"] forKey:@"bidding_method"];
        [parameter setObject:footBidDate forKey:@"participant_info"];
        [parameter setObject:cycleBidDate forKey:@"cycle_info"];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPEditParticipantInfo] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([resuldId isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 0)  {
                    UIAlertView *sucess =[[UIAlertView alloc] initWithTitle:@"编辑成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    sucess.tag = 10008;
                    [sucess show];
                    
                }else  if (statusValue ==216)  {
                 ALERTView(@"编辑失败");
                }else  if (statusValue ==105)  {
                    ALERTView(@"输入会子id不合法");
                }else  if (statusValue ==116)  {
                    ALERTView(@"输入会头钱不合法");
                }else  if (statusValue ==107)  {
                    ALERTView(@"输入会头id不合法");
                }else  if (statusValue ==117)  {
                    ALERTView(@"输入竞标方式不合法");
                }else  if (statusValue ==123)  {
                    ALERTView(@"输入会脚列表不合法");
                }else  if (statusValue ==124)  {
                    ALERTView(@"输入周期列表不合法");
                }
                
                
            } else if([resuldId isKindOfClass:[NSArray class]]){
                NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                self.myDataArray = json;
                [self.mytableView reloadData];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10008) {
        if (buttonIndex ==0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

@end