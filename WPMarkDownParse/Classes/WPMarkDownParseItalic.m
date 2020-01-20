//
//  WPMarkDownParseItalic.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/19.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseItalic.h"
#import "WPSettingConfigSharedManager.h"
#import "YYText.h"

@implementation WPMarkDownParseItalic

#pragma mark - 策略

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    NSMutableArray * parseArray = [NSMutableArray arrayWithCapacity:separatedArray.count-1];
    
    for (int i = 0; i<separatedArray.count-1;i+=2) {
        WPMarkDownParseItalicModel * titleModel = [[WPMarkDownParseItalicModel alloc] initWithSymbol:self.symbol];
        titleModel.text = separatedArray[i+1];
        [parseArray addObject:titleModel];
    }
    self.segmentArray = parseArray;
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
        
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseItalicModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString yy_setTextGlyphTransform:YYTextCGAffineTransformMakeSkew(-0.3, 0) range:range];
    }];
}

@end
