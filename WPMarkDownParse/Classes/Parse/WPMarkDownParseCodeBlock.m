//
//  WPMarkDownParseCodeBlock.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/20.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseCodeBlock.h"
#import "YYText.h"
#import "NSMutableAttributedString+WPAddAttributed.h"

@implementation WPMarkDownParseCodeBlock

#pragma mark - 策略

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    for (int i = 0; i<separatedArray.count-1;i+=2) {
        if ([self isBackslash:separatedArray[i]]) {
            continue;
        }
        WPMarkDownParseCodeBlockModel * blockModel = [[WPMarkDownParseCodeBlockModel alloc] initWithSymbol:self.symbol];
        blockModel.text = separatedArray[i+1];
        [self.segmentArray addObject:blockModel];        
    }
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
        
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseItalicModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
            make.textColor(WP_RGB_COLOR(155, 162, 177),range);
            WPMutableParagraphStyleModel * styleModel = [self styleModel];
            make.paragraphStyle([styleModel createParagraphStyle],range);
        }];
        
        [self setBgColorWithAttributedString:attributedString range:range];
    }];
}

- (void)setBgColorWithAttributedString:(NSMutableAttributedString *)attributedString range:(NSRange)range{
    
    YYTextBorder *border = [YYTextBorder new];
    border.fillColor = WP_RGB_COLOR(30, 33, 39);//背景颜色
    border.strokeColor = [UIColor clearColor];//线条颜色
    border.insets = UIEdgeInsetsMake(-1, 0, -1, 0);
    border.cornerRadius = 3;
    border.lineJoin = kCGLineJoinBevel;

    [attributedString yy_setTextBlockBorder:border.copy range:range];
}

- (WPMutableParagraphStyleModel *)styleModel{
    WPMutableParagraphStyleModel * styleModel = [WPMutableParagraphStyleModel new];
    styleModel.headIndent = 20;//整体缩进(首行除外)
    styleModel.firstLineHeadIndent = 20;
    return styleModel;
}

@end
