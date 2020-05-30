//
//  NSMutableAttributedString+WPAddAttributed.h
//  DataStructureDemo
//
//  Created by wupeng on 2019/11/30.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPMutableAttributedStringMaker.h"

typedef void(^ChainedMutableStringMakerBlock)(WPMutableAttributedStringMaker * _Nullable make);

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (WPAddAttributed)
- (NSMutableAttributedString *)wp_makeAttributed:(ChainedMutableStringMakerBlock)block;
@end

NS_ASSUME_NONNULL_END
