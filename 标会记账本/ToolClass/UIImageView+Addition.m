//
//  UIImageView+Addition.m
//  MembershipBonusPoint
//
//  Created by apple on 13-9-9.
//  Copyright (c) 2013年 PCCW. All rights reserved.
//

#define kCoverViewTag           1234
#define kImageViewTag           1235
#define kAnimationDuration      0.3f
#define kImageViewWidth         280.0f
#define kBackViewColor          [UIColor colorWithWhite:0.667 alpha:0.8f]

#import "UIImageView+Addition.h"

@implementation UIImageView (Addition)

- (void)hiddenView
{
    UIView *coverView = (UIView *)[[self window] viewWithTag:kCoverViewTag];
    [coverView removeFromSuperview];
}

- (void)hiddenViewAnimation
{
    UIImageView *imageView = (UIImageView *)[[self window] viewWithTag:kImageViewTag];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration]; //动画时长
    CGRect rect = [self convertRect:self.bounds toView:self.window];
    imageView.frame = rect;
    [UIView commitAnimations];
    [self performSelector:@selector(hiddenView) withObject:nil afterDelay:kAnimationDuration];
    
}


- (CGRect)autoFitFrame
{
    float width = kImageViewWidth;
    float targeHeight = (width*self.frame.size.height)/self.frame.size.width;
    UIView *coverView = [[self window] viewWithTag:kCoverViewTag];
    CGRect targeRect = CGRectMake(coverView.frame.size.width/2 - width/2, coverView.frame.size.height/2 - targeHeight, width, targeHeight*2);
    return targeRect;
}

- (void)imageTap
{
    UIView *coverView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//获取当前视图的大小;
    coverView.backgroundColor = kBackViewColor;
    NSLog(@"coverView%@",coverView);
    coverView.tag = kCoverViewTag;
    UITapGestureRecognizer *hiddenViewGecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenViewAnimation)];
    [coverView addGestureRecognizer:hiddenViewGecognizer];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    imageView.tag = kImageViewTag;
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = self.contentMode;
    CGRect rect = [self convertRect:self.bounds toView:self.window];
    imageView.frame = rect;
    
    [coverView addSubview:imageView];
    [[self window] addSubview:coverView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    imageView.frame = [self autoFitFrame];
    [UIView commitAnimations];
}

- (void)addDetailShow
{
    self.userInteractionEnabled = YES;//能与用户交互. 当试图对象的userInteractionEanbled设置为NO的时候，用户触发的事件，如触摸， 键盘等， 将会被该试图忽略（其他视图正常响应），并且该试图对象也会从事件响应队列中被移除;  默认值是YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];//添加一个手势;
    [self addGestureRecognizer:tapGestureRecognizer];//把手势添加到试图上;
}

@end
