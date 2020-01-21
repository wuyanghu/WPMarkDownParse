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
#import "NSMutableAttributedString+WPAddAttributed.h"
#import "WPMarkDownMacro.h"

@interface WPMarkDownParseFactory()
@property (nonatomic,strong) dispatch_queue_t serialQueue;
@end

@implementation WPMarkDownParseFactory

- (instancetype)init{
    self = [super init];
    if (self) {
        _serialQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark - 异步入口

- (void)parseMarkDownWithText:(NSString *)text finishBlock:(void (^)(NSMutableAttributedString * string))block{
    [self parseMarkDownWithText:text fontSize:16 width:WP_ScreenWidth-32 finishBlock:block];
}

- (void)parseMarkDownWithText:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width finishBlock:(void (^)(NSMutableAttributedString * string))block{
    dispatch_async(_serialQueue, ^{
        NSMutableAttributedString * string = [self.class parseMarkDownWithText:text fontSize:fontSize width:width];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(string);
            }
        });
    });
}

#pragma mark - 同步

+ (NSMutableAttributedString *)parseMarkDownWithText:(NSString *)text{
    return [self parseMarkDownWithText:text fontSize:16 width:WP_ScreenWidth-32];
}

+ (NSMutableAttributedString *)parseMarkDownWithText:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width{
    NSArray * parseArray = [self setUpParseArray];
    for (WPMarkDownBaseParse * parseModel in parseArray) {
        [parseModel configFontSize:fontSize width:width];
        [parseModel segmentString:&text];
    }
    
    [self replaceBackslash:&text];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [self setAttributedDefaultFont:attributedString fontSize:fontSize];
    
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

//替换反斜杠
+ (void)replaceBackslash:(NSString **)text{
    *text = [*text stringByReplacingOccurrencesOfString:@"\\" withString:@""];
}

#pragma mark - 设置属性

+ (void)setAttributedDefaultFont:(NSMutableAttributedString *)attributedString fontSize:(CGFloat)fontSize{
    //设置字体大小
    [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
        make.textFont(fontSize,NSMakeRange(0, attributedString.string.length));
    }];
}

@end
