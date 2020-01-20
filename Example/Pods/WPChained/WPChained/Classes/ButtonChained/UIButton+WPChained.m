//
//  UIButton+WPChained.m
//  DataStructureDemo
//
//  Created by ruantong on 2019/11/13.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import "UIButton+WPChained.h"
#import "WPButtonChainedMaker.h"
#import <objc/runtime.h>

@implementation UIButton (WPChained)

+ (UIButton *)createButton{
    return [UIButton buttonWithType:UIButtonTypeCustom];
}

- (UIButton *)wp_makeProperty:(ChainedButtonMakerBlock)block {
    WPButtonChainedMaker *constraintMaker = [self constraintMaker];
    if (!constraintMaker) {
        constraintMaker = [[WPButtonChainedMaker alloc] initWithButton:self];
        [self setConstraintMaker:constraintMaker];
    }
    block(constraintMaker);
    return self;
}

- (WPButtonChainedMaker *)constraintMaker{
    return objc_getAssociatedObject(self, @selector(constraintMaker));
}

- (void)setConstraintMaker:(WPButtonChainedMaker *)constraintMaker{
    objc_setAssociatedObject(self, @selector(constraintMaker), constraintMaker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
