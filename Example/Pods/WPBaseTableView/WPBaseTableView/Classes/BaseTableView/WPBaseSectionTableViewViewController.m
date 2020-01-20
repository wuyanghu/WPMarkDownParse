//
//  BaseSectionTableViewViewController.m
//  DataStructureDemo
//
//  Created by wupeng on 2019/9/18.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import "WPBaseSectionTableViewViewController.h"
#import "NSObject+AddParams.h"
#import "UITableViewHeaderFooterView+WPBaseCategory.h"
#import "WPBaseSectionCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "WPBaseSectionModel.h"
#import "WPParseSectionsModel.h"
#import "NSObject+Json.h"
#import "WPBaseHeader.h"
#import "MJRefresh.h"
#import "WPTableViewPlaceHolderView.h"
#import "UITableView+Placeholder.h"
#import "WPBaseHeaderFooterView.h"

@interface WPBaseSectionTableViewViewController ()

@end

@implementation WPBaseSectionTableViewViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self loadConfigInfo];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubView];
    [self loadData:NO];
}

- (void)addSubView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 通知

- (void)vcJsonChanged{
    [self loadData:NO];
}

#pragma mark - 加载数据

- (void)loadConfigInfo{
    NSData * data = [self readJsonDataWithName:NSStringFromClass([self class])];
    if(data){
        self.loadType = WPBaseSectionTableViewLoadLocalType;
    }else{
        self.loadType = WPBaseSectionTableViewNoLoadType;
    }
}

- (void)loadData:(BOOL)isRefresh{
    if (self.loadType == WPBaseSectionTableViewNoLoadType) {
        [self.tableView.mj_header endRefreshing];
    }else if (self.loadType == WPBaseSectionTableViewLoadLocalType){
        [self loadLocalJson];
        [self.tableView.mj_header endRefreshing];
    }else if(self.loadType == WPBaseSectionTableViewRequestType){
        [self requestDetailInfo:isRefresh];
    }
}

//加载本地数据
- (void)loadLocalJson{
    id json = [self readJsonWithName:NSStringFromClass([self class])];
    self.sectionsModel =  [WPParseSectionsModel parseLocalJsonToBaseSetcionModel:json];
    [self.tableView reloadData];
}

//request
- (void)requestDetailInfo:(BOOL)isRefresh{
    
}

//提供一个默认的section
- (WPBaseSectionModel *)defaultSectionsModel{
    if (!self.sectionsModel) {
        self.sectionsModel = [WPBaseSectionsModel new];
        WPBaseSectionModel * sectionModel = [WPBaseSectionModel new];
        [self.sectionsModel.contentArray addObject:sectionModel];
    }
    return self.sectionsModel.contentArray.firstObject;
}

#pragma mark - action
//占位刷新:子类实现
- (void)plactHolderRefreshAction{
    
}

#pragma mark - 浏览图片

- (void)photoBrowserWithIndexPath:(NSIndexPath *)indexPath isUrl:(BOOL)isUrl{
    
}

#pragma mark - configcell

- (void)registerCell{
    [WPBaseSectionCell registerClassWithTableView:_tableView];
}

- (NSString *)cellIdentifyWithIndexPath:(NSIndexPath *)indexPath{
    return WPBaseSectionCell.cellIdentifier;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if ([cell isKindOfClass:[WPBaseSectionCell class]]) {
        CMWeakSelf;
        WPBaseSectionCell * sectionCell = (WPBaseSectionCell *)cell;
        sectionCell.rowModel = [self.sectionsModel getContentModelWithIndexPath:indexPath];
        sectionCell.callBlock = ^() {
            CMStrongSelf;
            [self photoBrowserWithIndexPath:indexPath isUrl:YES];
        };
    }
}

#pragma mark - configHeader

- (void)registerHeaderFooterView{
    [WPBaseHeaderFooterView registerHeaderFooterClassWithTableView:_tableView];
}

- (NSString *)headerFooterViewIdentifyWithSection:(NSInteger)section{
    return WPBaseHeaderFooterView.cellIdentifier;
}

- (void)configureHeaderFooterView:(UITableViewHeaderFooterView *)view section:(NSInteger)section{
    if ([view isKindOfClass:[WPBaseHeaderFooterView class]]) {
        WPBaseHeaderFooterView * headerView = (WPBaseHeaderFooterView *)view;
        headerView.sectionModel = self.sectionsModel.contentArray[section];
        CMWeakSelf;
        headerView.block = ^{
            CMStrongSelf;
            NSMutableArray *indexPaths = [NSMutableArray array];
            
            WPBaseSectionModel * sectionModel = self.sectionsModel.contentArray[section];
            for (int i = 0;i<sectionModel.rowArray.count;i++) {
                [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:section]];
            }
            if (sectionModel.expend) {
                [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            }else{
                [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            }
        };
    }
}

#pragma mark - tableView

#pragma mark header
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WPBaseHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[self headerFooterViewIdentifyWithSection:section]];
    [self configureHeaderFooterView:headerView section:section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [tableView fd_heightForHeaderFooterViewWithIdentifier:[self headerFooterViewIdentifyWithSection:section] configuration:^(id headerFooterView) {
        [self configureHeaderFooterView:headerFooterView section:section];
    }];
}

#pragma mark content

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:[self cellIdentifyWithIndexPath:indexPath] cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WPBaseSectionModel * sectionModel = self.sectionsModel.contentArray[section];
    if (sectionModel.expend) {
        return 0;
    }
    return sectionModel.rowArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionsModel.contentArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString * identifier = [self cellIdentifyWithIndexPath:indexPath];
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WPBaseRowModel * contentModel = [self.sectionsModel getContentModelWithIndexPath:indexPath];
    NSString * className = contentModel.classname;
    NSString * storyBoardName = contentModel.storyboardname;
    
    id objClass = nil;
    if (storyBoardName && storyBoardName.length>0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:[NSBundle mainBundle]];
        objClass = [storyboard instantiateViewControllerWithIdentifier:className];
    }else{
        objClass = [NSClassFromString(className) new];
    }
    if (!objClass) {//对象是空直接return
        return;
    }
    
    if (contentModel.params) {
        [objClass setWpAddParams:contentModel.params];
    }
    
    if (!contentModel.method || contentModel.method.length == 0) {//没有指定方法，如果是viewController默认调push方法
        if ([objClass isKindOfClass:[UIViewController class]]) {
            [self.navigationController pushViewController:objClass animated:YES];
        }
    }else{
        SEL selector = NSSelectorFromString(contentModel.method);
        if ([objClass respondsToSelector:selector]) {
            ((void (*)(id, SEL))[objClass methodForSelector:selector])(objClass, selector);
        }
    }
    
}

#pragma mark - 左滑删除

- (BOOL)isCellEditingDelete{
    return NO;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self isCellEditingDelete];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self cellEditingDeleteAtIndexPath:indexPath];
    }
}

- (void)cellEditingDeleteAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"编辑删除");//具体操作，子类实现
}

#pragma mark - 移动

- (BOOL)isCellCanMove{
    return NO;
}

// 设置 cell 是否允许移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.isCellCanMove;
}
// 移动 cell 时触发
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // 移动cell之后更换数据数组里的循序
    [self moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}
//子类实现
- (void)moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}

#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self registerCell];
        [self registerHeaderFooterView];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

@end







