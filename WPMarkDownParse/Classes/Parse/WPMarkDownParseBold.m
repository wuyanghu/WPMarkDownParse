//
//  WPMarkDownParseBoldModel.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseBold.h"
#import "WPMarkDownParseBaseModel.h"
#import "NSMutableAttributedString+WPAddAttributed.h"

@implementation WPMarkDownParseBold

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    
    for (int i = 0; i<separatedArray.count-1;i+=2) {
        if ([self wp_isBackslash:separatedArray[i]]) {
            continue;
        }
        NSString * leftString = separatedArray[i];
        NSString * rightString = separatedArray[i+1];
        NSString * leftLastString = [self wp_lastOneString:leftString];
        NSString * rightFirstString = [self wp_firstOneString:rightString];
        if (leftLastString && ![self wp_isChineseWithText:leftLastString]) {//字符不为空，左边最后一个字符是中文
            continue;
        }
        if (rightFirstString && ![self wp_isChineseWithText:rightFirstString]) {//字符不为空，右边第一个字符是中文
            continue;
        }
        
        WPMarkDownParseBoldModel * titleModel = [[WPMarkDownParseBoldModel alloc] initWithSymbol:self.symbol];
        titleModel.text = separatedArray[i+1];
        [self.segmentArray addObject:titleModel];
    }
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
        
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseBoldModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
            make.textBoldFont(self.defaultFontSize+1,range);
            make.textColor([UIColor blackColor],range);
            make.obliqueness(5.0,range);
        }];
        
    }];
}

@end
