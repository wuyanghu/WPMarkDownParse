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

@end


@implementation WPMarkDownBaseParse (Util)

//检查是不是反斜杠
- (BOOL)wp_isBackslash:(NSString *)string{
    NSString * lastOneString = [self wp_lastOneString:string];
    if ([lastOneString isEqualToString:@"\\"]) {
        return YES;
    }
    return NO;
}

//最后一个字符
- (NSString *)wp_lastOneString:(NSString *)string{
    if (string.length == 0) {
        return nil;
    }
    return [string substringFromIndex:string.length-1];
}
//第一个字符
- (NSString *)wp_firstOneString:(NSString *)string{
    if (string.length == 0) {
        return nil;
    }
    return [string substringToIndex:1];
}

//裁剪字符最后几位的数字
- (NSString *)wp_subStringLastNum:(NSString *)text{
    NSInteger i = text.length-1;
    while (i>=0) {
        NSString * lastString = [text substringWithRange:NSMakeRange(i, 1)];
        if ([self wp_isNumberWithStr:lastString]) {
            i--;
        }else{
            break;
        }
    }
    return [text substringFromIndex:i+1];
}
//截取字符的最后几位数字之前的字符
- (NSString *)wp_subLastNumPreString:(NSString *)text{
    NSInteger i = text.length-1;
    while (i>=0) {
        NSString * lastString = [text substringWithRange:NSMakeRange(i, 1)];
        if ([self wp_isNumberWithStr:lastString]) {
            i--;
        }else{
            break;
        }
    }
    if (i<text.length) {
        return [text substringToIndex:i];
    }
    return nil;
}

- (BOOL)wp_isChineseWithText:(NSString *)text{
    NSString *temp = text;
    const char *u8Temp = [temp UTF8String];
    if (3==strlen(u8Temp)){
        return YES;
    }
    return NO;
}

- (BOOL)wp_isNumberWithStr:(NSString *)str {
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}

@end
