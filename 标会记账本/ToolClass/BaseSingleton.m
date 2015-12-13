//
//  BaseSingleton.m
//  MembershipBonusPoint
//
//  Created by Anna on 13-7-30.
//  Copyright (c) 2013年 PCCW. All rights reserved.
//

#import "BaseSingleton.h"

@implementation BaseSingleton
@synthesize currentUseCardId;
@synthesize myCardArr;
@synthesize merchantCardArr;
@synthesize productKey;
@synthesize tableHeadTitleArray;
@synthesize parentCategoryId;
@synthesize selectMerchantId;
@synthesize productCategoryInfo;
@synthesize cardsLognIn;
@synthesize productDetail;
@synthesize memberId;
@synthesize membershipId;
@synthesize merchantId;
@synthesize cardLoginArr;
@synthesize cardsProtalConfigArray;
@synthesize updateMemberWalletInfo;
@synthesize addToMyCartProduct;
@synthesize termOfPaymentTag;

@synthesize firstLevelTitle;
@synthesize secondLevelTitle;
@synthesize floorCount;


+(BaseSingleton *)shareSigleton
{
    static BaseSingleton *shareSingletion;
    @synchronized(self)
    {
        if (!shareSingletion)
        {
            shareSingletion= [[BaseSingleton alloc] init];
            shareSingletion.currentUseCardId = 0;
            shareSingletion.updateMemberWalletInfo = [[NSMutableArray alloc] init];
            shareSingletion.tableHeadTitleArray = [[NSMutableArray alloc] initWithCapacity:1];
        }

        return shareSingletion;
        
    }
}

@end
