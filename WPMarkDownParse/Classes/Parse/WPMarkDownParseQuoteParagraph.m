//
//  WPMarkDownParseQuoteParagraph.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/20.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseQuoteParagraph.h"
#import "YYText.h"
#import "NSMutableAttributedString+WPAddAttributed.h"

@implementation WPMarkDownParseQuoteParagraph

#pragma mark - 策略

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    NSMutableArray * parseArray = [NSMutableArray arrayWithCapacity:separatedArray.count-1];
    
    for (int i = 0; i<separatedArray.count-1;i++) {
        if ([self isBackslash:separatedArray[i]]) {
            continue;
        }
        NSArray * rightStringSeparteds = [separatedArray[i+1] componentsSeparatedByString:@"\n\n"];
        if (rightStringSeparteds.count>0) {
            WPMarkDownParseQuoteParagraphModel * paragraphModel = [[WPMarkDownParseQuoteParagraphModel alloc] initWithSymbol:self.symbol];
            paragraphModel.text = rightStringSeparteds.firstObject;
            [self.segmentArray addObject:paragraphModel];
        }
    }
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
        
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseQuoteParagraphModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
            make.textColor(WP_RGB_COLOR(38, 38, 38),range);
            WPMutableParagraphStyleModel * styleModel = [self styleModel];
            make.paragraphStyle([styleModel createParagraphStyle],range);
        }];
        
        [self setBgColorWithAttributedString:attributedString range:range];
    }];
}

- (void)setBgColorWithAttributedString:(NSMutableAttributedString *)attributedString range:(NSRange)range{
    
    YYTextBorder *border = [YYTextBorder new];
    border.strokeWidth = 0;
    border.strokeColor = [UIColor clearColor];//线条颜色
    border.fillColor = WP_RGB_COLOR(235, 235, 235);//背景颜色
    border.cornerRadius = 5; // a huge value
    border.lineJoin = kCGLineJoinBevel;
    
    border.insets = UIEdgeInsetsMake(-2, -5.5, -2, -8);
    [attributedString yy_setTextBlockBorder:border range:range];
}

- (WPMutableParagraphStyleModel *)styleModel{
    WPMutableParagraphStyleModel * styleModel = [WPMutableParagraphStyleModel new];
    styleModel.headIndent = 20;//整体缩进(首行除外)
    styleModel.firstLineHeadIndent = 20;
    styleModel.alignment = NSTextAlignmentJustified;
    return styleModel;
}

@end
