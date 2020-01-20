//
//  ViewChainedMaker.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/2.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WPButtonChainedMaker;

typedef WPButtonChainedMaker *(^ChainedButtonArg1Block) (id);
typedef WPButtonChainedMaker *(^ChainedButtonBlock) (id,UIControlState);
typedef WPButtonChainedMaker *(^ChainedButtonFrameBlock) (CGRect frame);
typedef WPButtonChainedMaker *(^ChainedButtonColorBlock) (UIColor * color);

typedef void (^ChainedButtonActionCallParamsBlock)(UIButton * button);
typedef WPButtonChainedMaker *(^ChainedButtonActionCallBlock) (ChainedButtonActionCallParamsBlock);

NS_ASSUME_NONNULL_BEGIN

@interface WPButtonChainedMaker : NSObject
- (instancetype)initWithButton:(UIButton *)button;

- (ChainedButtonFrameBlock)frame;
- (ChainedButtonBlock)bgImage;
- (ChainedButtonBlock)image;
- (ChainedButtonBlock)title;
- (ChainedButtonBlock)titleColor;
- (ChainedButtonColorBlock)bgColor;
- (ChainedButtonArg1Block)contentHorizontalAlignment;
- (ChainedButtonActionCallBlock)addTarget;
- (ChainedButtonArg1Block)cornerRadius;//设置圆角
@end

NS_ASSUME_NONNULL_END
