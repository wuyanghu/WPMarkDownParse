//
//  LabelChainedMaker.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/2.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WPLabelChainedMaker;
typedef WPLabelChainedMaker *(^ChainedLabelBlock) (id);
typedef WPLabelChainedMaker *(^ChainedLabelFrameBlock) (CGRect frame);

NS_ASSUME_NONNULL_BEGIN

@interface WPLabelChainedMaker : NSObject
- (instancetype)initWithLabel:(UIView *)view;

- (ChainedLabelFrameBlock)frame;
- (ChainedLabelBlock)bgColor;
- (ChainedLabelBlock)textColor;
- (ChainedLabelBlock)text;
- (ChainedLabelBlock)font;
@end

NS_ASSUME_NONNULL_END
