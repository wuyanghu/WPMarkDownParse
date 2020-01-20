//
//  UILabel+WPChained.m
//  DataStructureDemo
//
//  Created by wupeng on 2019/10/31.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import "UILabel+WPChained.h"

@implementation UILabel (WPChained)

+ (UILabel *)createLabel{
    return [[UILabel alloc] init];
}

- (UILabel *)wp_makeProperty:(ChainedLabelMakerBlock)block{
    WPLabelChainedMaker * maker = [[WPLabelChainedMaker alloc] initWithLabel:self];
    block(maker);
    return self;
}

@end
