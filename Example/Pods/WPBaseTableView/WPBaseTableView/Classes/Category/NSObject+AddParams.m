//
//  NSObject+AddParams.m
//  WPBase
//
//  Created by wupeng on 2019/9/24.
//

#import "NSObject+AddParams.h"
#import <objc/runtime.h>

@implementation NSObject (AddParams)

- (void)setWpAddParams:(NSDictionary *)wpAddParams{
    objc_setAssociatedObject(self, @"addParams", wpAddParams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)wpAddParams{
    return objc_getAssociatedObject(self, @"addParams");
}

@end
