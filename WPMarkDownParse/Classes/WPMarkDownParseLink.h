//
//  WPMarkDownParseLinkModel.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownBaseParse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WPMarkDownParseLink : WPMarkDownBaseParse
@property (nonatomic,copy) NSString * url;
@end

NS_ASSUME_NONNULL_END
