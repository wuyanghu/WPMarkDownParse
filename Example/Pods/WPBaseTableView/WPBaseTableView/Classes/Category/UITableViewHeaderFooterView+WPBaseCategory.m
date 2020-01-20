//
//  UITableViewHeaderFooterView+WPBaseCategory.m
//  WPBase
//
//  Created by wupeng on 2019/11/21.
//

#import "UITableViewHeaderFooterView+WPBaseCategory.h"

@implementation UITableViewHeaderFooterView (WPBaseCategory)

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

+ (void)registerHeaderFooterNibWithTableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:[self cellIdentifier] bundle:nil] forHeaderFooterViewReuseIdentifier:[self cellIdentifier]];
}

+ (void)registerHeaderFooterClassWithTableView:(UITableView *)tableView{
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:[self cellIdentifier]];
}

@end
