
//  common.h
//  Huilc
//
//  Created by apple on 14-7-17.
//  Copyright (c) 2014年 RongXin. All rights reserved.
//

#ifndef common_h
#define common_h

#pragma mark APP config

#define APPVersion             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]//APP版本
#define APPID                   @"910068099"  
#define APPCheckVersionUrl      @"http://itunes.apple.com/lookup"//检查更新


#define APPShareSDKAppkey       @"2e25b78a316c" //ShareSDK Appkey
#define APPRedirectURL   @"http://www.huilc.cn" //ShareSDK URL




#define APPBaseURL                @"http://www.biaohui123.com"//生产服务器



#define APPLogin                 @"/MoneyGame/user/Login.php" //登录
#define APPRegister              @"/MoneyGame/user/Register.php" //注册
#define AppModifyPassword      @"/MoneyGame/user/ModifyPassword.php"  //重置密码 忘记密码
#define APPFeedback              @"/MoneyGame/user/Feedback.php"//用户反馈
#define APPUpdatePassword        @"/MoneyGame/user/UpdatePassword.php"//修改密码 菜单
#define APPIdentifyUser          @"/MoneyGame/user/IdentifyUser.php"//判断是否为用户（菜单-联系人）
#define APPShowMyGame            @"/MoneyGame/game/ShowMyGame.php"//“我”分页显示自己建的会（包括会的详情信息，每页最多10个会子）
#define APPCreateGame            @"/MoneyGame/game/CreateGame.php"//起会的完整流程，全部走完才算完成起会，才把起会信息传给服务器，“我要起会”+“邀请会脚”+“会脚详情”+“周期设定”4步
#define APPDeleteGame            @"/MoneyGame/game/DeleteGame.php"//删除会子
#define APPShowProfitByGame      @"/MoneyGame/game/ShowProfitByGame.php"//收益分析页面（按标会）
#define APPShowProfitByTime      @"/MoneyGame/game/ShowProfitByTime.php"//收益分析页面（按时间，从大到小排序）：
#define APPShowBiddingResult     @"/MoneyGame/game/ShowBiddingResult.php"//竞标结果


#define APPShowParticipantInfo   @"/MoneyGame/game/ShowParticipantInfo.php"//显示会脚详情
#define APPEditParticipantInfo   @"/MoneyGame/game/EditParticipantInfo.php"//编辑会脚详情信息（同时还可能会编辑周期设定信息）
#define APPEditBiddingResult     @"/MoneyGame/game/EditBiddingResult.php"//编辑竞标结果
#define APPShowBiddingCandidate  @"/MoneyGame/game/ShowBiddingCandidate.php"//竞标记录（获取竞标人）
#define APPShowCandidateHavingOpening  @"/MoneyGame/game/ShowCandidateHavingOpening.php"//竞标记录（获取有活会的会脚）
#define APPShowCandidateHavingNoBid    @"/MoneyGame/game/ShowCandidateHavingNoBid.php"//竞标记录（获取未中过标的会脚）
#define APPDraw                        @"/MoneyGame/game/Draw.php"//竞标记录（抽签
#define APPEditGameInfo                @"/MoneyGame/game/EditGameInfo.php"//编辑会子基本信息（内标转成外标：标金=会头钱+利息，外标转成内标：标金=会头钱-利息））

#define APPShowAllGame                 @"/MoneyGame/game/ShowAllGame.php"//编辑交会记录信息
#define APPShowBiddingResult           @"/MoneyGame/game/ShowBiddingResult.php"//竞标结果
#define APPBid                         @"/MoneyGame/game/Bid.php"//竞标
#define APPShowBiddingCandidate        @"/MoneyGame/game/ShowBiddingCandidate.php"//竞标记录（获取竞标人）
#define APPShowDrawingResult           @"/MoneyGame/game/ShowDrawingResult.php"//竞标记录（获取抽签结果）
#define APPShowCycleSetting            @"/MoneyGame/game/ShowCycleSetting.php"//展示周期设定信息
#define APPEditCycleSetting            @"/MoneyGame/game/EditCycleSetting.php"//保存周期设定信息
#define APPShowPaymentPerCycle         @"/MoneyGame/game/ShowPaymentPerCycle.php"//展示交会记录信息
#define APPEditPaymentPerCycle         @"/MoneyGame/game/EditPaymentPerCycle.php"//交会记录信息
#define APPGetNextDate                 @"/MoneyGame/discovery/GetNextDate.php"//开标提醒（获取下一个周期日期，即与系统时间相邻的下下个周期日期）
#define APPGetAdjacentDate             @"/MoneyGame/discovery/GetAdjacentDate.php"//开标提醒（获取与系统时间相邻的下一个周期日期）
#define APPGetPicture                  @"/MoneyGame/advertisement/GetPicture.php"//获取当前要展示广告图片：







#define isIOS7 (([[[UIDevice currentDevice] systemVersion]floatValue] >= 7.0 )? 1:0)//是否ios7
#define is4inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)//是否四寸屏


#define DataExpiryTime 30
#define KSystemVersion [[UIDevice currentDevice].systemVersion floatValue]

// App Frame Height&Width
#define Application_Frame  [[UIScreen mainScreen] applicationFrame] //除去信号区的屏幕的frame
#define APP_Frame_Height   [[UIScreen mainScreen] applicationFrame].size.height //应用程序的屏幕高度
#define App_Frame_Width    [[UIScreen mainScreen] applicationFrame].size.width  //应用程序的屏幕宽度
/*** MainScreen Height Width */
#define  APPScreenBoundsHeight [[UIScreen mainScreen] bounds].size.height //主屏幕的高度
#define  APPScreenBoundsWidth  [[UIScreen mainScreen] bounds].size.width  //主屏幕的宽度


#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBEDEDEDEBackgroundColor RGBCOLOR(0XDE,0XDE,0XDE)//我的账号背景颜色


#define BackgroundColorLightGreen  [UIColor colorWithRed:0.62 green:0.77 blue:0.18 alpha:1] //浅绿色1
#define BackgroundColorLightGray  [UIColor colorWithRed:0.88 green:0.89 blue:0.91 alpha:1] //背景灰色1(225 227 232)
#define BackgroundColorNavBarLightBlue  [UIColor colorWithRed:0.29 green:0.71 blue:0.95 alpha:1] //NavBar颜色（74 181 220）
#define BackgroundColorTitleInvestFiJiGreen [UIColor colorWithRed:0.32 green:0.45 blue:0.08 alpha:1] //(82 115 20)


#define HuiLCProjectBackgroudColor RGBCOLOR(0xf1,0xf1,0xf1) //工程所有背景色

#define ALERTView(msg) [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]

#define KToken          @"deviceToken"
#define KUserPhone         @"UserDefaultsPhone"
#define KUserPassword       @"UserDefaultsPassword"
//#define kPassword       [NSString stringWithFormat:@"%@PasswordGesture",[[NSUserDefaults standardUserDefaults] objectForKey:KUserID]]

#define  KMicrosoftYHFont8 [UIFont fontWithName:@"MicrosoftYaHei" size:8]   //微软雅黑


#define  KFZLTKHFont8  [UIFont fontWithName:@"fzltkh_GBK" size:8] //方正兰亭刊黑
#define  KFZLTKHFont10 [UIFont fontWithName:@"fzltkh_GBK" size:10]




#define KNumberofLock   5

#define kPasswordViewSideLength 280.0
#define kCircleRadius 30.0
#define kCircleLeftTopMargin 10.0
#define kCircleBetweenMargin 40.0
#define kPathWidth 6.0
#define kMinPasswordLength 3

#endif
