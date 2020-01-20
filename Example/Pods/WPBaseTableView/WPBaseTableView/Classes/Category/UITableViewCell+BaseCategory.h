//
//  UITableViewCell+BaseCategory.h
//  WPBase
//
//  Created by wupeng on 2019/11/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (BaseCategory)
+ (NSString *)cellIdentifier;
+ (void)registerClassWithTableView:(UITableView *)tableView;
+ (void)registerNibWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
