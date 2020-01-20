//
//  UITableViewHeaderFooterView+WPBaseCategory.h
//  WPBase
//
//  Created by wupeng on 2019/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewHeaderFooterView (WPBaseCategory)
+ (NSString *)cellIdentifier;
+ (void)registerHeaderFooterClassWithTableView:(UITableView *)tableView;
+ (void)registerHeaderFooterNibWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
