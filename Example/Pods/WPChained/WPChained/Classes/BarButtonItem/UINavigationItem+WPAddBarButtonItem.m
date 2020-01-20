//
//  UINavigationItem+WPAddBarButtonItem.m
//  DataStructureDemo
//
//  Created by wupeng on 2019/11/20.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import "UINavigationItem+WPAddBarButtonItem.h"

@implementation UINavigationItem (WPAddBarButtonItem)

- (UINavigationItem *)wp_makeNaviItem:(ChainedNaviItemMakerBlock)block{
    WPNavigationChainedMaker * maker = [[WPNavigationChainedMaker alloc] initWithNaviItem:self];
    block(maker);
    return self;
}

@end
