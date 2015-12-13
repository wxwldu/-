//
//  MainViewController.h
//  TKContactsMultiPicker
//
//  Created by Jongtae Ahn on 12. 8. 31..
//  Copyright (c) 2012년 TABKO Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TKAddressBook : NSObject {
    NSInteger sectionNumber;
    NSInteger recordID;
    BOOL rowSelected;
    NSString *name;
    NSString *email;
    NSString *telephone;
    UIImage *thumbnail;
}

@property NSInteger sectionNumber;
@property NSInteger recordID;
@property BOOL rowSelected;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *telephone;
@property (nonatomic, retain) UIImage *thumbnail;

@end