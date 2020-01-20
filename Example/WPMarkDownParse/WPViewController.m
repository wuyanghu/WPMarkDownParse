//
//  WPViewController.m
//  WPMarkDownParse
//
//  Created by 823105162@qq.com on 01/20/2020.
//  Copyright (c) 2020 823105162@qq.com. All rights reserved.
//

#import "WPViewController.h"
#import "YYText.h"
#import "WPMarkDownParseFactory.h"
#import "UIView+Frame.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface WPViewController ()
@property (nonatomic,strong) YYLabel * yylabel;
@property (nonatomic,strong) YYLabel * yylabel2;
@end

@implementation WPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _yylabel = [self createYYLabel];
    [self.view addSubview:_yylabel];
    _yylabel.y = 88;
    _yylabel.x = 0;
    _yylabel.width = kScreenWidth-16*2;
    _yylabel.height = 200;
    _yylabel.attributedText = [WPMarkDownParseFactory parseMarkDownWithText:@"1. SDWebImage除了UIImageView,有没有提供缓存加下载入口？\n2. Socket推送的分包要接上\n3. 怎么处理图片加载\n4. 根据接口查询判断是否需要自动刷新\n5. 上拉有时鬼畜"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (YYLabel *)createYYLabel{
    YYLabel * yyLabel = [[YYLabel alloc] init];
    yyLabel.textAlignment = NSTextAlignmentLeft;
    yyLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    yyLabel.numberOfLines = 0;
    yyLabel.preferredMaxLayoutWidth = kScreenWidth-16*2;//设置最大宽度
    return yyLabel;
}

@end
