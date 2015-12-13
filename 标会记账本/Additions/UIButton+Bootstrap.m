//
//  UIButton+Bootstrap.m
//  UIButton+Bootstrap
//
//  Created by Oskur on 2013-09-29.
//  Copyright (c) 2013 Oskar Groth. All rights reserved.
//
#import "UIButton+Bootstrap.h"
#import <QuartzCore/QuartzCore.h>
#import "MBPConfig.h"


@implementation UIButton (Bootstrap)

//模式1
-(void)normalStyle{
    
    self.layer.masksToBounds = YES;
    [self.layer setCornerRadius:8];
//    [self.layer setBorderColor:MBPGreenColorCopy.CGColor];
//    [self.layer setBorderWidth:2];
    
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundColor:MBPGreenColor];
    
//    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
//    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
//    [self setBackgroundImage:[self buttonImageFromColor:[UIColor grayColor]] forState:UIControlStateDisabled];
}

//模式2
-(void)normalStyleTwo{
    
    self.layer.masksToBounds = YES;
    [self.layer setCornerRadius:6];
    [self.layer setBorderColor:MBPGreenColor.CGColor];
    [self.layer setBorderWidth:1];
    
    [self setAdjustsImageWhenHighlighted:NO];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setTitleColor:MBPGreenColor forState:UIControlStateNormal];
//    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
//    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
    //    [self setBackgroundImage:[self buttonImageFromColor:[UIColor grayColor]] forState:UIControlStateDisabled];
}



-(void)bootstrapStyle{
    self.layer.cornerRadius = 3.0;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
//    [self setBackgroundImage:[self buttonImageFromColor:[UIColor grayColor]] forState:UIControlStateDisabled];
}

-(void)defaultStyle{
    [self bootstrapStyle];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 1;
    self.layer.borderColor = MBPGreenColorCopy.CGColor;
//    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)cancelStyle{
    
    [self setTitleColor:MBPGreenColorCopy forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.backgroundColor = [UIColor whiteColor];
//    [self setBackgroundImage:[self buttonImageFromColor:RGBCOLOR(243, 243, 243)] forState:UIControlStateHighlighted];
}

-(void)primaryStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:66/255.0 green:139/255.0 blue:202/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:53/255.0 green:126/255.0 blue:189/255.0 alpha:1] CGColor];
//    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:51/255.0 green:119/255.0 blue:172/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)successStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:1];
//    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:69/255.0 green:164/255.0 blue:84/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)infoStyle{
    
    
    [self normalStyle];
//    self.backgroundColor = RGBCOLOR(58, 181, 233);
//    self.layer.borderColor = kbColor.CGColor;
//    [self setBackgroundImage:[self buttonImageFromColor:RGBCOLOR(126, 196, 236)] forState:UIControlStateHighlighted];
    [self setTitleColor:MBPGreenColorCopy forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    //    //将图片中间拉伸 两边不动
    UIImage *imageNormal =[UIImage imageNamed:@"loginRegisterNormal.png"];
   imageNormal = [imageNormal resizableImageWithCapInsets:UIEdgeInsetsMake(imageNormal.size.height/2, imageNormal.size.width/2, imageNormal.size.height/2, imageNormal.size.width/2)];
    UIImage *imageSelect =[UIImage imageNamed:@"loginRegisterSelect"];
    imageSelect =[imageSelect resizableImageWithCapInsets:UIEdgeInsetsMake(imageSelect.size.height/2, imageSelect.size.width/2, imageSelect.size.height/2, imageSelect.size.width/2)];
    
//    imageSelect =[imageSelect stretchableImageWithLeftCapWidth:floorf(imageSelect.size.width/2) topCapHeight:floorf(imageSelect.size.height/2)];
    
//    [self setContentMode:UIViewContentModeScaleAspectFit];
    [self setBackgroundImage:imageSelect forState:UIControlStateHighlighted];
//    [self setBackgroundImage:imageNormal forState:UIControlStateNormal];
//    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    
}

-(void)navStyle{
    [self bootstrapStyle];
//    self.backgroundColor = kbColor;
//    [self setBackgroundImage:[self buttonImageFromColor:RGBCOLOR(83, 167, 40)] forState:UIControlStateHighlighted];
}

-(void)blackStyle {
    self.titleLabel.font = [UIFont systemFontOfSize:14];
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = RGBCOLOR(39, 39, 39).CGColor;
//    [self setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(100, 100, 100) cornerRadius:0] forState:UIControlStateHighlighted];
}

-(void)navBlackStyle{
    self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//    self.backgroundColor = RGBCOLOR(47, 97, 230);
//    self.layer.masksToBounds = YES;
//    self.layer.borderColor = RGBCOLOR(0, 84, 230).CGColor;
//    self.layer.cornerRadius = 2;
//    [self setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(100, 100, 100) cornerRadius:0] forState:UIControlStateHighlighted];
}

-(void)warningStyle{
    [self bootstrapStyle];
//    self.backgroundColor = RGBCOLOR(255, 184, 35);
    self.layer.borderColor = self.backgroundColor.CGColor;
//    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:237/255.0 green:155/255.0 blue:67/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

- (void)commonStyle {
    self.layer.cornerRadius = 4;
//    self.backgroundColor = RGBCOLOR(0, 200, 247);;
//    [self setBackgroundImage:[self buttonImageFromColor:kbColor] forState:UIControlStateHighlighted];
}

-(void)dangerStyle{
    [self bootstrapStyle];
//    self.backgroundColor = RGBCOLOR(197, 1, 44);
//    self.layer.borderColor = [RGBCOLOR(198, 36, 59) CGColor];
//    [self setBackgroundImage:[self buttonImageFromColor:kbColor] forState:UIControlStateHighlighted];
}



@end
