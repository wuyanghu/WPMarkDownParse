//
//  Targets_WPMarkDownParse.m
//  WPMarkDownParse
//
//  Created by wupeng on 2020/3/6.
//

#import "Target_WPMarkDownParse.h"
#import "NSString+WPMarkDownParse.h"
@implementation Target_WPMarkDownParse

- (NSMutableAttributedString *)Action_markDownParseText:(NSDictionary *)params{
    NSString * text = params[@"text"];
    CGFloat size = [params[@"size"] floatValue];
    return [text wp_markDownParseWithFontSize:size];
}

@end
