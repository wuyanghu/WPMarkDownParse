//
//  WPMarkDownParseBaseModel.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/19.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WPMarkDownParseBaseModel : NSObject
@property (nonatomic,copy) NSString * text;
@property (nonatomic,copy) NSString * symbol;
- (id)initWithSymbol:(NSString *)symbol;
- (NSString *)willBeReplacedString;//将要被替换的字符
- (NSString *)replaceString;//替换的字符
@end

@interface WPMarkDownParseLinkModel : WPMarkDownParseBaseModel
@property (nonatomic,copy) NSString * url;
@end

@interface WPMarkDownParseTitleModel : WPMarkDownParseBaseModel
@end

@interface WPMarkDownParseBoldModel : WPMarkDownParseBaseModel
@end

@interface WPMarkDownParseItalicModel : WPMarkDownParseBaseModel
@end

@interface WPMarkDownParseDisorderModel : WPMarkDownParseBaseModel
@end

@interface WPMarkDownParseOrderModel : WPMarkDownParseBaseModel
@property (nonatomic,copy) NSString * lastString;
@end

@interface WPMarkDownParseImageModel : WPMarkDownParseBaseModel
@property (nonatomic,copy) NSString * url;
@end

@interface WPMarkDownParseCodeBlockModel : WPMarkDownParseBaseModel
@end

@interface WPMarkDownParseQuoteParagraphModel : WPMarkDownParseBaseModel
@end

NS_ASSUME_NONNULL_END
