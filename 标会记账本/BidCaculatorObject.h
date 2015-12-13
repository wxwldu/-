//
//  BidCaculatorObject.h
//  标会记账本
//
//  Created by Siven on 15/10/31.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BidCaculatorObject : NSObject




/**
 * 计算某一个周期中，某一个人的死标名数
 * 有别于全局的死标数，此处计算的是累计到第number期的死标数。但是使用的时候又需要注意，对于某一期的中标这个人而言：
 * 他的标名数总数 = 该期中标数（1名） + 这期之前的中标数 + 活标数
 * 前两个数值之和也就是这个方法计算出来的currentUsedNumber
 *
 * @param number
 * @param participant
 * @param bidResults
 */
+(int )caculateCurrentUsedNumberWithnumber:(int )number AndParticipant:(NSDictionary *)participant AndBidResult:(NSArray *)BidResult;

/**
 * 修改标金后,计算总会款。
 * 第一版的总会款显示实际上是交接款，因为中标人不需要把钱交给自己。
 * 第二版可能会增加一个字段来区分总会款、交接款，因此注释里面保留了计算标准的总会款的代码。
 *
 * @param number        第几期, number-1就是当前的竞标结果在list中的index
 * @param totalNum      总期数
 * @param biddingMethod 竞标规则
 * @param participants  所有参与的会脚
 * @param biddenMoney   标金
 * @return
 */
+(int )caculateTotalMoneyWithnumber:(int )number AndtotalNum:(int )totalNum AndcreatorId:(int )creatorId  AndbiddingMethod:(NSString *)biddingMethod  AndParticipant:(NSArray *)participant AndBidResult:(NSArray *)BidResult  AndbiddenMoney:(int) biddenMoney AndbaseLineMoney:(int) baseLineMoney;


/**
 * 外标计算使用到的方法
 * 计算某个人在两个周期内的死标金额累计值
 *
 * @param p
 * @param bidResults
 * @param startNum
 * @param endNum
 * @return
 */
+(int)getUsedMoneyWithParticipant:(NSDictionary *)participant AndbidResults:(NSArray *)bidResults AndstartNum:(int )startNum AndendNum:(int )endNum;


@end
