//
//  WPMarkDownParseBaseModel.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownBaseParse.h"
#import "WPMarkDownParseBaseModel.h"

@implementation WPMarkDownBaseParse

- (id)initWithSymbol:(NSString *)symbol{
    self = [super init];
    if (self) {
        _symbol = symbol;
    }
    return self;
}

//模板模式
- (void)segmentString:(NSString**)text{
    //通过符号进行分割
    NSArray * separatedArray = [*text componentsSeparatedByString:self.symbol];
    if (separatedArray.count>0) {
        [self segmentString:separatedArray text:*text];
        *text = [self replace:*text];
    }
}

- (NSString *)replace:(NSString *)text{
    __block NSString * replaceAfter = text;
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseBaseModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        replaceAfter = [replaceAfter stringByReplacingOccurrencesOfString:[obj willBeReplacedString] withString:[obj replaceString]];
    }];
    return replaceAfter;
}

@end
