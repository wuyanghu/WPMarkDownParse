//
//  WPMarkDownParseStrageInterface.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/19.
//  Copyright © 2020 wupeng. All rights reserved.
//

#ifndef WPMarkDownParseStrageInterface_h
#define WPMarkDownParseStrageInterface_h

//解析策略模式
@protocol WPMarkDownParseStrageInterface <NSObject>
- (NSString *)replace:(NSString *)text;
- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text;//分割字符串
- (void)setAttributedString:(NSMutableAttributedString *)attributedString;

@end

#endif /* WPMarkDownParseStrageInterface_h */
