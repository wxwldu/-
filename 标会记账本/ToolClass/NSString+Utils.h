//
//  NSString+Utils.h
//  eClaim
//
//  Created by situ on 7/6/2013.
//  Copyright (c) 2013 pccw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

// if not found, return -1
- (int) indexOf:(NSString *)text;

+ (NSString*)stringWithData:(NSData*)data encoding:(NSStringEncoding)encoding;

+ (NSString*)stringWithDataUTF8:(NSData*)data;

@end
