//
//  NavigationChainedMaker.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/11.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIButton+WPChained.h"

NS_ASSUME_NONNULL_BEGIN

@interface WPNavigationChainedMaker : NSObject
- (id)initWithNaviItem:(UINavigationItem *)naviItem;
/*
 暴露barButtonItem,可以实现自定义
 */
- (UINavigationItem *(^)(UIBarButtonItem *))addLeftBarButtonItem;
- (UINavigationItem *(^)(UIBarButtonItem *))addRightBarButtonItem;

//添加title
- (UINavigationItem *(^)(NSString *,ChainedButtonActionCallParamsBlock))addLeftItemTitle;
- (UINavigationItem *(^)(NSString *,ChainedButtonActionCallParamsBlock))addRightItemTitle;
//添加image
- (UINavigationItem *(^)(UIImage *,ChainedButtonActionCallParamsBlock))addLeftItemImage;
- (UINavigationItem *(^)(UIImage *,ChainedButtonActionCallParamsBlock))addRightItemImage;
//获取BarButtonItem
- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title callBlock:(ChainedButtonActionCallParamsBlock)callBlock;
@end

NS_ASSUME_NONNULL_END
