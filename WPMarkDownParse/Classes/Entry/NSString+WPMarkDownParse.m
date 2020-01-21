//
//  NSString+WPMarkDownParse.m
//  WPMarkDownParse
//
//  Created by wupeng on 2020/1/20.
//

#import "NSString+WPMarkDownParse.h"
#import "WPMarkDownParseFactory.h"
#import "WPMarkDownMacro.h"
#import <objc/runtime.h>

@implementation NSString (WPMarkDownParse)

- (NSMutableAttributedString *)wp_markDownParse{
    return [WPMarkDownParseFactory parseMarkDownWithText:self];
}

- (NSMutableAttributedString *)wp_markDownParseWithFontSize:(CGFloat)size{
    return [WPMarkDownParseFactory parseMarkDownWithText:self fontSize:size width:WP_ScreenWidth-32];
}

- (NSMutableAttributedString *)wp_markDownParseWithFontSize:(CGFloat)size width:(CGFloat)width{
    return [WPMarkDownParseFactory parseMarkDownWithText:self fontSize:size width:width];
}

- (void)wp_markDownParseWithText:(NSString *)text finishBlock:(void(^)(NSMutableAttributedString * string))block{
    [self.wp_markdownParseFactory parseMarkDownWithText:text finishBlock:block];
}

- (void)parseMarkDownWithText:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width finishBlock:(void (^)(NSMutableAttributedString * string))block{
    [self.wp_markdownParseFactory parseMarkDownWithText:text fontSize:fontSize width:width finishBlock:block];
}

- (WPMarkDownParseFactory *)wp_markdownParseFactory{
    id parseFactory = objc_getAssociatedObject(self, @"wp_markdownParseFactory");
    if (!parseFactory) {
        parseFactory = [WPMarkDownParseFactory new];
        objc_setAssociatedObject(self, @"wp_markdownParseFactory",parseFactory , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return parseFactory;
}

@end

