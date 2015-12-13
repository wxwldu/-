//
//  ApiHelper.m
//  MembershipBonusPoint
//
//  Created by carladmin on 7/2/14.
//  Copyright (c) 2014 PCCW. All rights reserved.
//

#import "ApiHelper.h"


#define kApiHelper_objDict_summary  @"summary"
#define kApiHelper_ErrorAlertFormat  @"%@ (code %@)"

@implementation ApiHelper
- (id)initWithDict:(NSDictionary*) dict
{
    self = [super init];
    if (self) {
        objDict =  dict;
    }
    return self;
}


-(NSString*) returnCode{
    if ( [objDict objectForKey:kApiHelper_objDict_summary] ) {
        return [[objDict objectForKey:kApiHelper_objDict_summary] objectForKey:@"returnCode"];
    } else {
        if ( [objDict objectForKey:@"returnCode"] ) {
            return [objDict objectForKey:@"returnCode"];
        } else {
            return @"99";
        }

    }

}

-(NSString*) returnErr{
    if ( [objDict objectForKey:kApiHelper_objDict_summary] ) {
        return [[objDict objectForKey:kApiHelper_objDict_summary] objectForKey:@"returnErr"];
    } else {
        if ( [objDict objectForKey:@"returnErr"] ) {
            return [objDict objectForKey:@"returnErr"];
        } else {
            
            return @"";
        }

    }

}

-(NSDictionary *) returnDetail {
    
    if ( [self.returnCode isEqualToString:@"00"] ) {
        return [objDict objectForKey:@"detail"];
    } else {
        return nil;
    }
    
}


-(int) listingCount{
    if ( ! [[objDict objectForKey:kApiHelper_objDict_summary] valueForKey:@"listingCount"]  ) {
        return 0;
    }
    return (int)[[[objDict objectForKey:kApiHelper_objDict_summary] valueForKey:@"listingCount"] intValue];
}

/* ------------------------------ ERROR CODE ------------------------------
 01 – unknown input parameter (eg. number is expected, but string is found)
 02 – unknown value is found in input parameter (eg. no record found while retrieving) 
 11 – incorrect login
 12 – incorrect password
 13 – incorrect member
 14 – inactive
 15 – already registered
 16 – already activated
 17 – info not matched (failure activation)
 21 – permission denied
 31 – not fitted with rule schedule
 32 – no enough points
 33 – no enough products in stock
 34 – branch is required
 35 – membership grading not matched
 41 – failure payment
 42 – incorrect payment gateway
 43 – coupon is invalid
 51 – another shopping cart is checking out
 61 – invalid workflow
 81 – no record found (for “update” / “delete” request) '
 82 – record already existed (for “insert” request)
 83 – no record found (for “select” request)
 91 – custom problem
 92 – new version is released, force updated needed
 ￼93 – new version is released and compatible
 99 – unknown problem
 */


/*
-(BOOL) isSuccessWithErrorAlert: (BOOL)handleErr
{

    if ( [self.returnCode isEqualToString:@"00"] ) {
        return YES;
    } else {
        NSLog(@"API HELPER ERROR CODE: %@", self.returnCode);
        if ( handleErr ) {
            NSString *strMessage;
            if ( [self.returnCode isEqualToString:@"01"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"unknown input parameter"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"02"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"unknown value is found in input parameter"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"11"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"incorrect login"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"12"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"incorrect password"), self.returnCode];
                
            } else if ( [self.returnCode isEqualToString:@"13"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"incorrect member"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"14"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"inactive"), self.returnCode];
                
            } else if ( [self.returnCode isEqualToString:@"15"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"already registered"), self.returnCode];
                
            } else if ( [self.returnCode isEqualToString:@"16"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"already activated"), self.returnCode];
                
            } else if ( [self.returnCode isEqualToString:@"17"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"info not matched (failure activation)"), self.returnCode];
                
            } else if ( [self.returnCode isEqualToString:@"21"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"permission denied"), self.returnCode];
                
            } else if ( [self.returnCode isEqualToString:@"31"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"not fitted with rule schedule"), self.returnCode];
                
            } else if ( [self.returnCode isEqualToString:@"32"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"no enough points"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"33"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"no enough products in stock"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"34"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"branch is required"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"35"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"membership grading not matched"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"41"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"failure payment"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"42"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"incorrect payment gateway"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"43"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"coupon is invalid"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"51"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"another shopping cart is checking out"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"61"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"invalid workflow"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"81"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"no record found (update or delete)"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"82"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"record already existed (insert)"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"83"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"no record found (select)"), self.returnCode];
            
            // 91 – custom problem ????
                
            } else if ( [self.returnCode isEqualToString:@"92"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"new version is released, force updated needed"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"93"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"new version is released and compatible"), self.returnCode];
            
            } else if ( [self.returnCode isEqualToString:@"99"] ) {
                strMessage = [NSString stringWithFormat:kApiHelper_ErrorAlertFormat, LString(@"unknown problem"), self.returnCode];
                
                
            }
            ALERT(LString(@"Server reply message"), strMessage, LString(@"OK"));
        }
        
        return NO;
    }
}

*/
@end
