//
//  WPConfigShareManager.m
//  WPMarkDownParse
//
//  Created by wupeng on 2020/1/20.
//

#import "WPMarkDownConfigShareManager.h"
#import "WPMarkDownMacro.h"
@implementation WPMarkDownConfigShareManager

+ (WPMarkDownConfigShareManager *)sharedManager{
    static id sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _defaultFontSize = 14;//默认
        _defaultWidth = WP_ScreenWidth-32;
    }
    return self;
}

@end
