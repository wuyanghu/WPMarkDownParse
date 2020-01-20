//
//  WPMarkDownParseLinkModel.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseLink.h"
#import "YYText.h"
#import "WKWebViewViewController.h"
#import "WPMarkDownParseBaseModel.h"

@implementation WPMarkDownParseLink

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    NSMutableArray * parseArray = [NSMutableArray arrayWithCapacity:separatedArray.count-1];
    
    for (int i = 0; i<separatedArray.count-1; i++) {
        WPMarkDownParseLinkModel * urlModel = [[WPMarkDownParseLinkModel alloc] initWithSymbol:self.symbol];
        
        NSString * leftString = separatedArray[i];
        NSArray * leftStringSeparateArray = [leftString componentsSeparatedByString:@"["];
        if (leftStringSeparateArray.count>0) {
            urlModel.text = leftStringSeparateArray.lastObject;
        }
        NSArray * rightStringSepartedArray = [separatedArray[i+1] componentsSeparatedByString:@")"];
        if (rightStringSepartedArray.count>0) {
            urlModel.url = rightStringSepartedArray.firstObject;
        }
        if (urlModel.text.length && urlModel.url.length) {
            [parseArray addObject:urlModel];//当文字与url都不为空时，才算解析成功
        }
        
    }
    self.segmentArray = parseArray;

}

//设置富文本url的字体颜色和url
- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseLinkModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
            make.textColor([UIColor blueColor],range);
            make.underlineStyle(NSUnderlineStyleSingle,[UIColor blueColor],range);
        }];
        [attributedString yy_setTextHighlightRange:range color:[UIColor blueColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            NSLog(@"%@",[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]);
            [WKWebViewViewController pushWKWebViewController:obj.url];
        }];
    }];
}

@end
