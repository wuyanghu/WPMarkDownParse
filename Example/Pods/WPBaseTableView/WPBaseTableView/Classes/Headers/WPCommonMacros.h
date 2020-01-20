//
//  WPMacros.h
//  WPBase
//
//  Created by wupeng on 2019/11/10.
//

#import <Foundation/Foundation.h>

#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define RGB_COLOR(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define IS_IPHONEX ((int)(MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) == 812)
#define HEX_COLOR(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define CMWeakSelf __weak typeof(self) _self = self;
#define CMStrongSelf __strong typeof(_self) self = _self;

#define kVCJsonChangedNotification @"vcJsonChangedNotification"//上传json时通知
#define kSwitchConfigUrlNotification @"switchConfigUrlNotification"//切换环境时通知
