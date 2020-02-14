//
//  WPMarkDownMacro.h
//  WPMarkDownParse
//
//  Created by wupeng on 2020/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define WP_RGB_COLOR(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define WP_ScreenWidth     [[UIScreen mainScreen] bounds].size.width

#define kWPOrderSymbol @". "

NS_ASSUME_NONNULL_END
