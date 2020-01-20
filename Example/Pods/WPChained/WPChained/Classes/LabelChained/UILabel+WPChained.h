//
//  UILabel+WPChained.h
//  DataStructureDemo
//
//  Created by wupeng on 2019/10/31.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPLabelChainedMaker.h"

typedef void(^ChainedLabelMakerBlock)(WPLabelChainedMaker * _Nullable make);

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (WPChained)
+ (UILabel *)createLabel;
- (UILabel *)wp_makeProperty:(ChainedLabelMakerBlock)block;
@end

NS_ASSUME_NONNULL_END
