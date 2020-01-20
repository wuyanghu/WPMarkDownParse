# WPChained

[![CI Status](https://img.shields.io/travis/823105162@qq.com/WPChained.svg?style=flat)](https://travis-ci.org/823105162@qq.com/WPChained)
[![Version](https://img.shields.io/cocoapods/v/WPChained.svg?style=flat)](https://cocoapods.org/pods/WPChained)
[![License](https://img.shields.io/cocoapods/l/WPChained.svg?style=flat)](https://cocoapods.org/pods/WPChained)
[![Platform](https://img.shields.io/cocoapods/p/WPChained.svg?style=flat)](https://cocoapods.org/pods/WPChained)

# 一、链式的使用

1. UILabel使用
```
    UILabel * label =
    [UILabel.createLabel wp_makeProperty:^(WPLabelChainedMaker * _Nullable make) {
        make.frame(CGRectMake(10, 100, 100, 30))
        .text(@"链式lable")
        .textColor([UIColor grayColor])
        .font([UIFont systemFontOfSize:22])
        .bgColor([UIColor redColor]);
    }];
    [self.view addSubview:label];
    
    UILabel * label2 =
    [UILabel.createLabel wp_makeProperty:^(WPLabelChainedMaker * _Nullable make) {
        make.frame(CGRectMake(10, 150, 100, 30))
        .textColor([UIColor grayColor])
        .bgColor([UIColor blueColor]);
    }];
    [self.view addSubview:label2];
```

2. UIButton使用

```
    __weak typeof(self) weakSelf = self;
    UIButton * button =
    [UIButton.createButton wp_makeProperty:^(WPButtonChainedMaker * _Nullable make) {
        
        make.frame(CGRectMake(10, 200, 100, 30));
        make.title(@"富文本链式",UIControlStateNormal);
        make.bgColor([UIColor redColor]);
        make.addTarget(
                       ^(UIButton * button){
                           [weakSelf buttonAction:button];
                       }
                       );
    }];
    [self.view addSubview:button];
    
    UIButton * button2 =
    [UIButton.createButton wp_makeProperty:^(WPButtonChainedMaker * _Nullable make) {
        make.frame(CGRectMake(10, 250, 100, 30))
        .title(@"button2",UIControlStateNormal)
        .bgColor([UIColor redColor])
        .addTarget(^(UIButton * button){
            [weakSelf buttonAction2:button];
        });
    }];
    
    [self.view addSubview:button2];
```
相对于UILabel,UIButton多了个点击事件。

3.  富文本使用
```
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:@"优点：\n1.相同model仅分配一次内存\n2.更新时直接刷新，不用查找替换再刷新。实际节省的内存不到1MB 1KB = 1024B，一个汉字=3B 1024/3 = 341个字 1MB = 341*1024=34.9万字，但是可以减少内存的分配与释放的时间。 对于大内存优势明显：多个用户相同主题包仅下载一次,https://www.baidu.com"];
    [attriStr wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
        make.textColor([UIColor redColor],NSMakeRange(0, 3));
        make.textFont(18,NSMakeRange(3, attriStr.string.length-3));
        make.insertImage(@"navi_search",CGRectMake(0, 0, 10, 11),5);
    }];
    
    NSString * text = attriStr.string;
    //可以分开设置
    [attriStr wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
        make.linkWithUrl(@"https://www.baidu.com",[text rangeOfString:@"https://www.baidu.com"]);
    }];
```
4. UIBarButtonItem使用
```
    __weak __typeof(self) weakSelf = self;
    [self.navigationItem wp_makeNaviItem:^(WPNavigationChainedMaker * _Nullable make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;

        make.addLeftItemTitle(@"解析",^(UIButton * button) {
            NSLog(@"解析");
        });
        
        make.addLeftItemImage([UIImage imageNamed:@"navi_search"],^(UIButton *button) {
            NSLog(@"我是图片");
        });
        
        make.addRightItemTitle(@"调用",^(UIButton * button) {
            NSLog(@"调用js方法");
        });
    }];
```

#二、原理
链式的理解可参考这篇文章:[iOS 链式实现UILabel创建、属性设置](https://www.jianshu.com/p/173fd7c699dd)
而这次的封装在原有基础上有所加深，我们看看UIButton的封装。
1. 在UIButton+WPChained.h中提供一个入口wp_makeProperty，创建WPButtonChainedMaker对象并用block回调给用户实现。
```
- (UIButton *)wp_makeProperty:(ChainedButtonMakerBlock)block {
    WPButtonChainedMaker *constraintMaker = [self constraintMaker];
    if (!constraintMaker) {
        constraintMaker = [[WPButtonChainedMaker alloc] initWithButton:self];
        [self setConstraintMaker:constraintMaker];
    }
    block(constraintMaker);
    return self;
}
```
2. WPButtonChainedMaker对UIButton属性的封装
例如title属性，其他属性类似
```
typedef WPButtonChainedMaker *(^ChainedButtonBlock) (id,UIControlState);

- (ChainedButtonBlock)title{
    ChainedButtonBlock block = ^WPButtonChainedMaker *(id title,UIControlState state){
        [self.button setTitle:title forState:state];
        return self;
    };
    return block;
}
```
**UIButton与其他不同的是,Button有事件，WPButtonChainedMaker对象不能调用完就释放，所以使用了关联对象存储。**

[iOS 链式组件库封装](https://www.jianshu.com/p/1eb388109abe)

## Installation

WPChained is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WPChained'
```

## Author

823105162@qq.com, 823105162@qq.com

## License

WPChained is available under the MIT license. See the LICENSE file for more info.
