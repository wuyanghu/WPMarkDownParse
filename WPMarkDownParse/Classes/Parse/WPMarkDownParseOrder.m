//
//  WPMarkDownParseOrder.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/19.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseOrder.h"
#import "NSMutableAttributedString+WPAddAttributed.h"

@implementation WPMarkDownParseOrder

- (NSString *)replace:(NSString *)text{
    return text;
}

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    
    for (int i = 0; i<separatedArray.count-1;i++) {
        
        NSString * leftString = separatedArray[i];
        //前n位必须是数字
        NSString * lastString = [self subStringLastNum:leftString];
        if (leftString.length == 0) {
            continue;
        }
        NSArray * rightStringSeparteds = [separatedArray[i+1] componentsSeparatedByString:@"\n\n"];
        if (rightStringSeparteds.count>0) {
            WPMarkDownParseOrderModel * disorderModel = [[WPMarkDownParseOrderModel alloc] initWithSymbol:self.symbol];
            disorderModel.lastString = lastString;
            disorderModel.text = rightStringSeparteds.firstObject;
            
            //如果右侧字符最后是数字，必须截取
            NSString * rightEndNumString = [self subStringLastNum:rightStringSeparteds.firstObject];
            if (rightEndNumString.length>0) {
                disorderModel.text = [disorderModel.text substringToIndex:disorderModel.text.length-rightEndNumString.length];
            }
            [self.segmentArray addObject:disorderModel];
        }
    }
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseOrderModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
            WPMutableParagraphStyleModel * styleModel = [self styleModel];
            make.paragraphStyle([styleModel createParagraphStyle],range);
        }];
    }];
    
}

- (WPMutableParagraphStyleModel *)styleModel{
    WPMutableParagraphStyleModel * styleModel = [WPMutableParagraphStyleModel new];
    styleModel.headIndent = 17;//整体缩进(首行除外)
    styleModel.firstLineHeadIndent = 17;
    styleModel.alignment = NSTextAlignmentLeft;
    return styleModel;
}

@end
