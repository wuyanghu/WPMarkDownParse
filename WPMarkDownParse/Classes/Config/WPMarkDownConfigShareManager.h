//
//  WPConfigShareManager.h
//  WPMarkDownParse
//
//  Created by wupeng on 2020/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WPMarkDownConfigShareManager : NSObject
+ (WPMarkDownConfigShareManager *)sharedManager;
@property (nonatomic,assign) CGFloat defaultFontSize;//默认字体大小
@property (nonatomic,assign) CGFloat defaultWidth;//
@end

NS_ASSUME_NONNULL_END
