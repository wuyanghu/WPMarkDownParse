//
//  ViewChainedMaker.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/2.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPButtonChainedMaker.h"
#import <objc/runtime.h>
#define BUTTON_ACTION @"button_action"

@interface WPButtonChainedMaker()
@property (nonatomic,weak) UIButton * button;
@end

@implementation WPButtonChainedMaker

- (instancetype)initWithButton:(UIButton *)button{
    self = [super init];
    if (self) {
        _button = button;
    }
    return self;
}

- (ChainedButtonFrameBlock)frame{
    ChainedButtonFrameBlock block = ^WPButtonChainedMaker *(CGRect frame){
        self.button.frame = frame;
        return self;
    };
    return block;
}

- (ChainedButtonBlock)title{
    ChainedButtonBlock block = ^WPButtonChainedMaker *(id title,UIControlState state){
        [self.button setTitle:title forState:state];
        return self;
    };
    return block;
}

- (ChainedButtonBlock)titleColor{
    ChainedButtonBlock block = ^WPButtonChainedMaker *(id color,UIControlState state){
        [self.button setTitleColor:color forState:state];
        return self;
    };
    return block;
}

- (ChainedButtonBlock)image{
    ChainedButtonBlock block = ^WPButtonChainedMaker *(id image,UIControlState state){
        [self.button setImage:image forState:state];
        return self;
    };
    return block;
}

- (ChainedButtonBlock)bgImage{
    ChainedButtonBlock block = ^WPButtonChainedMaker *(id image,UIControlState state){
        [self.button setBackgroundImage:image forState:state];
        return self;
    };
    return block;
}

- (ChainedButtonColorBlock)bgColor{
    ChainedButtonColorBlock block = ^WPButtonChainedMaker *(id color){
        [self.button setBackgroundColor:color];
        return self;
    };
    return block;
}

- (ChainedButtonArg1Block)cornerRadius{
    ChainedButtonArg1Block block = ^WPButtonChainedMaker *(id corner){
        self.button.layer.cornerRadius = [corner integerValue];
        self.button.layer.masksToBounds = YES;
        return self;
    };
    return block;
}

- (ChainedButtonArg1Block)contentHorizontalAlignment{
    ChainedButtonArg1Block block = ^WPButtonChainedMaker *(id alignment){
        [self.button setContentHorizontalAlignment:[alignment intValue]];
        return self;
    };
    return block;
}

- (ChainedButtonActionCallBlock)addTarget{
    
    ChainedButtonActionCallBlock block = ^WPButtonChainedMaker *(ChainedButtonActionCallParamsBlock paramsBlock){
        [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(self, BUTTON_ACTION, paramsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        return self;
    };
    return block;
}



//在category只有通过关联对象
- (void)buttonAction:(UIButton *)button{
    ChainedButtonActionCallParamsBlock callBlock = objc_getAssociatedObject(self, BUTTON_ACTION);
    if (callBlock) {
        callBlock(button);
    }
}


@end
