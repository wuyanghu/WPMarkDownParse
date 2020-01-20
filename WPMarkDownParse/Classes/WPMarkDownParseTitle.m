//
//  WPMarkDownParseTitleModel.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseTitle.h"
#import "WPSettingConfigSharedManager.h"
#import "WPMarkDownParseBaseModel.h"

@interface WPMarkDownParseTitle()
@property (nonatomic,assign) WPMarkDownParseLevelTitleType level;
@end

@implementation WPMarkDownParseTitle

- (instancetype)initWithLevel:(WPMarkDownParseLevelTitleType)level{
    self = [super init];
    if (self) {
        self.level = level;
    }
    return self;
}

#pragma mark - priveate method

- (void)setLevel:(WPMarkDownParseLevelTitleType)level{
    int i = 0;
    self.symbol = @"#";
    while (i<level) {
        self.symbol = [NSString stringWithFormat:@"%@#",self.symbol];
        i++;
    }
    _level = level;
}

#pragma mark - 策略

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    NSMutableArray * parseArray = [NSMutableArray arrayWithCapacity:separatedArray.count-1];
    
    for (int i = 0; i<separatedArray.count-1; i++) {
        WPMarkDownParseTitleModel * titleModel = [[WPMarkDownParseTitleModel alloc] initWithSymbol:self.symbol];
        
        NSArray * rightStringSeparteds = [separatedArray[i+1] componentsSeparatedByString:@"\n"];
        if (rightStringSeparteds.count>0) {
            titleModel.text = rightStringSeparteds.firstObject;
            [parseArray addObject:titleModel];
        }
    }
    self.segmentArray = parseArray;
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    if (attributedString.length == 0) {
        return;
    }
    NSString * text = attributedString.string;
    CGFloat fontSize = [WPSettingConfigSharedManager sharedManager].fontSize+6-_level;
    
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseTitleModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
            make.textBoldFont(fontSize,range);
            make.textColor([UIColor blackColor],range);
        }];
    }];
}

@end
