//
//  NSMutableAttributedString+WPAddAttributed.m
//  DataStructureDemo
//
//  Created by wupeng on 2019/11/30.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import "NSMutableAttributedString+WPAddAttributed.h"
#import "WPMutableAttributedStringMaker.h"

@implementation NSMutableAttributedString (WPAddAttributed)

- (NSMutableAttributedString *)wp_makeAttributed:(ChainedMutableStringMakerBlock)block{
    WPMutableAttributedStringMaker * maker = [[WPMutableAttributedStringMaker alloc] initWithMutableAttributedString:self];
    block(maker);
    return self;
}

@end
