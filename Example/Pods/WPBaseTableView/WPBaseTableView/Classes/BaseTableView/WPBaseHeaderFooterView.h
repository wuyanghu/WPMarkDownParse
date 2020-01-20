//
//  WPBaseHeaderFooterView.h
//  WPBase
//
//  Created by wupeng on 2019/11/21.
//

#import <UIKit/UIKit.h>
#import "WPBaseSectionModel.h"

typedef void(^WPBaseHeaderFooterViewBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface WPBaseHeaderFooterView : UITableViewHeaderFooterView
@property (nonatomic,strong) WPBaseSectionModel * sectionModel;
@property (nonatomic,copy) WPBaseHeaderFooterViewBlock block;
@end

NS_ASSUME_NONNULL_END
