//
//  UIButton+WPChained.h
//  DataStructureDemo
//
//  Created by ruantong on 2019/11/13.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPButtonChainedMaker.h"

typedef void(^ChainedButtonMakerBlock)(WPButtonChainedMaker * _Nullable make);

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (WPChained)
+ (UIButton *)createButton;
- (UIButton *)wp_makeProperty:(ChainedButtonMakerBlock)block;
@property (nonatomic,strong) WPButtonChainedMaker * constraintMaker;//有点击事件必须持有
@end

NS_ASSUME_NONNULL_END
