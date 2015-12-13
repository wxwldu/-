//
//  NSString+Utils.m
//  eClaim
//
//  Created by situ on 7/6/2013.
//  Copyright (c) 2013 pccw. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (int) indexOf:(NSString *)text
{
    NSRange range = [self rangeOfString:text];
    if (range.location != NSNotFound){
        return range.location;
    } else {
        return -1;
    }
}

+ (NSString*)stringWithData:(NSData*)data encoding:(NSStringEncoding)encoding {
	if (data == nil) {
		return nil ;
	}
	return [[NSString alloc] initWithData:data encoding:encoding];
}

+ (NSString*)stringWithDataUTF8:(NSData*)data {
	if (data == nil) {
		return nil ;
	}
	return [self stringWithData:data encoding:NSUTF8StringEncoding] ;
}

@end
