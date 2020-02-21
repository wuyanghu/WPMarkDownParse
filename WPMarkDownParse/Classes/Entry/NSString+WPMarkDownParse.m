//
//  NSString+WPMarkDownParse.m
//  WPMarkDownParse
//
//  Created by wupeng on 2020/1/20.
//

#import "NSString+WPMarkDownParse.h"
#import "WPMarkDownParseFade.h"
#import "WPMarkDownMacro.h"
#import <objc/runtime.h>

@implementation NSString (WPMarkDownParse)

- (NSMutableAttributedString *)wp_markDownParse{
    return [self.wp_markdownParseFade parseMarkDownWithText:self];
}

- (NSMutableAttributedString *)wp_markDownParseWithFontSize:(CGFloat)size{
    return [self.wp_markdownParseFade parseMarkDownWithText:self fontSize:size width:WP_ScreenWidth-32];
}

- (NSMutableAttributedString *)wp_markDownParseWithFontSize:(CGFloat)size width:(CGFloat)width{
    return [self.wp_markdownParseFade parseMarkDownWithText:self fontSize:size width:width];
}

- (void)wp_markDownParseWithText:(NSString *)text finishBlock:(void(^)(NSMutableAttributedString * string))block{
    [self.wp_markdownParseFade parseMarkDownWithText:text finishBlock:block];
}

- (void)parseMarkDownWithText:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width finishBlock:(void (^)(NSMutableAttributedString * string))block{
    [self.wp_markdownParseFade parseMarkDownWithText:text fontSize:fontSize width:width finishBlock:block];
}

- (WPMarkDownParseFade *)wp_markdownParseFade{
    id parseFactory = objc_getAssociatedObject(self, @"wp_markdownParseFade");
    if (!parseFactory) {
        parseFactory = [WPMarkDownParseFade new];
        objc_setAssociatedObject(self, @"wp_markdownParseFade",parseFactory , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return parseFactory;
}

@end

