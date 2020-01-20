//
//  NSMutableParagraphStyleModel.m
//  DataStructureDemo
//
//  Created by wupeng on 2019/11/30.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import "WPMutableParagraphStyleModel.h"

@implementation WPMutableParagraphStyleModel

- (NSMutableParagraphStyle *)createParagraphStyle{
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = self.lineSpacing;//行间距
    style.firstLineHeadIndent = self.firstLineHeadIndent;//首行缩进
    style.alignment = self.alignment;//两端对齐
    style.headIndent = self.headIndent;//整体缩进(首行除外)
    style.tailIndent = self.tailIndent;//尾部缩进
    style.minimumLineHeight = self.minimumLineHeight;//最小行高
    style.maximumLineHeight = self.maximumLineHeight;//最大行高
    style.paragraphSpacing = self.paragraphSpacing;//段间距
    style.paragraphSpacingBefore = self.paragraphSpacingBefore;//段首空间
    style.baseWritingDirection = self.baseWritingDirection;//从左到右的书写方式
    style.hyphenationFactor = self.hyphenationFactor;//连字属性 0或1
    
    return style;
}

@end
