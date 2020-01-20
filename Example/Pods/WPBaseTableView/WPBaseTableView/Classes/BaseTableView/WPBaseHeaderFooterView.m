//
//  WPBaseHeaderFooterView.m
//  WPBase
//
//  Created by wupeng on 2019/11/21.
//

#import "WPBaseHeaderFooterView.h"
#import "WPCommonMacros.h"
#import "Masonry.h"
#import "UIImageView+WPLoadBundleImage.h"

@interface WPBaseHeaderFooterView()
@property (nonatomic,strong) UIButton * titleButton;
@property (nonatomic,strong) UIImageView * arrowImageView;
@property (nonatomic) CGAffineTransform imageViewTransform;

@end

@implementation WPBaseHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = HEX_COLOR(0xF7F7F7);
        
        [self addSubview:self.titleButton];
        [self addSubview:self.arrowImageView];
        
        self.titleButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.arrowImageView.translatesAutoresizingMaskIntoConstraints= NO;
        
        [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.top.equalTo(self).offset(10);
            make.height.mas_equalTo(24);
            make.right.equalTo(self.arrowImageView.mas_left).offset(-10);
        }];
        
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40/6.0, 12));
            make.centerY.equalTo(self.titleButton);
            make.right.equalTo(self).offset(-16);
        }];
        
    }
    return self;
}

- (void)setSectionModel:(WPBaseSectionModel *)sectionModel{
    if (_sectionModel != sectionModel) {
        _sectionModel = sectionModel;
        [_titleButton setTitle:sectionModel.sectionTitle forState:UIControlStateNormal];
        [self rotationAnimation:NO];
    }
}

- (void)expandAction{
    [self rotationAnimation:YES];
    
    _sectionModel.expend = !_sectionModel.expend;
    if (_block) {
        _block();
    }
}

- (CGSize)sizeThatFits:(CGSize)size{
    return CGSizeMake(size.width, 44);
}

- (void)rotationAnimation:(BOOL)animation
{
    //calculate second hand angle
    CGFloat angle;
    if (_sectionModel.expend) {
        angle =  0;
    }else{
        angle =  M_PI_2;
    }
    if (animation) {
        [UIView animateWithDuration:0.5 animations:^{
            self.arrowImageView.transform = CGAffineTransformRotate(self.imageViewTransform, angle);
        }];
    }else{
        self.arrowImageView.transform = CGAffineTransformRotate(self.imageViewTransform, angle);
    }
    
}


#pragma mark -  getter

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        [_arrowImageView wpLoadBundelImageWithName:@"wp_arrows_next"];
        _imageViewTransform = _arrowImageView.transform;
    }
    return _arrowImageView;
}

- (UIButton *)titleButton{
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleButton setTitleColor:HEX_COLOR(0x202020) forState:UIControlStateNormal];
        _titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_titleButton addTarget:self action:@selector(expandAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleButton;
}

@end


