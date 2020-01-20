//
//  ParseVCJsonAPI.h
//  WPBase
//
//  Created by wupeng on 2019/11/17.
//

#import <Foundation/Foundation.h>
@class WPBaseSectionsModel;
NS_ASSUME_NONNULL_BEGIN

@interface WPParseSectionsModel : NSObject
+ (WPBaseSectionsModel *)parseServerJsonToBaseSetcionModel:(NSDictionary *)jsonDict;
+ (WPBaseSectionsModel *)parseLocalJsonToBaseSetcionModel:(NSDictionary *)configDict;
@end

NS_ASSUME_NONNULL_END

