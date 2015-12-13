//
//  AppDelegate.h
//  标会记账本
//
//  Created by Siven on 15/9/15.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "macro.h"
#import "MBPConfig.h"
#import "Common.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "TKAddressBook.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) Common        *com;
@property (strong, nonatomic) UITabBarController    *tabBarController;
@property (nonatomic, assign) ABAddressBookRef addressBook;

+ (AppDelegate *)sharedDelegate;


+(void)addLocalNotification:(NSDate *)date andTimeSecondInterval:(int)intervalSecond;
@end

