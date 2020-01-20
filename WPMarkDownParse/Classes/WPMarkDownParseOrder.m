//
//  WPMarkDownParseOrder.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/19.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseOrder.h"

@implementation WPMarkDownParseOrder

- (NSString *)replace:(NSString *)text{
    return text;
}

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    NSMutableArray * parseArray = [NSMutableArray arrayWithCapacity:separatedArray.count-1];
    
    for (int i = 0; i<separatedArray.count-1;i++) {
        
        NSString * leftString = separatedArray[i];
        //前n位必须是数字
        NSString * lastString = [self subStringLastNum:leftString];
        if (leftString.length == 0) {
            continue;
        }
        WPMarkDownParseOrderModel * disorderModel = [[WPMarkDownParseOrderModel alloc] initWithSymbol:self.symbol];
        NSArray * rightStringSeparteds = [separatedArray[i+1] componentsSeparatedByString:@"\n\n"];
        if (rightStringSeparteds.count>0) {
            disorderModel.lastString = lastString;
            disorderModel.text = rightStringSeparteds.firstObject;
            
            //如果右侧字符最后是数字，必须截取
            NSString * rightEndNumString = [self subStringLastNum:rightStringSeparteds.firstObject];
            if (rightEndNumString.length>0) {
                disorderModel.text = [disorderModel.text substringToIndex:disorderModel.text.length-rightEndNumString.length];
            }
            [parseArray addObject:disorderModel];
        }
    }
    self.segmentArray = parseArray;
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
    styleModel.headIndent = 20;//整体缩进(首行除外)
    styleModel.firstLineHeadIndent = 20;
    return styleModel;
}

#pragma mark - private

//裁剪字符最后几位的数字
- (NSString *)subStringLastNum:(NSString *)text{
    NSInteger i = text.length-1;
    while (i>=0) {
        NSString * lastString = [text substringWithRange:NSMakeRange(i, 1)];
        if ([self isNumberWithStr:lastString]) {
            i--;
        }else{
            break;
        }
    }
    return [text substringFromIndex:i+1];
}

- (BOOL)isNumberWithStr:(NSString *)str {
   if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];

}

@end
