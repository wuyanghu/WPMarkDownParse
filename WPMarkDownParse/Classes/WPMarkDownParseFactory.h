//
//  WPMarkDownParseFactory.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WPMarkDownParseFactory : NSObject
+ (NSMutableAttributedString *)parseMarkDownWithText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
