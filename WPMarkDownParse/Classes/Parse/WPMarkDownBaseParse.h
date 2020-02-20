//
//  WPMarkDownParseBaseModel.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPMarkDownParseStrageInterface.h"
#import "WPMarkDownParseBaseModel.h"
#import "WPMarkDownMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface WPMarkDownBaseParse : NSObject<WPMarkDownParseStrageInterface>
@property (nonatomic,strong) NSMutableArray* segmentArray;
@property (nonatomic,copy) NSString * symbol;

@property (nonatomic,assign,readonly) CGFloat defaultFontSize;//字体
@property (nonatomic,assign,readonly) CGFloat defaultWidth;//宽度
- (void)configFontSize:(CGFloat)size width:(CGFloat)width;

- (id)initWithSymbol:(NSString *)symbol;
- (void)segmentString:(NSString**)text;

@end

@interface WPMarkDownBaseParse (Util)
- (BOOL)wp_isBackslash:(NSString *)leftString;//检查是不是反斜杠
- (NSString *)wp_firstOneString:(NSString *)string;//第一个字符
- (NSString *)wp_lastOneString:(NSString *)string;//获取最后一个字符
- (NSString *)wp_subStringLastNum:(NSString *)text;//裁剪字符得到最后几位数字
- (NSString *)wp_subLastNumPreString:(NSString *)text;//裁剪字符最后几位数字
- (BOOL)wp_isChineseWithText:(NSString *)text;//是否是中文
@end

NS_ASSUME_NONNULL_END
