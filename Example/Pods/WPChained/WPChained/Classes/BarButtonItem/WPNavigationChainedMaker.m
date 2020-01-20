//
//  NavigationChainedMaker.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/11.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPNavigationChainedMaker.h"

#define RGB_COLOR(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

@interface WPNavigationChainedMaker()
@property (nonatomic,weak) UINavigationItem * naviItem;
@end

@implementation WPNavigationChainedMaker

- (id)initWithNaviItem:(UINavigationItem *)naviItem{
    self = [super init];
    if (self) {
        self.naviItem = naviItem;
    }
    return self;
}

#pragma mark - 添加right

- (UINavigationItem *(^)(UIBarButtonItem *))addRightBarButtonItem{
    return ^UINavigationItem *(UIBarButtonItem * barButtonItem){
        if (!self.naviItem.rightBarButtonItem) {
            self.naviItem.rightBarButtonItem = barButtonItem;
        }else{
            if (self.naviItem.rightBarButtonItems.count == 0) {
                self.naviItem.rightBarButtonItems = @[barButtonItem,self.naviItem.rightBarButtonItem];
            }else{
                NSMutableArray * rightItems = [NSMutableArray arrayWithArray:self.naviItem.rightBarButtonItems];
                [rightItems insertObject:barButtonItem atIndex:0];
                self.naviItem.rightBarButtonItems = rightItems;
            }
        }
        return self.naviItem;
    };
}

- (UINavigationItem *(^)(NSString *,ChainedButtonActionCallParamsBlock))addRightItemTitle{
    return ^UINavigationItem * (NSString  * title,ChainedButtonActionCallParamsBlock callBlock){
        UIBarButtonItem * barButtonItem = [self barButtonItemWithTitle:title callBlock:callBlock];
        return self.addRightBarButtonItem(barButtonItem);
    };
}

- (UINavigationItem *(^)(UIImage *,ChainedButtonActionCallParamsBlock))addRightItemImage{
    return ^UINavigationItem *(UIImage * image,ChainedButtonActionCallParamsBlock callBlock){
        UIBarButtonItem * barButtonItem = [self barButtonItemWithImage:image callBlock:callBlock];
        return self.addRightBarButtonItem(barButtonItem);
    };
}

#pragma mark - 添加left

- (UINavigationItem *(^)(UIBarButtonItem *))addLeftBarButtonItem{
    return ^UINavigationItem * (UIBarButtonItem * barButtonItem){
        if (!self.naviItem.leftBarButtonItem) {
            self.naviItem.leftBarButtonItem = barButtonItem;
        }else{
            if (self.naviItem.leftBarButtonItems.count == 0) {
                self.naviItem.leftBarButtonItems = @[barButtonItem,self.naviItem.leftBarButtonItem];
            }else{
                NSMutableArray * leftItems = [NSMutableArray arrayWithArray:self.naviItem.leftBarButtonItems];
                [leftItems insertObject:barButtonItem atIndex:0];
                self.naviItem.leftBarButtonItems = leftItems;
            }
        }
        return self.naviItem;
    };
}

- (UINavigationItem *(^)(NSString *,ChainedButtonActionCallParamsBlock))addLeftItemTitle{
    return ^ UINavigationItem *(NSString * title,ChainedButtonActionCallParamsBlock callBlock){
        UIBarButtonItem * barButtonItem = [self barButtonItemWithTitle:title callBlock:callBlock];
        return self.addLeftBarButtonItem(barButtonItem);
    };
}

- (UINavigationItem *(^)(UIImage *,ChainedButtonActionCallParamsBlock))addLeftItemImage{
    return ^ UINavigationItem *(UIImage * image,ChainedButtonActionCallParamsBlock callBlock){
        UIBarButtonItem * barButtonItem = [self barButtonItemWithImage:image callBlock:callBlock];
        return self.addLeftBarButtonItem(barButtonItem);
    };
}

#pragma mark - 创建BarButtonItem

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title callBlock:(ChainedButtonActionCallParamsBlock)callBlock{
    UIButton * button =
    [UIButton.createButton wp_makeProperty:^(WPButtonChainedMaker * _Nullable make) {
        make.frame(CGRectMake(0, 0, 44, 44));
        make.title(title,UIControlStateNormal);
        make.titleColor(RGB_COLOR(71,137,247),UIControlStateNormal);
        make.addTarget(callBlock);
    }];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image callBlock:(ChainedButtonActionCallParamsBlock)callBlock{
    UIButton * button =
    [UIButton.createButton wp_makeProperty:^(WPButtonChainedMaker * _Nullable make) {
        make.frame(CGRectMake(0, 0, 44, 44));
        make.image(image,UIControlStateNormal);
        make.addTarget(callBlock);
    }];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
