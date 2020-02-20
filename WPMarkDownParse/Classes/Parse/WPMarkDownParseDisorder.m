//
//  WPMarkDownParseDisorder.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/19.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseDisorder.h"
#import "NSMutableAttributedString+WPAddAttributed.h"

@implementation WPMarkDownParseDisorder

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    
    for (int i = 0; i<separatedArray.count-1;i++) {
        
        NSString * leftString = separatedArray[i];
        if ([self wp_isBackslash:leftString]) {
            continue;
        }
        //必须是段落第一位，中间的-不解析
        NSString * lastOneString = [self wp_lastOneString:leftString];
        if (!lastOneString || [lastOneString isEqualToString:@"\n"]) {

        }else{
            continue;
        }
        
        WPMarkDownParseDisorderModel * disorderModel = [[WPMarkDownParseDisorderModel alloc] initWithSymbol:self.symbol];
        NSString * rightString = separatedArray[i+1];

        NSRange range = [rightString rangeOfString:@"\n\n"];
        NSRange orderRange = [rightString rangeOfString:kWPOrderSymbol];
        
        if (range.location != NSNotFound && orderRange.location != NSNotFound) {
            if (range.location<orderRange.location) {
                disorderModel.text = [rightString substringToIndex:range.location];
            }else{
                disorderModel.depath = 1;
                NSString * text = [rightString substringToIndex:orderRange.location];
                disorderModel.text = [self wp_subLastNumPreString:text];
            }
        }else if (range.location != NSNotFound) {
            disorderModel.text = [rightString substringToIndex:range.location];
        }else if (orderRange.location != NSNotFound){
            disorderModel.depath = 1;
            NSString * text = [rightString substringToIndex:orderRange.location];
            disorderModel.text = [self wp_subLastNumPreString:text];
        }else{
            disorderModel.text = rightString;
        }
        [self.segmentArray addObject:disorderModel];

    }
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseItalicModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
            WPMutableParagraphStyleModel * styleModel = [self styleModel:obj.depath];
            make.paragraphStyle([styleModel createParagraphStyle],range);
        }];
    }];
    
}

- (WPMutableParagraphStyleModel *)styleModel:(NSInteger)depath{
    WPMutableParagraphStyleModel * styleModel = [WPMutableParagraphStyleModel new];
    styleModel.headIndent = (depath+1)*17;//整体缩进(首行除外)
    styleModel.firstLineHeadIndent = (depath+1)*17;
    styleModel.alignment = NSTextAlignmentLeft;
    return styleModel;
}

@end
