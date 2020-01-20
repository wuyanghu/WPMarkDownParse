//
//  UIImageView+WPLoadBundleImage.m
//  WPBase
//
//  Created by wupeng on 2019/11/21.
//

#import "UIImageView+WPLoadBundleImage.h"

@implementation UIImageView (WPLoadBundleImage)

- (void)wpLoadBundelImageWithName:(NSString *)imgName
{
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"BaseSectionTableViewViewController")];
    NSURL *url = [bundle URLForResource:@"WPBaseTableView" withExtension:@"bundle"];
    if (!url) {
        NSLog(@"url 为空");
        return;
    }
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *image = [UIImage imageNamed:imgName inBundle:imageBundle compatibleWithTraitCollection:nil];
    self.image = image;
}

@end
