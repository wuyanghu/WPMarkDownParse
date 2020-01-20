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
    NSMutableArray * parseArray = [NSMutableArray arrayWithCapacity:separatedArray.count-1];
    
    for (int i = 0; i<separatedArray.count-1; i++) {
        WPMarkDownParseImageModel * urlModel = [[WPMarkDownParseImageModel alloc] initWithSymbol:self.symbol];
        
        NSString * leftString = separatedArray[i];
        NSArray * leftStringSeparteds = [leftString componentsSeparatedByString:@"!["];
        if (leftStringSeparteds.count>1) {
            urlModel.text = leftStringSeparteds.lastObject;
        }
        NSArray * rightSepartedArray = [separatedArray[i+1] componentsSeparatedByString:@")"];
        if (rightSepartedArray.count>0) {
            urlModel.url = rightSepartedArray.firstObject;
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
    WPMarkDownConfigShareManager * config = [WPMarkDownConfigShareManager sharedManager];
    CGFloat fontSize = config.defaultFontSize;
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseLinkModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        
        {   /*
             设置图片,现在是固定宽高，可让url后带上宽高
             */
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, config.defaultWidth, config.defaultWidth*0.68)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:obj.url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
            
            imageView.backgroundColor = [UIColor whiteColor];
            NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.frame.size alignToFont:[UIFont systemFontOfSize:fontSize] alignment:YYTextVerticalAlignmentCenter];
            [attachText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
            [attributedString insertAttributedString:attachText atIndex:range.location];
        }
        
        {//处理描述文字
            range = [text rangeOfString:obj.text];
            [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
                make.textFont(fontSize-2,range);
                make.textColor([UIColor grayColor],range);
                
                CGFloat width = [self calculateWidth:obj.text fontSize:fontSize];
                WPMutableParagraphStyleModel * styleModel = [self paragraphStyleModel:width];
                make.paragraphStyle([styleModel createParagraphStyle],range);
            }];
        }
    }];
}

- (WPMutableParagraphStyleModel *)paragraphStyleModel:(CGFloat)width{
    
    WPMutableParagraphStyleModel * styleModel = [WPMutableParagraphStyleModel new];
    WPMarkDownConfigShareManager * config = [WPMarkDownConfigShareManager sharedManager];
    styleModel.headIndent =  config.defaultWidth-width/2;//整体缩进(首行除外)
    styleModel.firstLineHeadIndent = config.defaultWidth-width/2;
    return styleModel;
}

- (CGFloat)calculateWidth:(NSString *)text fontSize:(CGFloat)fontSize{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(0, 16) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.width;
}

@end
