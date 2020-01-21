//
//  WPMarkDownParseBaseModel.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownBaseParse.h"
#import "WPMarkDownParseBaseModel.h"

@implementation WPMarkDownBaseParse

- (id)initWithSymbol:(NSString *)symbol{
    self = [super init];
    if (self) {
        _symbol = symbol;
    }
    return self;
}

- (void)configFontSize:(CGFloat)size width:(CGFloat)width{
    _defaultWidth = width;
    _defaultFontSize = size;
}

//模板模式
- (void)segmentString:(NSString**)text{
    //通过符号进行分割
    NSArray * separatedArray = [*text componentsSeparatedByString:self.symbol];
    if (separatedArray.count>0) {
        self.segmentArray = [NSMutableArray arrayWithCapacity:separatedArray.count-1];
        [self segmentString:separatedArray text:*text];
        *text = [self replace:*text];
    }
}

- (NSString *)replace:(NSString *)text{
    __block NSString * replaceAfter = text;
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseBaseModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        replaceAfter = [replaceAfter stringByReplacingOccurrencesOfString:[obj willBeReplacedString] withString:[obj replaceString]];
    }];
    return replaceAfter;
}

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text {
    
}


- (void)setAttributedString:(NSMutableAttributedString *)attributedString {
    
}

//检查是不是反斜杠
- (BOOL)isBackslash:(NSString *)string{
    NSString * lastOneString = [self lastOneString:string];
    if ([lastOneString isEqualToString:@"\\"]) {
        return YES;
    }
    return NO;
}

//最后一个字符
- (NSString *)lastOneString:(NSString *)string{
    if (string.length == 0) {
        return nil;
    }
    return [string substringFromIndex:string.length-1];
}
//第一个字符
- (NSString *)firstOneString:(NSString *)string{
    if (string.length == 0) {
        return nil;
    }
    return [string substringToIndex:1];
}

@end
