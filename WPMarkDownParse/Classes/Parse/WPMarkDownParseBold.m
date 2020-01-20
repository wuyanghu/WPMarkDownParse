//
//  WPMarkDownParseBoldModel.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseBold.h"
#import "WPMarkDownConfigShareManager.h"
#import "WPMarkDownParseBaseModel.h"

@implementation WPMarkDownParseBold

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    NSMutableArray * parseArray = [NSMutableArray arrayWithCapacity:separatedArray.count-1];
    
    for (int i = 0; i<separatedArray.count-1;i+=2) {
        WPMarkDownParseBoldModel * titleModel = [[WPMarkDownParseBoldModel alloc] initWithSymbol:self.symbol];
        titleModel.text = separatedArray[i+1];
        [parseArray addObject:titleModel];
    }
    self.segmentArray = parseArray;
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
    
    CGFloat fontSize = [WPMarkDownConfigShareManager sharedManager].defaultFontSize;
    
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseBoldModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
            make.textBoldFont(fontSize+1,range);
            make.textColor([UIColor blackColor],range);
            make.obliqueness(5.0,range);
        }];
        
    }];
}

@end
