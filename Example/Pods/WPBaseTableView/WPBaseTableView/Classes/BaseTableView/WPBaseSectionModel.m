//
//  BaseSectionModel.m
//  WPBase
//
//  Created by wupeng on 2019/11/11.
//

#import "WPBaseSectionModel.h"
#import "WPCommonMacros.h"
#import "YYText.h"

@implementation WPBaseSectionsModel

- (NSMutableArray<WPBaseSectionModel *> *)contentArray{
    if (!_contentArray) {
        _contentArray = [[NSMutableArray alloc] init];
    }
    return _contentArray;
}

- (NSString *)getTitleWithSection:(NSInteger)section{
    if (section<self.contentArray.count) {
        WPBaseSectionModel * sectionModel = self.contentArray[section];
        return sectionModel.sectionTitle;
    }
    return nil;
}

- (WPBaseRowModel *)getContentModelWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section>= self.contentArray.count) {
        return nil;
    }
    WPBaseSectionModel * sectionModel = self.contentArray[indexPath.section];
    if (indexPath.row >= sectionModel.rowArray.count) {
        return nil;
    }
    WPBaseRowModel * contentModel = sectionModel.rowArray[indexPath.row];
    return contentModel;
}

- (NSMutableArray *)rowArrayWithSection:(NSInteger)section{
    if (section<self.contentArray.count) {
        return [self.contentArray[section] rowArray];
    }
    return nil;
}

- (id)getExtensionWithIndexPath:(NSIndexPath *)indexPath{
    WPBaseRowModel * rowModel = [self getContentModelWithIndexPath:indexPath];
    return rowModel.extension;
}

- (void)removeWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section >= self.contentArray.count) {
        return;
    }
    WPBaseSectionModel * sectionModel = self.contentArray[indexPath.section];
    NSMutableArray * rowArray = [sectionModel rowArray];
    if (rowArray.count == 1) {
        [self.contentArray removeObjectAtIndex:indexPath.section];
    }else{
        [rowArray removeObjectAtIndex:indexPath.row];
    }
}
//用rowModel替换indexPath中
- (void)replaceWithRowModel:(WPBaseRowModel *)rowModel indexPath:(NSIndexPath *)indexPath{
    NSMutableArray * rowArray = [self rowArrayWithSection:indexPath.section];
    if (indexPath.row<rowArray.count) {
        [rowArray replaceObjectAtIndex:indexPath.row withObject:rowModel];
    }
}

@end

@implementation WPBaseSectionModel

- (NSMutableArray<WPBaseRowModel *> *)rowArray{
    if (!_rowArray) {
        _rowArray = [[NSMutableArray alloc] init];
    }
    return _rowArray;
}

@end

@implementation WPBaseRowModel

#pragma mark - 提供默认的属性并计算高度

- (void)setTitle:(NSString *)title{
    if (title && ![title isEqualToString:_title]) {
        _titleAttributedString = [self attributedWithText:title fontSize:17 height:&_titleHeight];
    }
    _title = title;
}

- (void)setDesc:(NSString *)desc{
    if (desc && ![desc isEqualToString:_desc]) {
        _descAttributedString = [self attributedWithText:desc fontSize:14 height:&_descHeight];
    }
    _desc = desc;
}

- (NSMutableAttributedString *)attributedWithText:(NSString *)text fontSize:(CGFloat)fontSize height:(CGFloat *)height{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, text.length)];
    [self getYYLabelHeight:attributedString height:height];
    return attributedString;
}

#pragma mark - 根据富文本去计算高度

- (void)setTitleAttributedString:(NSMutableAttributedString *)titleAttributedString{
    _titleAttributedString = titleAttributedString;
    [self getYYLabelHeight:titleAttributedString height:&_titleHeight];
}

- (void)setDescAttributedString:(NSMutableAttributedString *)descAttributedString{
    _descAttributedString = descAttributedString;
    [self getYYLabelHeight:descAttributedString height:&_descHeight];
}

#pragma mark - YYLabel高度计算

//获取YYLabel动态计算的高度
- (void)getYYLabelHeight:(NSMutableAttributedString *)attributedString height:(CGFloat *)height{
    CGSize introSize = CGSizeMake(ScreenWidth-16*2, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:attributedString];
    *height = layout.textBoundingSize.height;
}

#pragma mark - getter

- (WPBaseRowImageModel *)imageModel{
    if (!_imageModel) {
        _imageModel = [WPBaseRowImageModel new];
    }
    return _imageModel;
}

- (NSMutableDictionary *)params{
    if (!_params) {
        _params = [[NSMutableDictionary alloc] init];
    }
    return _params;
}

@end

@implementation WPBaseRowImageModel

- (void)setWidth:(NSString *)width{
    _width = width;
    [self imageSizeWithWidth:_width height:_height];
}

- (void)setHeight:(NSString *)height{
    _height = height;
    [self imageSizeWithWidth:_width height:_height];
}

- (void)imageSizeWithWidth:(NSString *)widthStr height:(NSString *)heightStr{
    if (!CGSizeEqualToSize(CGSizeZero, _imageSize)) {
        return;
    }
    
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat width = [widthStr floatValue]/screenScale;
    CGFloat height = [heightStr floatValue]/screenScale;
    
    if (width == 0 || height == 0) {
        return;
    }
    CGFloat imageMaxWidth = ScreenWidth-16*2;
    
    if (width<imageMaxWidth) {
        _imageSize = CGSizeMake(width, height);
    }else{
        CGFloat scale = (imageMaxWidth)/width;
        _imageSize = CGSizeMake(imageMaxWidth, height * scale);
    }
}

@end




