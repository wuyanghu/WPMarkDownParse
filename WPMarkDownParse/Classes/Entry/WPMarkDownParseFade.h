//
//  WPMarkDownParseFade.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WPMarkDownParseFade : NSObject
- (void)parseMarkDownWithText:(NSString *)text finishBlock:(void (^)(NSMutableAttributedString * string))block;
- (void)parseMarkDownWithText:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width finishBlock:(void (^)(NSMutableAttributedString * string))block;

- (NSMutableAttributedString *)parseMarkDownWithText:(NSString *)text;
- (NSMutableAttributedString *)parseMarkDownWithText:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
