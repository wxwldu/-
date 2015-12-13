//
//  BiddingRecordObjec.m
//  标会记账本
//
//  Created by Siven on 15/11/7.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import "BiddingRecordObjec.h"

@implementation BiddingRecordObjec



-(id)initWith:(NSDictionary *)aDictObejct{
    

    self.name =[NSString stringWithFormat:@"%@",[aDictObejct objectForKey:@"name"]];
    self.biddingMoney = [aDictObejct objectForKey:@"biddingMoney"];
    self.biddingInterest =[aDictObejct objectForKey:@"biddingInterest"];
    self.participantId =[aDictObejct objectForKey:@"participantId"];

    
    return self;
}

//自定义排序方法
-(NSComparisonResult)comparePerson:(BiddingRecordObjec *)person{
    //默认按年龄排序
    NSComparisonResult result = [[NSNumber numberWithInt:[person.biddingInterest intValue]] compare:[NSNumber numberWithInt:[self.biddingInterest intValue]]];//注意:基本数据类型要进行数据转换
    //如果年龄一样，就按照名字排序
    if (result == NSOrderedSame) {
        result = [self.name compare:person.name];
    }
    return result;
}

@end
