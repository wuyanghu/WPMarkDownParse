//
//  NSMutableParagraphStyleModel.h
//  DataStructureDemo
//
//  Created by wupeng on 2019/11/30.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WPMutableParagraphStyleModel : NSObject

@property (NS_NONATOMIC_IOSONLY) CGFloat lineSpacing;//行间距
@property (NS_NONATOMIC_IOSONLY) CGFloat paragraphSpacing;//段间距
@property (NS_NONATOMIC_IOSONLY) NSTextAlignment alignment;//两端对齐
@property (NS_NONATOMIC_IOSONLY) CGFloat firstLineHeadIndent;//首行缩进
@property (NS_NONATOMIC_IOSONLY) CGFloat headIndent;//整体缩进(首行除外)
@property (NS_NONATOMIC_IOSONLY) CGFloat tailIndent;//尾部缩进
@property (NS_NONATOMIC_IOSONLY) NSLineBreakMode lineBreakMode;//字符或单词换行
@property (NS_NONATOMIC_IOSONLY) CGFloat minimumLineHeight;//最小行高
@property (NS_NONATOMIC_IOSONLY) CGFloat maximumLineHeight;//最大行高
@property (NS_NONATOMIC_IOSONLY) NSWritingDirection baseWritingDirection;//从左到右的书写方式
@property (NS_NONATOMIC_IOSONLY) CGFloat lineHeightMultiple;
@property (NS_NONATOMIC_IOSONLY) CGFloat paragraphSpacingBefore;//段首空间
@property (NS_NONATOMIC_IOSONLY) float hyphenationFactor;//连字属性 0或1

- (NSMutableParagraphStyle *)createParagraphStyle;
@end

NS_ASSUME_NONNULL_END
