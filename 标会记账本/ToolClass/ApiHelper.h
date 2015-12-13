//
//  ApiHelper.h
//  MembershipBonusPoint
//
//  Created by carladmin on 7/2/14.
//  Copyright (c) 2014 PCCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiHelper : NSObject
{
    NSDictionary *objDict;

}

@property (strong, nonatomic) NSString *returnCode;
@property (strong, nonatomic) NSString *returnErr;
@property (nonatomic) int listingCount;

@property (strong, nonatomic) NSDictionary *returnDetail;

-(id)initWithDict:(NSDictionary*) dict;
-(BOOL) isSuccessWithErrorAlert: (BOOL)handleErr;

@end
