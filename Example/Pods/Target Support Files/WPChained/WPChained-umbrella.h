#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UINavigationItem+WPAddBarButtonItem.h"
#import "WPNavigationChainedMaker.h"
#import "UIButton+WPChained.h"
#import "WPButtonChainedMaker.h"
#import "UILabel+WPChained.h"
#import "WPLabelChainedMaker.h"
#import "NSMutableAttributedString+WPAddAttributed.h"
#import "WPMutableAttributedStringMaker.h"
#import "WPMutableParagraphStyleModel.h"
#import "WPChainedHeader.h"

FOUNDATION_EXPORT double WPChainedVersionNumber;
FOUNDATION_EXPORT const unsigned char WPChainedVersionString[];

