//
//  WPMarkDownParseImage.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/19.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseImage.h"
#import "YYText.h"
#import "UIImageView+WebCache.h"
#import "NSMutableAttributedString+WPAddAttributed.h"

@implementation WPMarkDownParseImage

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    
    for (int i = 0; i<separatedArray.count-1; i++) {
        
        NSString * leftString = separatedArray[i];
        if ([self wp_isBackslash:leftString]) {
            continue;
        }
        WPMarkDownParseImageModel * urlModel = [[WPMarkDownParseImageModel alloc] initWithSymbol:self.symbol];
        
        NSRange leftRange = [leftString rangeOfString:@"!["];
        if (leftRange.location != NSNotFound) {
            urlModel.text = [leftString substringFromIndex:NSMaxRange(leftRange)];
        }else{
            continue;
        }
        
        NSString * rightText = separatedArray[i+1];
        NSRange rightRange = [rightText rangeOfString:@")"];
        if (rightRange.location != NSNotFound) {
            urlModel.url = [rightText substringToIndex:rightRange.location];
        }else{
            continue;
        }
        
        if (urlModel.text.length && urlModel.url.length) {
            [self.segmentArray addObject:urlModel];//当文字与url都不为空时，才算解析成功
        }
    }
    
}

//设置富文本url的字体颜色和url
- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseLinkModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        
        {   /*
             设置图片,现在是固定宽高，可让url后带上宽高
             */
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.defaultWidth, self.defaultWidth*0.68)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:obj.url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
            
            imageView.backgroundColor = [UIColor whiteColor];
            NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.frame.size alignToFont:[UIFont systemFontOfSize:self.defaultFontSize] alignment:YYTextVerticalAlignmentCenter];
            [attachText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
            [attributedString insertAttributedString:attachText atIndex:range.location];
        }
        
        {//处理描述文字
            range = [text rangeOfString:obj.text];
            [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
                make.textFont(self.defaultFontSize-2,range);
                make.textColor([UIColor grayColor],range);
                
                CGFloat width = [self calculateWidth:obj.text fontSize:self.defaultFontSize];
                WPMutableParagraphStyleModel * styleModel = [self paragraphStyleModel:width];
                make.paragraphStyle([styleModel createParagraphStyle],range);
            }];
        }
    }];
}

- (WPMutableParagraphStyleModel *)paragraphStyleModel:(CGFloat)width{
    
    WPMutableParagraphStyleModel * styleModel = [WPMutableParagraphStyleModel new];
    styleModel.headIndent =  (self.defaultWidth-width)/2;//整体缩进(首行除外)
    styleModel.firstLineHeadIndent = (self.defaultWidth-width)/2;
    styleModel.alignment = NSTextAlignmentLeft;
    return styleModel;
}

- (CGFloat)calculateWidth:(NSString *)text fontSize:(CGFloat)fontSize{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(0, 16) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.width;
}

@end
