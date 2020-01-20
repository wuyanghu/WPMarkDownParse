//
//  WPTableViewPlaceHolderView.h
//  WPBase
//
//  Created by wupeng on 2019/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WPTableViewPlaceHolderView : UIView
- (instancetype)initWithFrame:(CGRect)frame refreshBlock:(void(^)(void))refreshBlock;
@end

NS_ASSUME_NONNULL_END
