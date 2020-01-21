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
        if ([self isBackslash:leftString]) {
            continue;
        }
        //必须是段落第一位，中间的-不解析
        if (leftString.length>0) {
            if (![[leftString substringFromIndex:leftString.length-1] isEqualToString:@"\n"]) {
                continue;
            }
        }
        
        NSArray * rigthSeparteds = [separatedArray[i+1] componentsSeparatedByString:@"\n\n"];
        if (rigthSeparteds.count>0) {
            WPMarkDownParseDisorderModel * disorderModel = [[WPMarkDownParseDisorderModel alloc] initWithSymbol:self.symbol];
            disorderModel.text = rigthSeparteds.firstObject;
            [self.segmentArray addObject:disorderModel];
        }        
    }
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseItalicModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
            WPMutableParagraphStyleModel * styleModel = [self styleModel];
            make.paragraphStyle([styleModel createParagraphStyle],range);
        }];
    }];
    
}

- (WPMutableParagraphStyleModel *)styleModel{
    WPMutableParagraphStyleModel * styleModel = [WPMutableParagraphStyleModel new];
    styleModel.headIndent = 20;//整体缩进(首行除外)
    styleModel.firstLineHeadIndent = 20;
    styleModel.alignment = NSTextAlignmentJustified;
    return styleModel;
}

@end
