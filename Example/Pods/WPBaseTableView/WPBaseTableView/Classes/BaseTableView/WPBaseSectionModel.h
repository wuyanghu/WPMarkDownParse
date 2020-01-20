//
//  BaseSectionModel.h
//  WPBase
//
//  Created by wupeng on 2019/11/11.
//

#import <Foundation/Foundation.h>
@class WPBaseRowModel;
@class WPBaseRowImageModel;
@class WPBaseSectionModel;
NS_ASSUME_NONNULL_BEGIN

@interface WPBaseSectionsModel : NSObject
@property (nonatomic,copy) NSString * className;
@property (nonatomic,strong) NSMutableArray<WPBaseSectionModel *> * contentArray;
- (WPBaseRowModel *)getContentModelWithIndexPath:(NSIndexPath *)indexPath;
- (NSString *)getTitleWithSection:(NSInteger)section;
- (id)getExtensionWithIndexPath:(NSIndexPath *)indexPath;
- (void)removeWithIndexPath:(NSIndexPath *)indexPath;
- (void)replaceWithRowModel:(WPBaseRowModel *)rowModel indexPath:(NSIndexPath *)indexPath;
@end

@interface WPBaseSectionModel : NSObject
@property (nonatomic,strong) NSString * sectionTitle;
@property (nonatomic,assign) BOOL expend;//展开与缩放
@property (nonatomic,strong) NSMutableArray<WPBaseRowModel *> * rowArray;
@end

@interface WPBaseRowModel : NSObject
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * desc;

@property (nonatomic,strong) NSMutableAttributedString * titleAttributedString;
@property (nonatomic,strong) NSMutableAttributedString * descAttributedString;

@property (nonatomic,assign) CGFloat titleHeight;
@property (nonatomic,assign) CGFloat descHeight;

@property (nonatomic,strong) WPBaseRowImageModel * imageModel;
@property (nonatomic,strong) id extension;//扩展字段,实现自定义数据时可用此属性
@property (nonatomic,copy) NSString * classname;
@property (nonatomic,copy) NSString * storyboardname;
@property (nonatomic,copy) NSString * method;
@property (nonatomic,strong) NSMutableDictionary * params;

@end

@interface WPBaseRowImageModel : NSObject
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * width;
@property (nonatomic,copy) NSString * height;

@property (nonatomic,assign) CGSize imageSize;

@end

NS_ASSUME_NONNULL_END


