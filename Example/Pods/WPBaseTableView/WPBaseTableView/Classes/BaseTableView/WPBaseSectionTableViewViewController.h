//
//  BaseSectionTableViewViewController.h
//  DataStructureDemo
//
//  Created by wupeng on 2019/9/18.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPBaseSectionModel.h"
#import "UITableViewCell+BaseCategory.h"

typedef enum:NSInteger {
    WPBaseSectionTableViewNoLoadType,//不加载数据,子类实现
    WPBaseSectionTableViewLoadLocalType,//加载本地json文件
    WPBaseSectionTableViewRequestType//请求网络数据
}WPBaseSectionTableViewLoadType;

NS_ASSUME_NONNULL_BEGIN

@interface WPBaseSectionTableViewViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) WPBaseSectionsModel * sectionsModel;

#pragma mark - tableview方法
- (void)requestDetailInfo:(BOOL)isRefresh;
//以下方法子类可重载
@property (nonatomic,assign) WPBaseSectionTableViewLoadType loadType;//默认网络数据,

#pragma mark - 注册cell
- (void)registerCell;
- (NSString *)cellIdentifyWithIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (void)registerHeaderFooterView;
- (NSString *)headerFooterViewIdentifyWithSection:(NSInteger)section;
- (void)configureHeaderFooterView:(UITableViewHeaderFooterView *)view section:(NSInteger)section;

#pragma mark - 删除
- (BOOL)isCellEditingDelete;//是否支持删除
- (void)cellEditingDeleteAtIndexPath:(NSIndexPath *)indexPath;//左滑删除
#pragma mark - 移动
- (BOOL)isCellCanMove;//是否支持移动
- (void)moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
#pragma mark - 占位
- (void)plactHolderRefreshAction;//占位刷新:子类实现
#pragma mark - 浏览相册
- (void)photoBrowserWithIndexPath:(NSIndexPath *)indexPath isUrl:(BOOL)isUrl;
//提供一个默认的section
- (WPBaseSectionModel *)defaultSectionsModel;
@end

NS_ASSUME_NONNULL_END



