//
//  UINavigationItem+WPAddBarButtonItem.h
//  DataStructureDemo
//
//  Created by wupeng on 2019/11/20.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPNavigationChainedMaker.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^ChainedNaviItemMakerBlock)(WPNavigationChainedMaker * _Nullable make);

@interface UINavigationItem (WPAddBarButtonItem)
- (UINavigationItem *)wp_makeNaviItem:(ChainedNaviItemMakerBlock)block;
@end

NS_ASSUME_NONNULL_END
