//
//  BaseSectionCell.m
//  WPBase
//
//  Created by wupeng on 2019/11/10.
//

#import "WPBaseSectionCell.h"
#import "Masonry.h"
#import "WPCommonMacros.h"
#import "WPBaseSectionModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UITableView+FDTemplateLayoutCell.h"
#import "YYText.h"

@interface WPBaseSectionCell()

@end

@implementation WPBaseSectionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.fd_enforceFrameLayout = YES;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.contentImageView];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.top.equalTo(self).offset(10);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLabel);
            make.height.mas_equalTo(0); make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        }];
        
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
            make.left.equalTo(self.contentLabel);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setRowModel:(WPBaseRowModel *)rowModel{
    _rowModel = rowModel;
    
    self.titleLabel.attributedText = rowModel.titleAttributedString;
    self.contentLabel.attributedText = rowModel.descAttributedString;
    
    [self updateMasConstraintsWithRowModel:rowModel];

    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:rowModel.imageModel.url]];
}

#pragma mark - 更新约束

- (void)updateMasConstraintsWithRowModel:(WPBaseRowModel *)rowModel{
    if (!rowModel) {
        return;
    }
    CGFloat offset = rowModel.titleHeight == 0?0:10;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(offset);
    }];
    
    offset = rowModel.descHeight == 0?0:10;
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {        make.top.equalTo(self.titleLabel.mas_bottom).offset(offset);
        make.height.mas_equalTo(rowModel.descHeight);
    }];
    
    CGSize imageSize = self.rowModel.imageModel.imageSize;
    offset = CGSizeEqualToSize(CGSizeZero, imageSize)?0:10;
    
    [self.contentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(offset);
        make.size.mas_equalTo(imageSize);
    }];
}

#pragma mark - 手势

- (void)browsePhotoTapGesture:(UITapGestureRecognizer *)tapGesture{
    if (_callBlock) {
        _callBlock();
    }
}

#pragma mark - 计算高度

- (CGSize)sizeThatFits:(CGSize)size{
    CGFloat totalHeight = 10;
    if (_rowModel.titleHeight>0) {
        totalHeight += _rowModel.titleHeight+10;
    }
    
    if (_rowModel.descHeight>0) {
        totalHeight += _rowModel.descHeight+10;
    }
    
    CGSize imageSize = self.rowModel.imageModel.imageSize;
    if (!CGSizeEqualToSize(CGSizeZero, imageSize)) {
        totalHeight+= imageSize.height+10;
    }
    return CGSizeMake(size.width, totalHeight);
}

#pragma mark - getter

- (UIImageView *)contentImageView{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.userInteractionEnabled = YES;
        _contentImageView.layer.cornerRadius = 5.0;
        _contentImageView.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(browsePhotoTapGesture:)];
        tapGesture.numberOfTouchesRequired = 1;
        [_contentImageView addGestureRecognizer:tapGesture];
    }
    return _contentImageView;
}

- (YYLabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [self createYYLabel];
    }
    return _contentLabel;
}

- (YYLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self createYYLabel];
    }
    return _titleLabel;
}

- (YYLabel *)createYYLabel{
    YYLabel * yyLabel = [[YYLabel alloc] init];
    yyLabel.textAlignment = NSTextAlignmentLeft;
    yyLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    yyLabel.numberOfLines = 0;
    yyLabel.preferredMaxLayoutWidth = SCREEN_WIDTH-16*2;//设置最大宽度
    return yyLabel;
}

@end





