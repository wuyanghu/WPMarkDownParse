//
//  UITableViewCell+BaseCategory.m
//  WPBase
//
//  Created by wupeng on 2019/11/10.
//

#import "UITableViewCell+BaseCategory.h"

@implementation UITableViewCell (BaseCategory)

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

+ (void)registerNibWithTableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:[self cellIdentifier] bundle:nil] forCellReuseIdentifier:[self cellIdentifier]];
}

+ (void)registerClassWithTableView:(UITableView *)tableView{
    [tableView registerClass:[self class] forCellReuseIdentifier:[self cellIdentifier]];
}

@end
