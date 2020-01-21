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
        WPMarkDownParseItalicModel * titleModel = [[WPMarkDownParseItalicModel alloc] initWithSymbol:self.symbol];
        titleModel.text = separatedArray[i+1];
        [self.segmentArray addObject:titleModel];
    }
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
    
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseItalicModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString yy_setTextGlyphTransform:YYTextCGAffineTransformMakeSkew(-0.3, 0) range:range];
    }];
}

@end
