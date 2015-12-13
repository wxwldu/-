//
//  AppDelegate.m
//  标会记账本
//
//  Created by Siven on 15/9/15.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "AppDelegate.h"
#import "Common.h"
#import "HeadBidViewController.h"
#import "AlertBidViewController.h"
#import "MenuSettingViewController.h"
#import "MBPConfig.h"

#import "MainFootBidViewController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "LoginViewController.h"
#import "UserMessage.h"

#import <SMS_SDK/SMSSDK.h>
#import "LunarSolarConverter.h"


@interface AppDelegate ()
@property (strong, nonatomic) UIImageView *adImageView;
@end

@implementation AppDelegate
@synthesize addressBook;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    for (int x=0; x<20; x++) {
//        int y = arc4random() % 10;
//        NSLog(@"random:%d",y);
//    }
    
//    Lunar *aLunar =[[Lunar alloc] init];
//    aLunar.lunarYear =  2015;
//    aLunar.lunarMonth= 11;
//    aLunar.lunarDay = 15;
//    Solar *aSolar =[LunarSolarConverter lunarToSolar:aLunar];
//    NSLog(@"year:%d month:%d day:%d",aSolar.solarYear,aSolar.solarMonth,aSolar.solarDay);
    
    
    // Override point for customization after application launch.
    self.window =[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self splashScreenAction]; //加载图片
    _com = [[Common alloc] init];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [SMSSDK registerApp:@"ad8ebcefdb20" withSecret:@"a4680499834ce225f4e8d6c7b07bba7f"];
    
    //检查更新
    [self checkVersion];
    
    
    [self getAddressBooks];
    
    
    //如果已经获得发送通知的授权则创建本地通知，否则请求授权(注意：如果不请求授权在设置中是没有对应的通知设置项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types==UIUserNotificationTypeNone) {
        
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
        
    }
    
    [self setTabBar];
    [self.window makeKeyAndVisible];
    return YES;
}

//app在前台运行，通知时间到了，调用的方法
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"起会竞标了" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
    
    // 图标上的数字减1
    application.applicationIconBadgeNumber -= 1;
    
    for (UILocalNotification *noti in [application scheduledLocalNotifications]) {
        
        [application cancelLocalNotification:noti];
        
    }
    
    
}

//－registerUserNotificationSettings

//#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
//-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
//    if (notificationSettings.types!=UIUserNotificationTypeNone) {
//        [self addLocalNotification];
//    }
//
//}



-(void)setTabBar
{
    UINavigationController *footBidNav,*headBidNav,*alertBidNav,*menuSettingNav;
    

//    FootBidViewController *footBidVC = [[FootBidViewController alloc] init];
    MainFootBidViewController *footBidVC =[[MainFootBidViewController alloc]init];
    AlertBidViewController *alertBidVC = [[AlertBidViewController alloc] init];
    HeadBidViewController *headBidVC = [[HeadBidViewController alloc] init];
    MenuSettingViewController *menuSettingVC = [[MenuSettingViewController alloc] init];
    
    
    //设置UITabBarItem图片 文字
    if ([[UIDevice currentDevice] systemVersion].floatValue >=7) {
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PorjectGreenColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        
        footBidVC.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"会脚" image:[[UIImage imageNamed:@"ic_game"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"ic_game_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        alertBidVC.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"开标提醒" image:[[UIImage imageNamed:@"ic_discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"ic_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        headBidVC.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"会头" image:[[UIImage imageNamed:@"ic_user"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"ic_user_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        menuSettingVC.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"菜单" image:[[UIImage imageNamed:@"ic_option"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"ic_option_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
    }else{
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PorjectGreenColor,UITextAttributeTextColor, nil] forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        
        footBidVC.tabBarItem =[[UITabBarItem alloc]init];
        [footBidVC.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"ic_game"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"ic_game_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        
        alertBidVC.tabBarItem =[[UITabBarItem alloc]init];
        [alertBidVC.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"ic_discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"ic_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        
        headBidVC.tabBarItem =[[UITabBarItem alloc]init];
        [headBidVC.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"ic_user"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"ic_user_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        
        menuSettingVC.tabBarItem =[[UITabBarItem alloc]init];
        [menuSettingVC.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"ic_option"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"ic_option_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        
    }
    

    
    footBidNav = [[UINavigationController alloc] initWithRootViewController:footBidVC];
    headBidNav = [[UINavigationController alloc] initWithRootViewController:headBidVC];
    alertBidNav = [[UINavigationController alloc] initWithRootViewController:alertBidVC];
    menuSettingNav = [[UINavigationController alloc] initWithRootViewController:menuSettingVC];
    
//设置title颜色和bar背景色
    [footBidNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName , nil]];
    footBidNav.navigationBar.barTintColor = PorjectGreenColor;
    
    [headBidNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName , nil]];
    headBidNav.navigationBar.barTintColor = PorjectGreenColor;

    [alertBidNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName , nil]];
    alertBidNav.navigationBar.barTintColor = PorjectGreenColor;

    [menuSettingNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName , nil]];
    menuSettingNav.navigationBar.barTintColor = PorjectGreenColor;
    
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[footBidNav, alertBidNav, headBidNav, menuSettingNav];
    [self.tabBarController setDelegate:self];

    
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    self.tabBarController.tabBar.frame= CGRectMake(0,CGRectGetHeight(mainScreen.bounds)-49 ,DEV_MAIN_SCREEN_WIDTH,49);
    if ( iOS7 ) {
        self.tabBarController.tabBar.barStyle = UIBarStyleDefault;
    } else {
//        self.tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"bottom-menubar-bg"];
        self.tabBarController.tabBar.selectionIndicatorImage = nil;
    }
    self.tabBarController.view.backgroundColor = [UIColor clearColor];
    
    
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone];
    NSString *passwordUser = [[NSUserDefaults standardUserDefaults] objectForKey:KUserPassword];
    
    self.window.rootViewController = self.tabBarController;
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    
    if (phoneNumber.length == 0 || passwordUser.length == 0) {
        
        LoginViewController *aLoginVC =[[LoginViewController alloc]init];
        
//        [self.window addSubview:aLoginVC.view];
////        [self.tabBarController presentViewController:aLoginVC animated:YES completion:nil];
        aLoginVC.selectTag = 1;
        self.window.rootViewController = aLoginVC;
//        self.tabBarController.tabBar.hidden = YES;
        
    }else{
        
        self.window.rootViewController = self.tabBarController;
        [self.window setBackgroundColor:[UIColor whiteColor]];
        
    }
    

}

#pragma mark - 私有方法
#pragma mark 添加本地通知
+(void)addLocalNotification:(NSDate *)date andTimeSecondInterval:(int)intervalSecond
{
    
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //设置调用时间
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.fireDate=[date dateByAddingTimeInterval:intervalSecond];//通知触发的时间，10s以后
    notification.repeatInterval=2;//通知重复次数
    notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody=@"起会竞标了"; //通知主体
    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
//    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
//    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    notification.soundName= UILocalNotificationDefaultSoundName;//通知声音（需要真机才能听到声音）
    
    //设置用户信息
//    notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

#pragma mark 移除本地通知，在不需要此通知时记得移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber=0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



-(void)splashScreenAction{
//    [NSThread sleepForTimeInterval:3.0];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"base url :%@",[APPBaseURL stringByAppendingString:APPGetPicture]);
    [manager POST:[APPBaseURL stringByAppendingString:APPGetPicture] parameters:nil  success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[[json allKeys] lastObject] isEqualToString:@"url"]) {
            
            //图片
            self.adImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
            NSURL *imageURL =[NSURL URLWithString:[json objectForKey:@"url"]];
            UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
            [self.adImageView setImage:image];
            [self.window addSubview:self.adImageView];
                [self performSelector:@selector(removeAdImageView) withObject:nil afterDelay:3];
  
            
        } else {
            int statusValue = [[json objectForKey:@"status"] intValue];
            if (statusValue == 0) {
                
            }else if (statusValue == 220)  {
                
                NSLog(@"没有要显示的图片");
                
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error");
    }];
    
}

- (void)removeAdImageView
{
    [UIView animateWithDuration:0.2f animations:^{
        self.adImageView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        self.adImageView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.adImageView removeFromSuperview];

    }];
}


//通讯录
-(void)getAddressBooks{
    NSMutableArray *addressBookTemp =[[NSMutableArray alloc]init];
    //新建一个通讯录类
//    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        
    {
        addressBook =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        
    }
    
    else
        
    {
        addressBook = ABAddressBookCreate();
        
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        TKAddressBook *addressBook = [[TKAddressBook alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.telephone = (__bridge NSString*)value;
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [addressBookTemp addObject:addressBook];
        
        
    }
    
    UserMessage *aUser =[UserMessage sharedUserMessage];
    aUser.addressBooks = addressBookTemp;
}


/**
 *  检测软件是否需要升级
 */
-(void)checkVersion
{
    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%i",ProjectAPPID];

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:nil  success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        NSString *newVersion;
        NSArray *resultArray = [dic objectForKey:@"results"];
        for (id config in resultArray) {
            newVersion = [config valueForKey:@"version"];
        }
        if (newVersion) {
            NSLog(@"通过AppStore获取的版本号是：%@",newVersion);
        }
        //获取本地版本号
        NSString *localVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
        NSString *msg = [NSString stringWithFormat:@"你当前的版本是V%@，发现新版本V%@，是否下载新版本？",localVersion,newVersion];
        if ([newVersion floatValue] > [localVersion floatValue]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"升级提示!" message:msg delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles:@"现在升级", nil];
            alert.tag = 0001;
            [alert show];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
        NSLog(@"从AppStore获取版本信息失败！！");
    }];

    
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0001) {
        //软件需要更新提醒
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/wan-zhuan-quan-cheng/id%i?mt=8",ProjectAPPID]];
            [[UIApplication sharedApplication]openURL:url];
            /*
             // 打开iTunes 方法二:此方法总是提示“无法连接到itunes”，不推荐使用
             NSString *iTunesLink = @"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=%i&mt=8";
             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=%i&mt=8",iFeverAPPID]];
             [[UIApplication sharedApplication] openURL:url];
             */
        }
    }
}


@end
