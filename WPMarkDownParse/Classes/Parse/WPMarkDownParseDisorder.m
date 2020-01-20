//
//  WPMarkDownParseDisorder.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/19.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseDisorder.h"

@implementation WPMarkDownParseDisorder

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    NSMutableArray * parseArray = [NSMutableArray arrayWithCapacity:separatedArray.count-1];
    
    for (int i = 0; i<separatedArray.count-1;i++) {
        WPMarkDownParseDisorderModel * disorderModel = [[WPMarkDownParseDisorderModel alloc] initWithSymbol:self.symbol];
        
        NSString * leftString = separatedArray[i];
        //必须是段落第一位，中间的-不解析
        NSString * lastString;
        if (leftString.length>0) {
            lastString = [leftString substringWithRange:NSMakeRange(leftString.length-1, 1)];
            if (![lastString isEqualToString:@"\n"]) {
                continue;
            }
        }
        
        NSArray * rigthSeparteds = [separatedArray[i+1] componentsSeparatedByString:@"\n\n"];
        if (rigthSeparteds.count>0) {
            disorderModel.text = rigthSeparteds.firstObject;
            [parseArray addObject:disorderModel];
        }
        
    }
    self.segmentArray = parseArray;
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
    return styleModel;
}

@end
