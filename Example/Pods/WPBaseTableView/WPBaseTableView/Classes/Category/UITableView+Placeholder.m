//
//  UITableView+Placeholder.m
//  CMRead-iPhone
//
//  Created by yrl on 17/3/30.
//  Copyright © 2017年 CMRead. All rights reserved.
//

#import "UITableView+Placeholder.h"
#import <objc/runtime.h>

@implementation UITableView (Placeholder)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod(self, @selector(reloadData));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(gy_reloadData));
        method_exchangeImplementations(originMethod, swizzledMethod);        
    });
}

- (void)setPlaceHolderView:(UIView *)placeHolderView
{
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeHolderView
{
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}

- (void)gy_reloadData
{
    [self gy_checkEmpty];
    [self gy_reloadData];
}

- (void)gy_checkEmpty
{
    BOOL isEmpty = YES;
    id<UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    for (int i = 0; i < sections; i++) {
        NSInteger rows = [src tableView:self numberOfRowsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    if (isEmpty) {
        [self.placeHolderView removeFromSuperview];
        [self addSubview:self.placeHolderView];
    }else{
        [self.placeHolderView removeFromSuperview];
    }
}

@end
