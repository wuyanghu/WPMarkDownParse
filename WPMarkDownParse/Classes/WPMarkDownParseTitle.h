//
//  WPMarkDownParseTitleModel.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownBaseParse.h"

typedef NS_ENUM(NSInteger,WPMarkDownParseLevelTitleType) {
    WPMarkDownParseLevelOneTitleType,
    WPMarkDownParseLevelTwoTitleType,
    WPMarkDownParseLevelThreeTitleType,
    WPMarkDownParseLevelFourTitleType,
    WPMarkDownParseLevelFiveTitleType,
    WPMarkDownParseLevelSixTitleType
};

NS_ASSUME_NONNULL_BEGIN

@interface WPMarkDownParseTitle : WPMarkDownBaseParse
- (instancetype)initWithLevel:(WPMarkDownParseLevelTitleType)level;
@end

NS_ASSUME_NONNULL_END
