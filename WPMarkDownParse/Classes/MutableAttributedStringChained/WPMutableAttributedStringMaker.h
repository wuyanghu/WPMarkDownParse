//
//  MutableAttributedStringMaker.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/2.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPMutableParagraphStyleModel.h"
#import <UIKit/UIKit.h>

@class WPMutableAttributedStringMaker;

NS_ASSUME_NONNULL_BEGIN

@interface WPMutableAttributedStringMaker : NSObject

- (id)initWithMutableAttributedString:(NSMutableAttributedString *)string;

//设置字体颜色
- (void)textColor:(UIColor *)color range:(NSRange)range;
//设置背景颜色
- (void)textBgColor:(UIColor *)color range:(NSRange)range;
//设置字号
- (void)textFont:(UIFont *)font range:(NSRange)range;
//插入图片
- (void)insertImageWithName:(NSString *)imageName bounds:(CGRect)bounds index:(NSUInteger)index;
//设置段落属性
- (void)paragraphStyle:(NSMutableParagraphStyle *)style range:(NSRange)range;
//字间距
- (void)kernWordSpace:(CGFloat)space range:(NSRange)range;
//单双删除线:1-7单线 依次加粗;9-15双线 依次加粗
//删除线颜色
- (void)strikethrough:(CGFloat)space color:(UIColor *)color range:(NSRange)range;
//下划线及颜色
- (void)underlineStyle:(NSUnderlineStyle)underlineStyle color:(UIColor *)color range:(NSRange)range;
//文本描边颜色
- (void)strokeColorWithWidth:(CGFloat)width color:(UIColor *)color range:(NSRange)range;
//设置阴影
//offsetSize:阴影偏移量;color:阴影颜色;blurRadius:模糊度
- (void)shadowWithOffset:(CGSize)offsetSize color:(UIColor *)color blurRadius:(CGFloat)blurRadius range:(NSRange)range;
//添加链接
- (void)linkWithUrl:(NSString *)urlString range:(NSRange)range;
//文字基线偏移
- (void)baselineOffsetWithOffset:(CGFloat)offset range:(NSRange)range;
//文字倾斜度
- (void)obliquenessWithOffset:(CGFloat)offset range:(NSRange)range;
//字体横向拉伸:正值拉伸，负值压缩
- (void)expansionWithOffset:(CGFloat)offset range:(NSRange)range;
#pragma mark - 统一设置
- (NSDictionary *)textFont:(UIColor *)color;
- (NSDictionary *)textBgColor:(UIColor *)color;
- (NSDictionary *)textColor:(UIFont *)font;

#pragma mark - 链式

/*
 文字基线偏移
 offset:负数向下偏移;正数向上偏移
 */
- (WPMutableAttributedStringMaker *(^)(CGFloat,NSRange))baselineOffset;
/*
 文本描边颜色
 width:正值镂空 负值描边
 */
- (WPMutableAttributedStringMaker *(^)(CGFloat,UIColor *,NSRange))strokeColor;
/*
 下划线及颜色
 */
- (WPMutableAttributedStringMaker *(^)(NSUnderlineStyle,UIColor *,NSRange))underlineStyle;
/*
 单双删除线:1-7单线 依次加粗;9-15双线 依次加粗
 删除线颜色
 */
- (WPMutableAttributedStringMaker *(^)(CGFloat,UIColor *,NSRange))strikethrough;
/*
 字间距
 */
- (WPMutableAttributedStringMaker *(^)(CGFloat,NSRange))kernWordSpace;
/*
 设置段落属性
 */
- (WPMutableAttributedStringMaker *(^)(NSMutableParagraphStyle *,NSRange))paragraphStyle;
/*
 插入图片
 */
- (WPMutableAttributedStringMaker * (^)(NSString * ,CGRect,NSInteger))insertImage;
/*
 插入图片2
 */
- (WPMutableAttributedStringMaker * (^)(UIImage * ,CGRect,NSInteger))insertImage2;
/*
 设置阴影 offsetSize:阴影偏移量;color:阴影颜色;blurRadius:模糊度
 */
- (WPMutableAttributedStringMaker *(^)(CGSize,UIColor *,CGFloat,NSRange))shadow;
/*
 添加链接
 NSString * url ,NSRange range
 */
- (WPMutableAttributedStringMaker *(^)(NSString * url ,NSRange range))link;
/*
 设置字体颜色
 UIColor *,NSRange
 */
- (WPMutableAttributedStringMaker *(^)(UIColor *,NSRange))textColor;
/*
 设置字体
 CGFloat,NSRange
 */
- (WPMutableAttributedStringMaker *(^) (CGFloat,NSRange))textFont;
/*
 设置加粗
 CGFloat,NSRange
 */
- (WPMutableAttributedStringMaker *(^) (CGFloat,NSRange))textBoldFont;
/*
 设置斜体加粗
 CGFloat,NSRange
 */
- (WPMutableAttributedStringMaker *(^) (CGFloat,NSRange))textBoldItalicFont;
/*
 设置背景颜色
 UIColor * ,NSRange
 */
- (WPMutableAttributedStringMaker *(^)(UIColor *,NSRange))bgColor;
/*
 文字倾斜度
 CGFloat,NSRange
 */
- (WPMutableAttributedStringMaker * (^)(CGFloat,NSRange))obliqueness;
/*
 字体横向拉伸:正值拉伸，负值压缩
 CGFloat offset,NSRange range
 */
- (WPMutableAttributedStringMaker *(^)(CGFloat offset,NSRange range))expansion;
@end

NS_ASSUME_NONNULL_END
