//
//  BaseSectionCell.h
//  WPBase
//
//  Created by wupeng on 2019/11/10.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class WPBaseRowModel;
@class YYLabel;

typedef void(^WPBaseSectionCellBlock)(void);

@interface WPBaseSectionCell : UITableViewCell
@property (nonatomic,strong) YYLabel * titleLabel;
@property (strong, nonatomic) YYLabel * contentLabel;
@property (nonatomic,strong) UIImageView * contentImageView;

@property (nonatomic,strong) WPBaseRowModel * rowModel;
@property (nonatomic,copy) WPBaseSectionCellBlock callBlock;

@end

NS_ASSUME_NONNULL_END

