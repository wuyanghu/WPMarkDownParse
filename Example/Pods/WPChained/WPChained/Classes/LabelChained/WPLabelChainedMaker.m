//
//  LabelChainedMaker.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/2.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPLabelChainedMaker.h"

@interface WPLabelChainedMaker()
@property (nonatomic,weak) UILabel * label;
@end

@implementation WPLabelChainedMaker

- (instancetype)initWithLabel:(UILabel *)label{
    self = [super init];
    if (self) {
        _label = label;
    }
    return self;
}

- (ChainedLabelFrameBlock)frame{
    ChainedLabelFrameBlock block = ^WPLabelChainedMaker *(CGRect frame){
        self.label.frame = frame;
        return self;
    };
    return block;
}

- (ChainedLabelBlock)font{
    ChainedLabelBlock block = ^WPLabelChainedMaker *(id font){
        self.label.font = font;
        return self;
    };
    return block;
}

- (ChainedLabelBlock)text{
    ChainedLabelBlock block = ^WPLabelChainedMaker *(id text){
        self.label.text = text;
        return self;
    };
    return block;
}

- (ChainedLabelBlock)textColor{
    ChainedLabelBlock block = ^WPLabelChainedMaker *(id color){
        self.label.textColor = color;
        return self;
    };
    return block;
}

- (ChainedLabelBlock)bgColor{
    ChainedLabelBlock block = ^WPLabelChainedMaker *(id color){
        self.label.backgroundColor = (UIColor *)color;
        return self;
    };
    return block;
}

@end
