//
//  UIView+Frame.h
//  CoreTextDemo
//
//  Created by 夏远全 on 16/12/25.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (Frame)

-(CGFloat)x;
-(void)setX:(CGFloat)x;

-(CGFloat)y;
-(void)setY:(CGFloat)y;

-(CGFloat)height;
-(void)setHeight:(CGFloat)height;

-(CGFloat)width;
-(void)setWidth:(CGFloat)width;

- (void)setCenterX:(CGFloat)centerX;
- (CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (CGFloat)centerY;

- (CGFloat)middleX;
- (CGFloat)middleY;
- (CGPoint)middlePoint;

- (void)setRight:(CGFloat)right;
- (CGFloat)right;

- (void)setBottom:(CGFloat)bottom;
- (CGFloat)bottom;
@end

@interface UIView(WP_TapGesture)
- (void)wp_addTapGestureWithAction:(SEL)selector;
- (void)wp_addPanGestureWithTarget:(id)target action:(SEL)selector;
@end
