//
//  WPMarkDownParseBaseModel.h
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPMarkDownParseStrageInterface.h"
#import "WPMarkDownParseBaseModel.h"
#import "NSMutableAttributedString+WPAddAttributed.h"
#import "WPMarkDownConfigShareManager.h"
#import "WPMarkDownMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface WPMarkDownBaseParse : NSObject<WPMarkDownParseStrageInterface>
@property (nonatomic,strong) NSArray* segmentArray;
@property (nonatomic,copy) NSString * symbol;
- (id)initWithSymbol:(NSString *)symbol;
- (void)segmentString:(NSString**)text;
@end

NS_ASSUME_NONNULL_END
