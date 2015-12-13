//
//  CycleSettingViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/26.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "CycleSettingViewController.h"
#import "CycleSettingTableViewCell.h"
#import "DetailBidFootTableViewCell.h"
#import "MainFootBidViewController.h"
#import "UserMessage.h"
#import "RecordJiaoHuiBidViewController.h"
#import "InviteContactsViewController.h"

#import "TKContactsMultiPickerController.h"
#import "CycleSettingDetailFootViewController.h"

@interface CycleSettingViewController ()<PassValueDelegate,ZHPickViewDelegate,ViewPassValueDelegate,UIAlertViewDelegate,TKContactsMultiPickerControllerDelegate>{
    UIDatePicker *oneDatePicker;
//    NSMutableArray *aNewData;//含有删除的会脚的数组
}

@property (strong,nonatomic) NSMutableArray *myDataArray;
@property (strong,nonatomic) NSArray *theStyleBid;//竞标方式
@property (strong,nonatomic) NSMutableArray *theEditCycle;//变动的 -整理删除

@property (strong,nonatomic) NSMutableArray *aNewData;//含有删除的会脚的数组
@end

@implementation CycleSettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBarController.tabBar.hidden = YES;
    self.myDataArray =[[NSMutableArray alloc] init];
    self.theEditCycle =[[NSMutableArray alloc] init];
    self.aNewData =[[NSMutableArray alloc] init];
    
    
    self.theStyleBid = @[@[@"往下标1",@"竞标标金小于会头钱,会头每期按死会金额交会     例如:会头钱1000元,会头每期按1000元交会"],@[@"往下标2",@"竞标标金小于会头钱,会头钱最后一期还款   例如:会头第一期收完会头钱等到最后一期过会给最后一个会脚"],@[@"往下标3",@"竞标标金小于会头钱,会头每期按活会交会   例如:会头钱1000元,本期利息200元标金则为800元会头本期按800元交会"],@[@"往上标",@"竞标标金大于会头钱，会头每期按活会金额交会例如:会头钱1000元,会头每期按1000元交会"]];
    self.hidesBottomBarWhenPushed = YES;
//    self.navigationController.hidesBottomBarWhenPushed = YES;
    
    // Do any additional setup after loading the view from its nib.

//    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    [self.addFootBidButton normalStyle];
    [self.saveCycleBidButton normalStyle];
    [self.saveFootBidButton normalStyle];
    
    
    if (_indexChoosen == 0) {
        self.title = @"周期设定";
        self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        self.mytableView.tableHeaderView = self.myCycleView;
        if (_indexFrom == 1) {
            CGPoint centerPoint = self.saveCycleBidButton.center;
            
            centerPoint.x = APPScreenBoundsWidth /2.0;
            centerPoint.y = (APPScreenBoundsHeight-20) /2.0;
            self.saveCycleBidButton.center = centerPoint;
            
            [self.saveCycleBidButton setFrame:CGRectMake((APPScreenBoundsWidth -150)/2.0, APPScreenBoundsHeight-40, 150, 40)];
            [self.view addSubview:self.saveCycleBidButton];
        }
        
        
        [self getShowCycleSettingData];
        
    } else if (_indexChoosen == 1){
        self.title = @"会脚详情";
        self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.mytableView.tableHeaderView = self.myFootBidView;
        [self getShowParticipantInfoData];
        if (_indexFrom == 1) {
            CGPoint centerPoint = self.FootBidTableFootView.center;
            
            centerPoint.x = APPScreenBoundsWidth /2.0;
            centerPoint.y = (APPScreenBoundsHeight-20) /2.0;
            self.FootBidTableFootView.center = centerPoint;
            
            [self.FootBidTableFootView setFrame:CGRectMake(0, APPScreenBoundsHeight-40, APPScreenBoundsWidth, 40)];
            [self.view addSubview:self.FootBidTableFootView];
//            self.FootBidTableFootView.backgroundColor =[UIColor grayColor];
        }
        
        
    } else if (_indexChoosen == 2){
        self.title = @"竞标方式";
        self.mytableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        //        self.mytableView.tableHeaderView = nil;
    }

    
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [super viewWillAppear:YES];
    NSLog(@"chose form :%d",_indexFrom);
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (_indexChoosen == 0) {
            return 35;
        }else if (_indexChoosen == 1){
            return 82;
        }
        
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_indexFrom == 1) {
        if (section == 0) {
            if (_indexChoosen == 0) {
                return 50;
            }else if (_indexChoosen == 1){
                return 50;
            }
        }
    }
    
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        if (_indexChoosen == 0) {
            self.title = @"周期设定";
            return  self.myCycleView;
        } else if (_indexChoosen == 1){
            self.title = @"会脚详情";
            return  self.myFootBidView;
        } else if (_indexChoosen == 2){
            self.title = @"竞标方式";
            
            return  nil;
        }
    }
    
    
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (_indexFrom == 1) {
//            if (_indexChoosen == 1) {
//                return self.FootBidTableFootView;
//            }else if(_indexChoosen ==0){
//                return self.saveCycleBidButton;
//            }
            UIView *aView =[[UIView alloc] init];
            aView.backgroundColor =[UIColor clearColor];
            return aView;
        }
        
    }
    
    return nil;
}


#pragma mark  周期设定 －－确认 点击
- (IBAction)myCycleSaveAction:(id)sender {
    //需要添加点击事件
    [self SaveEditCycleSetting:self.theEditCycle];
    
    
    if (_indexChoosen == 0) {
        for (int y =0; y<self.myDataArray.count; y++) {
            
//            NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:y inSection:0];
//            CycleSettingTableViewCell *aCycleSettingCell =(CycleSettingTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
//            NSString *dateBid =[NSString stringWithFormat:@"%@%@",[aCycleSettingCell.timeButton.titleLabel.text substringToIndex:2],[resultString substringToIndex:10]];
//            [aCycleSettingCell.timeButton  setTitle:dateBid forState:UIControlStateNormal];
            
        }
        
        
    }else if (_indexChoosen == 0){
        
//        NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:pickView.tagVaule inSection:0];
//        DetailBidFootTableViewCell *aDetailBidVCell =(DetailBidFootTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
//        [aDetailBidVCell.allCountBidButton setTitle:resultString forState:UIControlStateNormal];
    }

}


#pragma mark ---会脚详情 －－添加会脚
- (IBAction)myAddFootBidAction:(id)sender {
    
//    InviteContactsViewController *aInviteContactsVC =[[InviteContactsViewController alloc] init];
//    aInviteContactsVC.ViewPassValueDelegate = self;
//    aInviteContactsVC.inviteType = 2;
//    aInviteContactsVC.hidesBottomBarWhenPushed = YES;
//    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:aInviteContactsVC];
//    navController.navigationBar.backgroundColor =MBPGreenColor;
//    [self presentViewController:aInviteContactsVC animated:YES completion:nil];
//    [self.navigationController pushViewController:aInviteContactsVC animated:YES];
    
    TKContactsMultiPickerController *aTKContactsVC =[[TKContactsMultiPickerController alloc] initWithGroup:nil];
    aTKContactsVC.inviteType = 2;
    aTKContactsVC.delegate = self;
    [self.navigationController pushViewController:aTKContactsVC animated:YES];
}
#pragma mark ---会脚详情 －－确认 点击
- (IBAction)mySaveFootBidAction:(id)sender {
    NSMutableArray *resultMutableArray =[[NSMutableArray alloc]  init];
    NSMutableArray *ddd =[NSMutableArray arrayWithArray:self.aNewData];
    
    
    for (int x=0; x<_aNewData.count; x++) {
        NSMutableDictionary *aNewMutableDic =[[NSMutableDictionary alloc] init];
        if ([[[_aNewData objectAtIndex:x]objectForKey:@"type"] isEqualToString:@"0"]) {
            [aNewMutableDic setObject:[[_aNewData objectAtIndex:x]objectForKey:@"participantId"] forKey:@"participant_id"];
            [aNewMutableDic setObject:[[_aNewData objectAtIndex:x]objectForKey:@"totalNumber"] forKey:@"total_number"];
            [aNewMutableDic setObject:[[_aNewData objectAtIndex:x]objectForKey:@"usedNumber"] forKey:@"used_number"];
            [aNewMutableDic setObject:@"0" forKey:@"type"];
            
            [resultMutableArray addObject:aNewMutableDic];
        }else if ([[[_aNewData objectAtIndex:x]objectForKey:@"type"] isEqualToString:@"1"]) {
            [aNewMutableDic setObject:[[_aNewData objectAtIndex:x]objectForKey:@"phoneNumber"] forKey:@"phone_number"];
            [aNewMutableDic setObject:[[_aNewData objectAtIndex:x]objectForKey:@"totalNumber"] forKey:@"total_number"];
            [aNewMutableDic setObject:[[_aNewData objectAtIndex:x]objectForKey:@"usedNumber"] forKey:@"used_number"];
            [aNewMutableDic setObject:[[_aNewData objectAtIndex:x]objectForKey:@"name"] forKey:@"name"];
            [aNewMutableDic setObject:@"1" forKey:@"type"];
            
            [resultMutableArray addObject:aNewMutableDic];
        }else if ([[[_aNewData objectAtIndex:x]objectForKey:@"type"] isEqualToString:@"2"]) {
            [aNewMutableDic setObject:[[_aNewData objectAtIndex:x]objectForKey:@"participantId"] forKey:@"participant_id"];
            [aNewMutableDic setObject:[[_aNewData objectAtIndex:x]objectForKey:@"totalNumber"] forKey:@"total_number"];
            [aNewMutableDic setObject:[[_aNewData objectAtIndex:x]objectForKey:@"usedNumber"] forKey:@"used_number"];
            [aNewMutableDic setObject:@"2" forKey:@"type"];
            
            [resultMutableArray addObject:aNewMutableDic];
        }
        
        
        
    }
    
    int allAccount =0;
    for (int x=0; x<self.myDataArray.count; x++) {
        int countValue =[[[self.myDataArray objectAtIndex:x] objectForKey:@"totalNumber"] intValue];
        allAccount +=countValue;
    }
    
    CycleSettingDetailFootViewController *aCycleBegainBidVC =[[CycleSettingDetailFootViewController alloc] init];
    aCycleBegainBidVC.allCount  = allAccount;
    aCycleBegainBidVC.myCycleSettingData = resultMutableArray;
    aCycleBegainBidVC.myDetailBidData = self.myBidDetailData;
    
    [self.navigationController pushViewController:aCycleBegainBidVC animated:YES];
    
//    [self.navigationController pushViewController:self animated:YES];

}


#pragma mark ----ViewPassValueDelegate  添加会脚传值
-(void)passValueContacts:(NSArray *)valueArray{
    //邀请的会脚
    for (TKAddressBook *aTK in valueArray) {
        
        NSMutableDictionary  *aFootDic =[[NSMutableDictionary alloc] init];
//        NSLog(@"$%@",aTK.name);
        [aFootDic setObject:aTK.name forKey:@"name"];
        [aFootDic setObject:aTK.telephone forKey:@"phoneNumber"];
        [aFootDic setObject:@"1" forKey:@"totalNumber"];
        [aFootDic setObject:@"0" forKey:@"usedNumber"];
        [aFootDic setObject:@"1" forKey:@"type"];

//        [_aNewData addObject:aFootDic]; //
        [self.myDataArray addObject:aFootDic];
        
    }
    
    [self.mytableView reloadData];
}

- (void)tkContactsMultiPickerController:(TKContactsMultiPickerController*)picker didFinishPickingDataWithInfo:(NSArray*)contacts{
    
    //邀请的会脚
    for (TKContact *aTK in contacts) {
        
        NSMutableDictionary  *aFootDic =[[NSMutableDictionary alloc] init];
        //        NSLog(@"$%@",aTK.name);
        [aFootDic setObject:aTK.name forKey:@"name"];
        [aFootDic setObject:aTK.tempPhone forKey:@"phoneNumber"];
        [aFootDic setObject:@"1" forKey:@"totalNumber"];
        [aFootDic setObject:@"0" forKey:@"usedNumber"];
        [aFootDic setObject:@"1" forKey:@"type"];
        
                [_aNewData addObject:aFootDic]; //
        [self.myDataArray addObject:aFootDic];
        
    }
    
    [self.mytableView reloadData];
    
    
}


#pragma mark ----UITableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;  //在这里是几行
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //如果cell打开，则多显示一个cell
    if (_indexChoosen ==2) {
        return  self.theStyleBid.count;
    }else{
        return self.myDataArray.count;
    }
    return 0;
}
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *OneIdentifier = @"OneIdentifier";
    static NSString *TwoIdentifier = @"TwoIdentifier";
    
    if (_indexChoosen == 0) {
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

        
        if ([[self.myBidDetailData  objectForKey:@"calendarType"] isEqualToString:@"0"]) {
//            if ([[UserMessage StringFormatToData:timeString] timeIntervalSinceDate:[NSDate date]] <0) {
//                [cell.timeButton setEnabled:NO];
//                [cell.timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            }
            [cell.timeButton setTitle:[NSString stringWithFormat:@"农历%@",timeString] forState:UIControlStateNormal];
            
        } else if ([[self.myBidDetailData  objectForKey:@"calendarType"] isEqualToString:@"1"]){
            
//            if ([[UserMessage StringFormatToData:timeString] timeIntervalSinceDate:[NSDate date]] <0) {
//                [cell.timeButton setEnabled:NO];
//                [cell.timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            }
            [cell.timeButton setTitle:[NSString stringWithFormat:@"阳历%@",timeString] forState:UIControlStateNormal];
        }
        
        if ([countString isEqual:@"1"]) {
            cell.countLabel.text =@"会头钱";
        }else{
            
            cell.countLabel.text = [NSString stringWithFormat:@"第%@期",countString];
        }
        
        
        //会头
        if (_indexFrom == 1) {
            [cell.timeButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];
            [cell.recordButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];
            [cell.recordButton setTitle:@"交会记录" forState:UIControlStateNormal];
            
            [cell.timeButton addTarget:self action:@selector(setTimeBidding:) forControlEvents:UIControlEventTouchUpInside];
            cell.timeButton.tag = indexPath.row;
            
            [cell.recordButton addTarget:self action:@selector(setRecordBidding:) forControlEvents:UIControlEventTouchUpInside];
            cell.recordButton.tag = indexPath.row;
            
         }

        return cell;
        
    }else if(_indexChoosen == 1){
        DetailBidFootTableViewCell *cell = (DetailBidFootTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TwoIdentifier];
        
        if (cell == nil) {
            NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"DetailBidFootTableViewCell" owner:self options:nil];
            
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[DetailBidFootTableViewCell class]]) {
                    cell = (DetailBidFootTableViewCell *)oneObject;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
//        myDataArray
        cell.nameLabel.text =[[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        [cell.allCountBidButton setTitle:[[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"totalNumber"] forState:UIControlStateNormal];
        
        cell.moneyLabel.text  =[[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"usedNumber"];
        
        //会头
        if (_indexFrom == 1) {
            [cell.deleteOrNotButton setTitle:@"删除" forState:UIControlStateNormal];
            [cell.deleteOrNotButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];
            
            [cell.allCountBidButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];

            
            [cell.allCountBidButton addTarget:self action:@selector(allCountBidButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.allCountBidButton.tag = indexPath.row;
            
            [cell.deleteOrNotButton addTarget:self action:@selector(deleteOrNotButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.deleteOrNotButton.tag = indexPath.row;
            
            
        }else if (_indexChoosen == 0){
            [cell.deleteOrNotButton setTitle:@"一一" forState:UIControlStateNormal];
        }
        
        
        return cell;
    }else if(_indexChoosen == 2){

        static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
        //    用TableSampleIdentifier表示需要重用的单元
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
        //    如果如果没有多余单元，则需要创建新的单元
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TableSampleIdentifier];
        }
//        cell.tabl
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.theStyleBid[indexPath.row][0];
        cell.textLabel.textColor = MBPGreenColor;
        cell.detailTextLabel.text = self.theStyleBid[indexPath.row][1];
        cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.detailTextLabel.numberOfLines = 0;
        cell.selectionStyle =UITableViewCellSelectionStyleGray;
        return cell;
    

}

return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section %d and row:%d",indexPath.section,indexPath.row);
    if (_indexChoosen == 2) {
        
        if (self.CycleSettingVCCellButtonDelegate && [self.CycleSettingVCCellButtonDelegate respondsToSelector:@selector(clickCycleSettingCellMethod:)]) {
            [self.CycleSettingVCCellButtonDelegate clickCycleSettingCellMethod:indexPath.row];
            //0:往下标1  1:往下标2  2:往下标3  3:往下标
  
        }
        
        [UserMessage sharedUserMessage].modeBidding = self.theStyleBid[indexPath.row][0];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    //    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
//    IncomeAnalysisViewController *aIncomeVC =[[IncomeAnalysisViewController alloc]init];
//    [self.navigationController pushViewController:aIncomeVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_indexChoosen == 2){
        return 100;
    }else {
      return 40;
    }
    return 0;
}

#pragma mark - 总名数
-(void)allCountBidButtonAction:(id)sender{
    UIButton *aButton =(UIButton *)sender;
    
    NSMutableArray *aPickArray =[[NSMutableArray alloc]init];
    for (int x =1; x <=50; x++) {
        NSString *numberString =[NSString stringWithFormat:@"%d",x];
        [aPickArray addObject:numberString];
    }
    
    ZHPickView *_pickview=[[ZHPickView alloc] initPickviewWithArray:aPickArray isHaveNavControler:NO];
    _pickview.tagVaule = aButton.tag;
    _pickview.delegate=self;
    [_pickview show];
    NSLog(@"array:%@ and tag:%d",aPickArray,aButton.tag);
}

#pragma mark --------ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    NSLog(@"result string :%@ and%d",resultString,pickView.tagVaule);
//    NSDate *localTime =[UserMessage getNowDateFromatAnDate:]
    if (_indexChoosen == 0) { 
//        int value = 0;
//        for (NSInteger y= pickView.tagVaule; y< self.myDataArray.count; y++) {
        
            NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:pickView.tagVaule inSection:0];
            CycleSettingTableViewCell *aCycleSettingCell =(CycleSettingTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
            
            NSDate *date =[UserMessage StringFormatToData:[resultString substringToIndex:10]];
            NSDate *stringDate = [UserMessage NextDateFromDate:date andmoth:0];
            NSString *timeString =[UserMessage DataFormatTwoToString:stringDate];
            NSString *dateBid =[NSString stringWithFormat:@"%@%@",[aCycleSettingCell.timeButton.titleLabel.text substringToIndex:2],[timeString substringToIndex:10]];
            [aCycleSettingCell.timeButton  setTitle:dateBid forState:UIControlStateNormal];
            
            //存储变动的开标日期数组
//        self.theEditCycle = self.myDataArray;
        
            NSMutableDictionary *mutableDictionry =[[NSMutableDictionary alloc] init];
            [mutableDictionry setObject:[[self.myDataArray objectAtIndex:pickView.tagVaule] objectForKey:@"countid"] forKey:@"cycle_id"];
            [mutableDictionry setObject:[timeString substringToIndex:10] forKey:@"date"];
            [self.theEditCycle addObject:mutableDictionry];
            
//           ++ value;
        
//        }
        
        
    }else if (_indexChoosen == 1){//会脚详情
        
        NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:pickView.tagVaule inSection:0];
        DetailBidFootTableViewCell *aDetailBidVCell =(DetailBidFootTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
        [aDetailBidVCell.allCountBidButton setTitle:resultString forState:UIControlStateNormal];
        [[_aNewData objectAtIndex:pickView.tagVaule] setObject:resultString forKey:@"totalNumber"];
        if (![[[_aNewData objectAtIndex:pickView.tagVaule] objectForKey:@"type"] isEqualToString:@"1"]) {
            [[_aNewData objectAtIndex:pickView.tagVaule] setObject:@"0" forKey:@"type"];

        }
        
        [[self.myDataArray objectAtIndex:pickView.tagVaule] setObject:resultString forKey:@"totalNumber"];
        
    }
    
    
}

#pragma mark - 删除会脚
-(void)deleteOrNotButtonAction:(id)sender{
    UIButton *aButton = (UIButton *)sender;
// NSMutableArray *ddd =[NSMutableArray arrayWithArray:self.aNewData];
    
    
    if (![[[_aNewData objectAtIndex:aButton.tag] objectForKey:@"type"] isEqualToString:@"1"]) {
        [[_aNewData objectAtIndex:aButton.tag] setObject:@"2" forKey:@"type"];
    }else {
        [_aNewData removeObjectAtIndex:aButton.tag];
    }
    
    [self.myDataArray removeObjectAtIndex:aButton.tag];
    [self.mytableView reloadData];
    
//    NSMutableArray *ddrrrd =[NSMutableArray arrayWithArray:self.aNewData];
    
}


#pragma mark - 开标日期
-(void)setTimeBidding:(id)sender{
    UIButton *aButton = (UIButton *) sender;
    
    NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:aButton.tag inSection:0];
    CycleSettingTableViewCell *aCycleSettingCell =(CycleSettingTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
    NSString *defaulDateStr =[NSString stringWithFormat:@"%@",[aCycleSettingCell.timeButton.titleLabel.text substringFromIndex:2]];
//    [aCycleSettingCell.timeButton  setTitle:dateBid forState:UIControlStateNormal];
    
    
    NSString *calType =[self.myBidDetailData objectForKey:@"calendarType"];
    
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
#pragma mark --- 竞标方式


#pragma mark --- 显示周期设定
-(void)getShowCycleSettingData {
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:[self.myBidDetailData objectForKey:@"gameId"] forKey:@"game_id"];
//        [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone] forKey:@"phone_number"];
        NSLog(@"8888%@%@?game_id=%@",APPBaseURL,APPShowCycleSetting,[self.myBidDetailData objectForKey:@"gameId"]);
        
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
                self.myDataArray  =[NSMutableArray arrayWithArray:json];
                self.aNewData = [NSMutableArray arrayWithArray:json];
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
                    UIAlertView *successAlertView =[[UIAlertView alloc] initWithTitle:@"编辑成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    successAlertView.tag = 10010;
                    [successAlertView show];
                    
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


#pragma mark --- 显示会脚详情
-(void)getShowParticipantInfoData {
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:[self.myBidDetailData objectForKey:@"gameId"] forKey:@"game_id"];
        
        
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
                self.myDataArray = json;
                _aNewData = [NSMutableArray arrayWithArray:json];
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
    if (alertView.tag == 10010) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
