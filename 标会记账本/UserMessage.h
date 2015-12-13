//
//  UserMessage.h
//  Huilc
//
//  Created by apple on 14-8-4.
//  Copyright (c) 2014年 RongXin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserMessage : NSObject
{
    NSMutableDictionary * _userMessageDic;//用户登录信息
    
    NSString * _pwdStr;//登录密码(用于密码修改校验原密码)
    NSString * _phoneNum;
    NSString * _userOpenID;
    int _tagBidDown; 
    NSMutableArray * _addressBooks;//通讯录
    NSMutableDictionary * _BegainHeaderBidDic;// 标头－起会 详情
    
    NSMutableArray * _alertBiddingArray;//需要提醒的会
    
}
@property (nonatomic, strong) NSString * pwdStr;
@property (nonatomic, strong) NSString * phoneNum;

@property (nonatomic, strong) NSMutableDictionary * userMessageDic;
@property (nonatomic, strong) NSString * userOpenID;
@property (strong, nonatomic) NSMutableArray *addressBooks;
@property (nonatomic, strong) NSMutableDictionary * BegainHeaderBidDic;  // 标头－起会 详情
@property (nonatomic, strong) NSMutableArray * BegainHeaderBidFootDetail;  // 标头－起会－会脚详情
@property (nonatomic, strong) NSMutableArray * BegainHeaderBidCycle;  // 标头－起会－周期设定

@property (nonatomic) int  tagBidDown; //展开会脚 选择
@property (nonatomic, strong) NSString * modeBidding; //竞标方式
@property (strong, nonatomic) NSMutableArray *alertBiddingArray; //需要提醒的会

+(UserMessage *)sharedUserMessage;


+(NSString *)md5:(NSString *)input;

#pragma mark 时间格式切换 2014-09-08
+(NSString *)DataFormatToData:(NSString *)string;

////日期阳历转换为农历；
//+(NSData *)convertDateToNongLi:(NSString *)aStrDate;
+(NSString *)DataFormatToString:(NSDate *)dateFormat;
+(NSDate *)StringFormatToData:(NSString *)dateString;

//转换为北京时间
+ (NSDate *)tDateConverToGMT8Date:(NSDate *)date;

+(NSString *)DataFormatTwoToString:(NSDate *)dateFormat;



+ (NSDate *)NextDateFromDate:(NSDate *)date andYear:(int)yearValue andMonth:(int)monthValue andDay:(int)dayValue;
+ (NSDate *)NextDateFromDate:(NSDate *)date andmoth:(int)tagValue;
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
+ (NSDate *)stringToDateTwo:(NSString *)strdate;

//计算利息
+(int)calculteIncomeBid:(NSString *)value andBidMoney:(NSString *) bidmoney andheadMoney:(NSString *) headmoney;
//计算标金
-(NSString *)calculteMonegyBid:(NSString *)value andMoney:(NSString *) money;



+(int)caculatebidMoneyWithinterest:(int) interest AndbiddingMethod:(int )biddingMethod  AndBaselineMoney:(int )BaselineMoney;
//计算利息
+(int)caculateInterestWithbidMoney:(int) bidMoney AndbiddingMethod:(int )biddingMethod  AndBaselineMoney:(int )BaselineMoney;
@end
