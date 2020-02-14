//
//  WPMarkDownParseItalic.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/19.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseItalic.h"
#import "YYText.h"

@implementation WPMarkDownParseItalic

#pragma mark - 策略

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    
    for (int i = 0; i<separatedArray.count-1;i+=2) {
        NSString * leftString = separatedArray[i];
        if ([self isBackslash:leftString]) {
            continue;
        }
        NSString * rightString = separatedArray[i+1];
        NSString * leftLastString = [self lastOneString:leftString];
        NSString * rightFirstString = [self firstOneString:rightString];
        if (leftLastString && ![self isChineseWithText:leftLastString]) {//字符不为空，左边最后一个字符是中文
            continue;
        }
        if (rightFirstString && ![self isChineseWithText:rightFirstString]) {//字符不为空，右边第一个字符是中文
            continue;
        }
        WPMarkDownParseItalicModel * titleModel = [[WPMarkDownParseItalicModel alloc] initWithSymbol:self.symbol];
        titleModel.text = rightString;
        [self.segmentArray addObject:titleModel];
    }
}

- (BOOL)isChineseWithText:(NSString *)text{
    NSString *temp = text;
    const char *u8Temp = [temp UTF8String];
    if (3==strlen(u8Temp)){
        return YES;
    }
    return NO;
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
    
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseItalicModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString yy_setTextGlyphTransform:YYTextCGAffineTransformMakeSkew(-0.3, 0) range:range];
    }];
}

@end
