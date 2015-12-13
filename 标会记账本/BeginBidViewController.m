//
//  BeginBidViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/22.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BeginBidViewController.h"
#import "InviteContactsViewController.h"
#import "MBPConfig.h"
#import "UIButton+Bootstrap.h"
#import <QuartzCore/QuartzCore.h>
#import "CycleSettingViewController.h"
#import "LunarSolarConverter.h"

#import "TKContactsMultiPickerController.h"

@interface BeginBidViewController ()<CycleSettingViewControllerCellDelegate,ZHPickViewDelegate>{
    
    NSDate *mySelectDate; //时间
//    UIDatePicker *oneDatePicker;
}

@property (nonatomic, strong) ZHPickView *pickview;

@property (nonatomic, strong) NSDate *nextDate; //首期日期的第二起

@end

@implementation BeginBidViewController


- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setFrame:CGRectMake(30.0, 0.0, 28, 28)];
    
   
//    [_showBitFootButton setImage:[UIImage imageNamed:@"uncheckBox.png"] forState:UIControlStateNormal];
//    [_showBitFootButton setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateSelected];
//    [_showBitFootButton setTitle:@"是否对会脚公开" forState:UIControlStateNormal];
//    [_showBitFootButton setTitle:@"是否对会脚公开" forState:UIControlStateSelected];
//    [_showBitFootButton setSelected:YES]; //默认公开
//    [_showBitFootButton normalStyle];
    
//    [_showBitFootButton setImageEdgeInsets:UIEdgeInsetsMake(0, 25, 0, -55)];
//    [_showBitFootButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 25)];
    
//    _showBitFootButton.imageEdgeInsets = UIEdgeInsetsMake(0, _showBitFootButton.titleLabel.frame.size.width, 0, -_showBitFootButton.titleLabel.frame.size.width);
//    _showBitFootButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    
//    [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
//    [button setSelected:contact.rowSelected];
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我要起会";
//    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
//        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self setBackButton];
    self.hidesBottomBarWhenPushed = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    
    
    [self.nextButton normalStyle];
    
    [self.chooseWayButton normalStyleTwo];
    self.chooseWayButton.backgroundColor = [UIColor clearColor];
    [self.dateChooseButton normalStyleTwo];
    self.dateChooseButton.backgroundColor = [UIColor clearColor];
    [self.startBidButton normalStyleTwo];
    self.startBidButton.backgroundColor = [UIColor clearColor];
    
    [self.deleteButton normalStyle];
    [self.saveButton normalStyle];
    
    self.firstMoney.layer.masksToBounds = YES;
    self.firstMoney.layer.cornerRadius = 8.0;
    self.firstMoney.layer.borderColor = MBPGreenColor.CGColor;
    self.firstMoney.layer.borderWidth = 1.5;
    
    self.highIncome.layer.cornerRadius = 8.0;
    self.highIncome.layer.masksToBounds = YES;
    self.highIncome.layer.borderColor = MBPGreenColor.CGColor;
    self.highIncome.layer.borderWidth = 1.5;
    
    self.lowIncome.layer.cornerRadius = 8.0;
    self.lowIncome.layer.masksToBounds = YES;
    self.lowIncome.layer.borderColor = MBPGreenColor.CGColor;
    self.lowIncome.layer.borderWidth = 1.5;
    
    self.nameBid.layer.cornerRadius = 8.0;
    self.nameBid.layer.masksToBounds = YES;
    self.nameBid.layer.borderColor = MBPGreenColor.CGColor;
    self.nameBid.layer.borderWidth = 1.5;

//    [self.myScrollView setFrame:CGRectMake(0, 0, APPScreenBoundsWidth, APPScreenBoundsHeight)];
//    self.myScrollView.contentSize = CGSizeMake(APPScreenBoundsWidth, APPScreenBoundsHeight + 20);
    
//    [self.showAllForFoot addTarget:self action:@selector(setSelectedSegmentIndex:) forControlEvents:UIControlEventValueChanged];
    
}


- (IBAction)showBidFootAction:(id)sender {
    UIButton *aButton = (UIButton *)sender;
    if (aButton.selected) {
        aButton.selected = NO;
    }else{
        aButton.selected = YES;
    }
    
}

-(void)setSelectedSegmentColor:(UISegmentedControl *)mySegmentedControl {
    for (UIControl *subview in mySegmentedControl.subviews) {
        subview.tintColor = [subview isSelected] ? MBPGreenColor : [UIColor whiteColor];
    }
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (_indexValue == 0) {
        self.deleteButton.hidden = YES;
        self.saveButton.hidden = YES;
        self.nextButton.hidden = NO;
    } else if (_indexValue == 1){ //1编辑会
        self.deleteButton.hidden = NO;
        self.saveButton.hidden = NO;
        self.nextButton.hidden = YES;
        
        [self.startBidButton setEnabled:NO];
        
        //是否公开
        
        if ([[[self.myDataBidDetail objectForKey:@"showAll"] stringValue] isEqualToString:@"0"]) {
            [self.showAllForFoot setSelectedSegmentIndex:1];
            
        }else{
            [self.showAllForFoot setSelectedSegmentIndex:0];
            
        }
        
    }
    
    if (self.myDataBidDetail.count != 0) {
        self.nameBid.text = [self.myDataBidDetail objectForKey:@"creatorName"];
        self.firstMoney.text =[self.myDataBidDetail objectForKey:@"baselineMoney"];
        
        NSString *modeBid =[self.myDataBidDetail objectForKey:@"biddingMethod"];
        if ([modeBid isEqualToString:@"0"]) {
            [self.chooseWayButton setTitle:@"往下标1"  forState:UIControlStateNormal];
        } else if ([modeBid isEqualToString:@"1"]) {
            [self.chooseWayButton setTitle:@"往下标2"  forState:UIControlStateNormal];
        }else if ([modeBid isEqualToString:@"2"]) {
            [self.chooseWayButton setTitle:@"往下标3"  forState:UIControlStateNormal];
        }else if ([modeBid isEqualToString:@"3"]) {
            [self.chooseWayButton setTitle:@"往上标"  forState:UIControlStateNormal];
        }
        
        self.highIncome.text = [self.myDataBidDetail objectForKey:@"topLineInterest"];
        self.lowIncome.text = [self.myDataBidDetail objectForKey:@"bottomLineInterest"];
        
        NSString *calendarTypeStr =[self.myDataBidDetail objectForKey:@"calendarType"];
        NSString *firstDateStr =[self.myDataBidDetail objectForKey:@"firstDate"];
        
        self.nextDate =[UserMessage NextDateFromDate:[UserMessage StringFormatToData:firstDateStr] andmoth:1];
        
        if ([calendarTypeStr isEqualToString:@"0"]) {
            [self.dateChooseButton setTitle:[NSString stringWithFormat:@"农历%@",firstDateStr]  forState:UIControlStateNormal];
        }else{
            [self.dateChooseButton setTitle:[NSString stringWithFormat:@"阳历%@",firstDateStr]  forState:UIControlStateNormal];
        }
        
        [self.startBidButton setTitle:[self.myDataBidDetail objectForKey:@"startTime"]  forState:UIControlStateNormal];
        
        
    }
}
#pragma mark -竞标方式
- (IBAction)modeBiddingButtonAction:(id)sender {
    [self.nameBid resignFirstResponder];
    
    CycleSettingViewController *aContactsVC =[[CycleSettingViewController alloc]init];
    aContactsVC.CycleSettingVCCellButtonDelegate = self;
    aContactsVC.indexChoosen = 2;
    [self.navigationController pushViewController:aContactsVC animated:YES];
    
}

#pragma mark -首起日期
- (IBAction)firstDateButtonAction:(id)sender {
    [self.lowIncome resignFirstResponder];
    if (self.indexValue == 0) {
        _pickview =[[ZHPickView alloc] initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _pickview.segmentControl.selectedSegmentIndex = 1;
    } else {
        NSString *calendarTypeStr =[self.myDataBidDetail objectForKey:@"calendarType"];
        NSString *firstDateStr =[self.myDataBidDetail objectForKey:@"firstDate"];
        NSDate *firstDate =[UserMessage StringFormatToData:firstDateStr];
        
        _pickview =[[ZHPickView alloc] initLimitStartDatePickWithStartDate:nil andLargeDate:self.nextDate andDefaulDate:firstDate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        //    _pickview =[[ZHPickView alloc] initDatePickWithDate:firstDate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _pickview.segmentControl.selectedSegmentIndex = [calendarTypeStr intValue];
    }
  
    [_pickview.segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    _pickview.tagVaule = 0;
    _pickview.delegate=self;
    [_pickview show];
    
    
}

-(void)segmentAction:(UISegmentedControl *)seg{
    int segmentValue = seg.selectedSegmentIndex;

    NSCalendar *calendar =[NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:_pickview.datePicker.date];
    
    
    switch (segmentValue) {
        case 0:
        {
            Solar *aSolar =[[Solar alloc] init];
            aSolar.solarYear =  [components year];
            aSolar.solarMonth= [components month];
            aSolar.solarDay = [components day];
            Lunar *aLunar =[LunarSolarConverter solarToLunar:aSolar];
//            NSLog(@"year:%d month:%d day:%d",aSolar.solarYear,aSolar.solarMonth,aSolar.solarDay);
            
            NSCalendar *greCalendar = [NSCalendar currentCalendar];
            //  定义一个NSDateComponents对象，设置一个时间点
            NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
            [dateComponentsForDate setDay:aLunar.lunarDay];
            [dateComponentsForDate setMonth:aLunar.lunarMonth];
            [dateComponentsForDate setYear:aLunar.lunarYear];
            
            //  根据设置的dateComponentsForDate获取历法中与之对应的时间点
            //  这里的时分秒会使用NSDateComponents中规定的默认数值，一般为0或1。
            NSDate *dateFromDateComponentsForDate = [greCalendar dateFromComponents:dateComponentsForDate];
            
            
            [_pickview.datePicker setDate:dateFromDateComponentsForDate];
            _pickview.defaulDate =dateFromDateComponentsForDate;
        }
            
            break;
        case 1:
        {
            Lunar *aLunar =[[Lunar alloc] init];
            aLunar.lunarYear =  [components year];;
            aLunar.lunarMonth= [components month];;
            aLunar.lunarDay = [components day];;
            Solar *aSolar =[LunarSolarConverter lunarToSolar:aLunar];
            NSLog(@"year:%d month:%d day:%d",aSolar.solarYear,aSolar.solarMonth,aSolar.solarDay);
            
            NSCalendar *greCalendar = [NSCalendar currentCalendar];
            //  定义一个NSDateComponents对象，设置一个时间点
            NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
            [dateComponentsForDate setDay:aSolar.solarDay];
            [dateComponentsForDate setMonth:aSolar.solarMonth];
            [dateComponentsForDate setYear:aSolar.solarYear];
            
            //  根据设置的dateComponentsForDate获取历法中与之对应的时间点
            //  这里的时分秒会使用NSDateComponents中规定的默认数值，一般为0或1。
            NSDate *dateFromDateComponentsForDate = [greCalendar dateFromComponents:dateComponentsForDate];
            
            
            [_pickview.datePicker setDate:dateFromDateComponentsForDate];
            _pickview.defaulDate =dateFromDateComponentsForDate;
        }
            break;
            
        default:
            break;
    }
}
#pragma mark -开标时间
- (IBAction)begainDateButtonAction:(id)sender {
    NSLog(@"date %@",[NSDate date]);
    
    
    _pickview =[[ZHPickView alloc] initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeTime isHaveNavControler:NO];
    _pickview.segmentControl.hidden = YES;
    
    _pickview.tagVaule = 1;
    _pickview.delegate=self;
    [_pickview show];
}

#pragma mark -下一步
- (IBAction)nextButtonAction:(id)sender {
    if (self.nameBid.text.length ==0 ||self.firstMoney.text.length ==0||self.lowIncome.text.length ==0 ||self.highIncome.text.length == 0||self.chooseWayButton.titleLabel.text.length== 0 ||self.dateChooseButton.titleLabel.text.length == 0||self.startBidButton.titleLabel.text.length ==0) {
        
        ALERTView(@"不为空");
        return ;
    }
//    0:往下标1  1:往下标2  2:往下标3  3:往上标
    NSString *methodBid =[[NSString alloc]init];
    NSLog(@"title:%@",self.dateChooseButton.titleLabel.text);
    if ([self.chooseWayButton.titleLabel.text isEqualToString:@"往下标1"]) {
        methodBid = @"0";
    } else if ([self.chooseWayButton.titleLabel.text isEqualToString:@"往下标2"]) {
        methodBid = @"1";
    } else if ([self.chooseWayButton.titleLabel.text isEqualToString:@"往下标3"]) {
        methodBid = @"2";
    } else if ([self.chooseWayButton.titleLabel.text isEqualToString:@"往上标"]) {
        methodBid = @"3";
    }
    NSString *typeCalendar =[[NSString alloc]init];
    if ([[self.dateChooseButton.titleLabel.text substringToIndex:2] isEqualToString:@"农历"]) {
        typeCalendar = @"0";
    } else {
        typeCalendar = @"1";
    }
    
    //会脚可见否
    NSString *ShowAllString =[[NSString alloc]init];
    if (self.showAllForFoot.selectedSegmentIndex == 0) {
//        [parameter setObject:@"1" forKey:@"show_all"];
        ShowAllString = @"1";
    }else{
//        [parameter setObject:@"0" forKey:@"show_all"];
        ShowAllString = @"0";
    }
    
//    NSLog(@"%@ and%@",self.dateChooseButton.titleLabel.text ,[self.dateChooseButton.titleLabel.text substringFromIndex:3]);
//    NSLog(@"creator_name:%@",self.firstMoney.text);
    //[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone]
    NSDictionary *valueDictionary =[NSDictionary dictionaryWithObjectsAndKeys:self.nameBid.text,@"creator_name",[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone],@"phone_number",self.firstMoney.text,@"baseline_money",methodBid,@"bidding_method",self.highIncome.text,@"top_line_interest",self.lowIncome.text,@"bottom_line_interest",typeCalendar,@"calendar_type",[self.dateChooseButton.titleLabel.text substringFromIndex:2],@"first_date",self.startBidButton.titleLabel.text,@"start_time",ShowAllString,@"show_all",nil];
    
    [UserMessage sharedUserMessage].BegainHeaderBidDic = valueDictionary;
    
    
//    InviteContactsViewController *aContactsVC =[[InviteContactsViewController alloc]init];
//    aContactsVC.inviteType = 1;
////    aContactsVC.beganBidDictiony  = valueDictionary ;
//    [self.navigationController pushViewController:aContactsVC animated:YES];
 
    TKContactsMultiPickerController *aTKContactsVC =[[TKContactsMultiPickerController alloc] initWithGroup:nil];
    aTKContactsVC.hidesBottomBarWhenPushed = YES;
    aTKContactsVC.inviteType = 1;
    [self.navigationController pushViewController:aTKContactsVC animated:YES];
    
    
}

#pragma mark -删除按钮
- (IBAction)deleteBiddingButtonAction:(id)sender {
    UIAlertView *aAlertView =[[UIAlertView alloc]initWithTitle:nil message:@"您确定要删除该标会吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    aAlertView.tag = 1000;
    [aAlertView show];
//    
}
#pragma mark -保存按钮
- (IBAction)saveBiddingButtonAction:(id)sender {
    
    [self APPEditGameInfoData];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.lowIncome resignFirstResponder];
    [self.highIncome resignFirstResponder];
    [_pickview remove];
}

#pragma mark - UITextFieldDelegate
// 获取第一响应者时调用 //UITextField的协议方法，当开始编辑时监听
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor=[MBPGreenColor CGColor];
    
//    if (textField == self.lowIncome || textField == self.highIncome) {
//        
//        self.myScrollView.contentSize = CGSizeMake(APPScreenBoundsWidth, APPScreenBoundsHeight+300);
//    }


    return YES;

    
}

// 失去第一响应者时调用
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
//    if (textField == self.lowIncome || textField == self.highIncome) {
//        
//        self.myScrollView.contentSize = CGSizeMake(APPScreenBoundsWidth, APPScreenBoundsHeight);
//    }
    
    textField.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    return YES;
}

// 按enter时调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//隐藏键盘的方法
-(void)hidenKeyboard
{
    [self.nameBid resignFirstResponder];
    [self.firstMoney resignFirstResponder];
    [self.lowIncome resignFirstResponder];
    [self.highIncome resignFirstResponder];
//    [self resumeView];
}

////点击键盘上的Return按钮响应的方法
//-(IBAction)nextOnKeyboard:(UITextField *)sender
//{
//    if (sender == self.userNameText) {
//        [self.passwordText becomeFirstResponder];
//    }else if (sender == self.passwordText){
//        [self hidenKeyboard];
//    }
//}
#pragma mark ---ZHPiewViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *destDate= [dateFormatter dateFromString:resultString];
//     NSLog(@"date111:%@",destDate);
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: destDate];
//    NSDate *localeDate = [destDate  dateByAddingTimeInterval: interval];
//    NSLog(@"date22:%@",localeDate);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss Z"];
    NSString *resultDateString =[dateFormat stringFromDate:destDate];
    
//    NSLog(@"date:%@",destDateString);
    if (pickView.tagVaule ==0) {
        if (pickView.segmentControl.selectedSegmentIndex == 0) {
            [self.dateChooseButton setTitle:[NSString stringWithFormat:@"农历%@",[resultDateString substringToIndex:10]] forState:UIControlStateNormal];
        } else if (pickView.segmentControl.selectedSegmentIndex == 1){
            [self.dateChooseButton setTitle:[NSString stringWithFormat:@"阳历%@",[resultDateString substringToIndex:10]] forState:UIControlStateNormal];
        }

    }else if (pickView.tagVaule == 1){
        ;
        NSLog(@"time:%@ %@ and%@",resultString,[resultDateString substringWithRange:NSMakeRange(11, 8)],[[resultDateString substringWithRange:NSMakeRange(11, 6)] stringByAppendingFormat:@"00"]);
        
        [self.startBidButton setTitle:[[resultDateString substringWithRange:NSMakeRange(11, 6)] stringByAppendingFormat:@"00"] forState:UIControlStateNormal];
    }
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
#pragma  mark ----UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1000) {
        if (buttonIndex == 1) {
            [self DeleteGameBidData];
        }
    }else if (alertView.tag == 10001) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}


#pragma  mark ----  CycleSettingVCCellButtonDelegate  选择竞标方式的协议
-(void)clickCycleSettingCellMethod:(int)value{
    //0:往下标1  1:往下标2  2:往下标3  3:往上标
    [self.myDataBidDetail setObject:[NSString stringWithFormat:@"%d",value] forKey:@"biddingMethod"];
    
    if (value == 0) {
        [self.chooseWayButton setTitle:@"往下标1" forState:UIControlStateNormal];
    } else if (value == 1) {
        [self.chooseWayButton setTitle:@"往下标2" forState:UIControlStateNormal];
    }  else if (value == 2) {
        [self.chooseWayButton setTitle:@"往下标3" forState:UIControlStateNormal];
    }  else if (value == 3) {
        [self.chooseWayButton setTitle:@"往上标" forState:UIControlStateNormal];
    }
 
    
}



- (void)keyboardWillHide:(id)sender {
    NSDictionary * info = [sender userInfo];
    NSValue * value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    CGRect viewFrame = self.myScrollView.frame;
    viewFrame.size.height -= keyboardSize.height - (APPScreenBoundsHeight - self.myScrollView.frame.size.height);
    self.myScrollView.contentSize = viewFrame.size;
    
}

- (void)keyboardWillShow:(id)sender {
    NSDictionary * info = [sender userInfo];
    NSValue * value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    CGRect viewFrame = self.myScrollView.frame;
    viewFrame.size.height += keyboardSize.height - (APPScreenBoundsHeight - self.myScrollView.frame.size.height);
    self.myScrollView.contentSize = viewFrame.size;
}


-(void)DeleteGameBidData{
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:[self.myDataBidDetail objectForKey:@"gameId"] forKey:@"game_id"];

        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPDeleteGame] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([resuldId isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 0)  {
                    
                    
                    UIAlertView *aAlertView =[[UIAlertView alloc]initWithTitle:nil message:@"删除成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    aAlertView.tag = 10001;
                    [aAlertView show];
                    
                    
                    
                }else if (statusValue ==105)  {
                    ALERTView(@"输入会子id不合法");
                }else if (statusValue ==217)  {
                    ALERTView(@"删除失败");
                }
                
            }
            
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
        
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
    
}


-(void)APPEditGameInfoData{

    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:self.nameBid.text forKey:@"creator_name"];
        [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone] forKey:@"creator_phone_number"];
//        NSLog(@"bid name:%@",self.nameBid)
        if ([self.chooseWayButton.titleLabel.text  isEqualToString:@"往下标1"]) {
            [parameter setObject:@"0" forKey:@"bidding_method"];
        } else if ([self.chooseWayButton.titleLabel.text  isEqualToString:@"往下标2"]){
            [parameter setObject:@"1" forKey:@"bidding_method"];
        } else if ([self.chooseWayButton.titleLabel.text  isEqualToString:@"往下标3"]){
            [parameter setObject:@"2" forKey:@"bidding_method"];
        }else if ([self.chooseWayButton.titleLabel.text  isEqualToString:@"往上标"]){
            [parameter setObject:@"3" forKey:@"bidding_method"];
        }
        
        //会脚可见否
        if (self.showAllForFoot.selectedSegmentIndex == 0) {
            [parameter setObject:@"1" forKey:@"show_all"];
        }else{
            [parameter setObject:@"0" forKey:@"show_all"];
        }
        
        [parameter setObject:self.highIncome.text forKey:@"top_line_interest"];
        [parameter setObject:self.lowIncome.text forKey:@"bottom_line_interest"];
        
        NSString *firstDateStr =[self.dateChooseButton.titleLabel.text substringToIndex:2];
        if ([firstDateStr isEqualToString:@"农历"]) {
            [parameter setObject:@"0" forKey:@"calendar_type"]; //历法类型
        }else{
            [parameter setObject:@"1" forKey:@"calendar_type"]; //历法类型
        }
        
        [parameter setObject:[self.dateChooseButton.titleLabel.text substringFromIndex:2] forKey:@"first_date"];
        [parameter setObject:self.startBidButton.titleLabel.text forKey:@"start_time"];
        [parameter setObject:[self.myDataBidDetail objectForKey:@"gameId"] forKey:@"game_id"];
        [parameter setObject:[self.myDataBidDetail objectForKey:@"participantId"] forKey:@"creator_id"];
        [parameter setObject:[self.myDataBidDetail objectForKey:@"cycleNumber"] forKey:@"cycle_number"];
        [parameter setObject:self.firstMoney.text forKey:@"baseline_money"];

        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        [manager POST:[APPBaseURL stringByAppendingString:APPEditGameInfo] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([resuldId isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 107)  {
                    ALERTView(@"输入会头id不合法");
                }else if (statusValue ==105)  {
                    ALERTView(@"输入会子id不合法");
                }else if (statusValue == 100)  {
                    ALERTView(@"会头手机号不合法");
                }else if (statusValue ==115)  {
                    ALERTView(@"输入会头姓名不合法");
                }else if (statusValue == 116)  {
                    ALERTView(@"输入会头钱不合法");
                }else if (statusValue ==117)  {
                    ALERTView(@"输入竞标方式不合法");
                }else if (statusValue == 118)  {
                    ALERTView(@"输入顶标利息不合法");
                }else if (statusValue ==119)  {
                    ALERTView(@"输入底标利息不合法");
                }else if (statusValue == 120)  {
                    ALERTView(@"输入首期日期不合法");
                }else if (statusValue ==121)  {
                    ALERTView(@"输入开标时间不合法");
                }else if (statusValue == 122)  {
                    ALERTView(@"输入历法类型不合法");
                }else if (statusValue ==210)  {
                    ALERTView(@"编辑失败");
                }else if (statusValue ==218)  {
                    ALERTView(@"编辑的首期日期比第二期要晚");
                }else if (statusValue ==219)  {
                    ALERTView(@"已经开标的周期中，存在利息不在新编辑的最高利息和最低利息之间");
                }else if (statusValue ==125)  {
                    ALERTView(@"输入会脚可见不合法");
                }else if (statusValue == 0)  {
                    
                    UIAlertView *aAlertView =[[UIAlertView alloc]initWithTitle:nil message:@"编辑成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    aAlertView.tag = 10001;
                    [aAlertView show];
                }
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
    
}




//-(void)changeSegmentControl:(id)sender{
//    UISegmentedControl  *aSegment = (UISegmentedControl *)sender;
//    if (aSegment.selectedSegmentIndex == 0) {
//        
//    }
//}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
