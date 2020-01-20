//
//  WPTableViewPlaceHolderView.m
//  WPBase
//
//  Created by wupeng on 2019/11/20.
//

#import "WPTableViewPlaceHolderView.h"
#import "WPCommonMacros.h"
#import "Masonry.h"
#import "UIImageView+WPLoadBundleImage.h"

typedef void(^WPTableViewPlaceHolderViewRefreshBlock)(void);

@interface WPTableViewPlaceHolderView()
@property (nonatomic,copy) WPTableViewPlaceHolderViewRefreshBlock refreshBlock;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIButton * button;
@end

@implementation WPTableViewPlaceHolderView

- (instancetype)initWithFrame:(CGRect)frame refreshBlock:(void(^)(void))refreshBlock{
    self = [super initWithFrame:frame];
    if (self) {
        _refreshBlock = refreshBlock;
        [self drawView];
    }
    return self;
}

- (void)drawView{
    [self addSubview:self.imageView];
    [self addSubview:self.button];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(163, 106));
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-50);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(13);
        make.size.mas_equalTo(CGSizeMake(99, 28));
        make.centerX.equalTo(self);
    }];
}

- (void)refreshAction{
    if (_refreshBlock) {
        _refreshBlock();
    }
}

#pragma mark - getter

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView wpLoadBundelImageWithName:@"wp_plachholder"];
    }
    return _imageView;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"点击刷新" forState:UIControlStateNormal];
        [_button setTitleColor:RGB_COLOR(35, 140, 255) forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        _button.layer.cornerRadius = 14.0f;
        _button.layer.borderWidth = 1.0f;
        _button.layer.borderColor = RGBA_COLOR(55, 120, 255, 1).CGColor;
        [_button addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end

