//
//  NSString+WPMarkDownParse.h
//  WPMarkDownParse
//
//  Created by wupeng on 2020/1/20.
//

#import <Foundation/Foundation.h>
#import "WPMarkDownParseFade.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSString (WPMarkDownParse)
@property (nonatomic,strong,readonly) WPMarkDownParseFade * wp_markdownParseFade;
//同步
- (NSMutableAttributedString *)wp_markDownParse;
- (NSMutableAttributedString *)wp_markDownParseWithFontSize:(CGFloat)size;
- (NSMutableAttributedString *)wp_markDownParseWithFontSize:(CGFloat)size width:(CGFloat)width;
//异步入口
- (void)wp_markDownParseWithText:(NSString *)text finishBlock:(void(^)(NSMutableAttributedString * string))block;
- (void)parseMarkDownWithText:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width finishBlock:(void (^)(NSMutableAttributedString * string))block;
@end

NS_ASSUME_NONNULL_END

