//
//  UIView+Frame.m
//  CoreTextDemo
//
//  Created by 夏远全 on 16/12/25.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

-(CGFloat)y{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

-(CGFloat)height{
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

-(CGFloat)width{
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint newCenter = self.center;
    newCenter.x       = centerX;
    self.center       = newCenter;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint newCenter = self.center;
    newCenter.y       = centerY;
    self.center       = newCenter;
}


- (CGFloat)middleX {
    return CGRectGetWidth(self.bounds) / 2.f;
}

- (CGFloat)middleY {
    return CGRectGetHeight(self.bounds) / 2.f;
}

- (CGPoint)middlePoint {
    return CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect newFrame   = self.frame;
    newFrame.origin.x = right - self.frame.size.width;
    self.frame        = newFrame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect newFrame   = self.frame;
    newFrame.origin.y = bottom - self.frame.size.height;
    self.frame        = newFrame;
}

@end

@implementation UIView(WP_TapGesture)

- (void)wp_addTapGestureWithAction:(SEL)selector{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:selector];
    [self addGestureRecognizer:tap];
}

- (void)wp_addPanGestureWithTarget:(id)target action:(SEL)selector{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:target action:selector];
    [self addGestureRecognizer:panGesture];
}

@end
