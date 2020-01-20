//
//  WPMarkDownParseFactory.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseFactory.h"
#import "WPMarkDownParseLink.h"
#import "WPMarkDownParseBold.h"
#import "WPMarkDownParseTitle.h"
#import "WPMarkDownParseItalic.h"
#import "WPMarkDownParseDisorder.h"
#import "WPMarkDownParseOrder.h"
#import "WPMarkDownParseImage.h"
#import "WPMarkDownParseCodeBlock.h"
#import "WPMarkDownParseQuoteParagraph.h"
#import "WPMarkDownConfigShareManager.h"
#import "NSMutableAttributedString+WPAddAttributed.h"

@interface WPMarkDownParseFactory()

@end

@implementation WPMarkDownParseFactory

+ (NSMutableAttributedString *)parseMarkDownWithText:(NSString *)text{
    NSArray * parseArray = [self setUpParseArray];
    for (WPMarkDownBaseParse * parseModel in parseArray) {
        [parseModel segmentString:&text];
    }
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [self setAttributedDefaultFont:attributedString];
    
    for (WPMarkDownBaseParse * parseModel in parseArray) {
        [parseModel setAttributedString:attributedString];
    }
    return attributedString;
}

+ (NSArray *)setUpParseArray{
    NSMutableArray<WPMarkDownBaseParse *> * parseArray
    = [NSMutableArray arrayWithObjects:
       [[WPMarkDownParseImage alloc] initWithSymbol:@"]("],
       [[WPMarkDownParseLink alloc] initWithSymbol:@"]("],
       [[WPMarkDownParseQuoteParagraph alloc] initWithSymbol:@"> "],
       [[WPMarkDownParseCodeBlock alloc] initWithSymbol:@"```"],
       nil];
    
    //加粗
    NSArray * boldSymbols = @[@"**",@"__"];
    [boldSymbols enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parseArray addObject:[[WPMarkDownParseBold alloc] initWithSymbol:obj]];
    }];
    
    //斜体
    NSArray * italicSymbols = @[@"*",@"_"];
    [italicSymbols enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parseArray addObject:[[WPMarkDownParseItalic alloc] initWithSymbol:obj]];
    }];
    
    //标题
    for (int i = 6; i>0; i--) {
        [parseArray addObject:[[WPMarkDownParseTitle alloc] initWithLevel:i-1]];
    }
    
    //无序
    NSArray * disOrders = @[@"- "];
    [disOrders enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parseArray addObject:[[WPMarkDownParseDisorder alloc] initWithSymbol:obj]];
    }];
    
    //有序
    NSArray * orders = @[@". "];
    [orders enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parseArray addObject:[[WPMarkDownParseOrder alloc] initWithSymbol:obj]];
    }];
    return parseArray;
}

#pragma mark - 设置属性

+ (void)setAttributedDefaultFont:(NSMutableAttributedString *)attributedString{
    //设置字体大小
    [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
        CGFloat fontSize = [WPMarkDownConfigShareManager sharedManager].defaultFontSize;
        make.textFont(fontSize,NSMakeRange(0, attributedString.string.length));
    }];
}

@end
