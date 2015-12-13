//
//  Common.m
//  MembershipBonusPoint
//
//  Created by Anna on 13-8-9.
//  Copyright (c) 2013年 PCCW. All rights reserved.
//

#import "Common.h"

@implementation Common
@synthesize delegate;
@synthesize baseUrl;
@synthesize path;

@synthesize request;

-(id)init
{
    self = [super init];
    if(self)
    {
//        baseUrl = [NSURL URLWithString:MBPBaseURL];
    }
    return self;
}
-(void)login_Api03_WithMerchantId:(int)_merchantId
                         andEmail:(NSString *)_email
                           andPwd:(NSString *)_password
                          success:(void (^)(NSDictionary *dict))success
                          failure:(void (^)(NSError *error))failure
{
//    path = @"/MBP/ws/rs/loginService/getUserCheckLogin.json";
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:[NSNumber numberWithInt:_merchantId] forKey:@"merchantId"];
//    [dic setObject:_email forKey:@"userEmail"];
//    [dic setObject:_password forKey:@"password"];
//    
//    httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];
//    request = [httpClient requestWithMethod:@"POST" path:path parameters:dic];
//    [request setTimeoutInterval:kDataExpiryTime];
//    
//    AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData
//                                                              options:NSJSONReadingMutableContainers
//                                                                error:nil];
//         DLog(@"json  %@", json);
//         success(json);
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         failure(error);
//     }];
//    [operation start];
}


#pragma mark -
#pragma mark - delegate
-(void)getResultSuccess:(NSDictionary *)json WithTag:(int)tag
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(getApiResultSucces:andApiTag:)])
    {
        NSLog(@"json %d %@",tag, json);
        [self.delegate getApiResultSucces:json andApiTag:tag];
    }
}

-(void)getResultFailed:(NSError *)err
{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(getApiResultFailed:)])
    {
        [self.delegate getApiResultFailed:err];
    }
}

@end
