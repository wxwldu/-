//
//  UserMessage.m
//  Huilc
//
//  Created by apple on 14-8-4.
//  Copyright (c) 2014年 RongXin. All rights reserved.
//
//  用户信息

#import "UserMessage.h"
#import <CommonCrypto/CommonDigest.h>

static UserMessage * message;
@implementation UserMessage
@synthesize userMessageDic = _userMessageDic;
@synthesize pwdStr = _pwdStr;
@synthesize userOpenID = _userOpenID;
@synthesize addressBooks = _addressBooks;
@synthesize  phoneNum = _phoneNum,tagBidDown = _tagBidDown,alertBiddingArray= _alertBiddingArray;
@synthesize BegainHeaderBidDic=_BegainHeaderBidDic,BegainHeaderBidCycle=_BegainHeaderBidCycle,BegainHeaderBidFootDetail=_BegainHeaderBidFootDetail;


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _BegainHeaderBidCycle =[[NSMutableArray alloc]init];
        _BegainHeaderBidFootDetail =[[NSMutableArray alloc]init];
        _alertBiddingArray =[[NSMutableArray alloc] init];
        _addressBooks =[[NSMutableArray alloc]init];
        _userMessageDic = [[NSMutableDictionary alloc] init];
        _BegainHeaderBidDic = [[NSMutableDictionary alloc] init];
        _pwdStr = @"";
        _phoneNum = @"";
        _userOpenID = @"";
        _tagBidDown = 0;
        _modeBidding = @"";
        
    }   
    return self;
}

+(UserMessage *)sharedUserMessage
{
    if(message == nil)
    {
        message = [[UserMessage alloc] init];
    }
    return message;
}


+(NSString *)md5:(NSString *)input {
    
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
        
        NSString *newHexStr =[NSString stringWithFormat:@"%x",result[i]&0xff] ;
        if ([newHexStr length] == 1) {
            
            [[NSString stringWithFormat:@"0"] stringByAppendingString:newHexStr];
            
        }
        [ret stringByAppendingString:[newHexStr uppercaseString]];
    }
    
    return ret;
}
#pragma mark 时间格式切换 2014-09-08
+(NSDate *)DataFormatToData:(NSString *)string
{
    //    NSString *lastModified =@"Wed Aug 06 18:46:33 CST 2014";
    NSString *lastModified =string;
    NSDateFormatter *df =[[NSDateFormatter alloc]init];
    df.dateFormat = @"EEE MMM dd HH:mm:ss 'CST' yyyy";
    df.locale =[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    NSDate *todated =[df dateFromString:lastModified];
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dataStr =[dateFormatter stringFromDate:todated];
    NSDate *myDate =[self StringFormatToData:dataStr];
    return myDate;
}

+(NSString *)DataFormatTwoToString:(NSDate *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSString *strDate = [dateFormatter stringFromDate:dateFormat];
    return strDate;
}


+(NSString *)DataFormatToString:(NSDate *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:dateFormat];
    return strDate;
}
//NSString 2 NSDate
+ (NSDate *)stringToDateTwo:(NSString *)strdate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *retdate = [dateFormatter dateFromString:strdate];
    return retdate;
}


+(NSDate *)StringFormatToData:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *destDate= [[NSDate alloc ] init];
    destDate = [dateFormatter dateFromString:dateString];
//    destDate =
    NSTimeZone *zone =[NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:destDate];
    NSDate *localeDate =[destDate dateByAddingTimeInterval:interval];
    
    return localeDate;
}

+ (NSDate *)tDateConverToGMT8Date:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
    
}

#pragma mark ---- 上下月
+ (NSDate *)NextDateFromDate:(NSDate *)date andmoth:(int)tagValue
{
    NSTimeZone *zone =[NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate =[date dateByAddingTimeInterval:interval]; //获取本地时间
    
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //  通过已定义的日历对象，获取某个时间点的NSDateComponents表示，并设置需要表示哪些信息（NSYearCalendarUnit, NSMonthCalendarUnit, NSDayCalendarUnit等）
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:localeDate];
    
    [dateComponents setMonth:([dateComponents month] + tagValue)];
//    [dateComponents setDay:[dateComponents day]+1];
    NSDate *nextMonth = [greCalendar dateFromComponents:dateComponents];
    
    
    return nextMonth;
    
    
}

#pragma mark ---- 时间上下
+ (NSDate *)NextDateFromDate:(NSDate *)date andYear:(int)yearValue andMonth:(int)monthValue andDay:(int)dayValue
{
    NSTimeZone *zone =[NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate =[date dateByAddingTimeInterval:interval]; //获取本地时间
    
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //  通过已定义的日历对象，获取某个时间点的NSDateComponents表示，并设置需要表示哪些信息（NSYearCalendarUnit, NSMonthCalendarUnit, NSDayCalendarUnit等）
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:localeDate];
    
    [dateComponents setMonth:([dateComponents month] + monthValue)];
    [dateComponents setDay:[dateComponents day] + dayValue];
    [dateComponents setYear:[dateComponents year]+ yearValue];
    NSDate *nextMonth = [greCalendar dateFromComponents:dateComponents];
    
    
    return nextMonth;
    
    
}


////日期阳历转换为农历；
//+(NSData *)convertDateToNongLi:(NSString *)aStrDate
//{
//    NSDate *dateTemp = nil;
//    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
//    [dateFormater setDateFormat:@"yyyy-MM-dd"];
//    dateTemp = [dateFormater dateFromString:aStrDate];
//    
//    NSCalendar* calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSChineseCalendar];
//    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:dateTemp];
//    
//    return components.date;
//}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}


////计算标利息
//+(NSString *)calculteBalance:(NSString *)value andMoney:(NSString *) money{
//    
//    if ([value isEqualToString:@"0"]) {
//        
//    } else if ([value isEqualToString:@"1"]){
//        <#statements#>
//    }else if ([value isEqualToString:@"2"]){
//        <#statements#>
//    }else if ([value isEqualToString:@"3"]){
//        <#statements#>
//    }
//}
//
////计算标金
//+(NSString *)calculteMonegyBid:(NSString *)value andMoney:(NSString *) money{
//    
//    if ([value isEqualToString:@"3"]) {
//        self.myMoneyLabel.text =[NSString stringWithFormat:@"%d",[[self.bidDetailDictionary objectForKey:@"baselineMoney"] intValue] +[self.myIncomeLabel.text intValue]];
//        
//    } else {
//        self.myMoneyLabel.text =[NSString stringWithFormat:@"%d",[[self.bidDetailDictionary objectForKey:@"baselineMoney"] intValue] +[self.myIncomeLabel.text intValue]];
//    }
//}


//计算利息
+(int)calculteIncomeBid:(NSString *)value andBidMoney:(NSString *) bidmoney andheadMoney:(NSString *) headmoney{
    
    if ([value isEqualToString:@"3"]) {
        return [bidmoney intValue] -[headmoney intValue];
        
    } else {
        return [headmoney intValue] -[bidmoney intValue];
    }
}



/**
 * 根据规则、利息计算标金
 * 这边不做数值合法性检测，检测放在调用的外面
 *
 * @param interest
 * @return
 */
+(int)caculatebidMoneyWithinterest:(int) interest AndbiddingMethod:(int )biddingMethod  AndBaselineMoney:(int )BaselineMoney {
    int bidMoney = 0;
    switch (biddingMethod) {
        case 0:
        case 1:
        case 2:
            bidMoney = BaselineMoney - interest;
            break;
        case 3:
            bidMoney = BaselineMoney + interest;
            break;
    }
    return bidMoney;
}



/**
 * 根据规则、标金计算利息
 *
 * @param bidMoney
 * @return
 */
+(int)caculateInterestWithbidMoney:(int) bidMoney AndbiddingMethod:(int )biddingMethod  AndBaselineMoney:(int )BaselineMoney{
    int interest = 0;
    switch (biddingMethod) {
        case 0:
        case 1:
        case 2:
            interest = BaselineMoney - bidMoney;
            break;
        case 3:
            interest = bidMoney - BaselineMoney;
            break;
    }
    return interest;
}
@end
