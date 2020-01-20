//
//  WPMarkDownParseBaseModel.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/19.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseBaseModel.h"

@implementation WPMarkDownParseBaseModel

- (id)initWithSymbol:(NSString *)symbol{
    self = [super init];
    if (self) {
        _symbol = symbol;
    }
    return self;
}

- (NSString *)replaceString{
    return self.text;
}

- (NSString *)willBeReplacedString{
    return @"";
}

@end

@implementation WPMarkDownParseLinkModel

//将要被替换的
- (NSString *)willBeReplacedString{
    NSString * replaceBefore = [NSString stringWithFormat:@"[%@%@%@)",self.text,self.symbol,self.url];
    return replaceBefore;
}

@end

@implementation WPMarkDownParseTitleModel

- (NSString *)willBeReplacedString{
    NSString * replaceBefore = [NSString stringWithFormat:@"%@%@",self.symbol,self.text];
    return replaceBefore;
}

@end

@implementation WPMarkDownParseBoldModel

- (NSString *)willBeReplacedString{
    NSString * replaceBefore = [NSString stringWithFormat:@"%@%@%@",self.symbol,self.text,self.symbol];
    return replaceBefore;
}

@end

@implementation WPMarkDownParseItalicModel

- (NSString *)willBeReplacedString{
    NSString * replaceBefore = [NSString stringWithFormat:@"%@%@%@",self.symbol,self.text,self.symbol];
    return replaceBefore;
}

@end

@implementation WPMarkDownParseDisorderModel

- (NSString *)willBeReplacedString{
    NSString * replaceBefore = [NSString stringWithFormat:@"%@%@",self.symbol,self.text];
    return replaceBefore;
}

- (NSString *)replaceString{
    return [NSString stringWithFormat:@"• %@",self.text];
}

@end

@implementation WPMarkDownParseOrderModel

@end

@implementation WPMarkDownParseImageModel

- (NSString *)willBeReplacedString{
    NSString * replaceBefore = [NSString stringWithFormat:@"![%@%@%@)",self.text,self.symbol,self.url];
    return replaceBefore;
}
//图片自动追加\n
- (NSString *)replaceString{
    return [self.text stringByAppendingString:@"\n"];
}

@end

@implementation WPMarkDownParseCodeBlockModel

- (NSString *)willBeReplacedString{
    NSString * replaceBefore = [NSString stringWithFormat:@"%@%@%@",self.symbol,self.text,self.symbol];
    return replaceBefore;
}

@end

@implementation WPMarkDownParseQuoteParagraphModel

- (NSString *)willBeReplacedString{
    NSString * replaceBefore = [NSString stringWithFormat:@"%@%@",self.symbol,self.text];
    return replaceBefore;
}

@end
