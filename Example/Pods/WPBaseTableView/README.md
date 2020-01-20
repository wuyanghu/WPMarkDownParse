# WPBaseTableView
## 主要功能:使用json配置TableView,高度缓存及动态计算，使用富文本展示，支持删除、移动。
## 快速构建列表,继承WPBaseSectionTableViewViewController加一个json文件，不需要一行代码，可实现以上功能。
[![CI Status](https://img.shields.io/travis/823105162@qq.com/WPBaseTableView.svg?style=flat)](https://travis-ci.org/823105162@qq.com/WPBaseTableView)
[![Version](https://img.shields.io/cocoapods/v/WPBaseTableView.svg?style=flat)](https://cocoapods.org/pods/WPBaseTableView)
[![License](https://img.shields.io/cocoapods/l/WPBaseTableView.svg?style=flat)](https://cocoapods.org/pods/WPBaseTableView)
[![Platform](https://img.shields.io/cocoapods/p/WPBaseTableView.svg?style=flat)](https://cocoapods.org/pods/WPBaseTableView)

![列表.gif](https://upload-images.jianshu.io/upload_images/1387554-ab7582d0dea3d3da.gif?imageMogr2/auto-orient/strip)

**背景:列表中有很多数据，每个数据都对应一个点击事件。**
\- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;方法会非常的长，导入的头文件也非常多。想交换两个位置，会非常困难。


直接使用tableView,缺点非常明显，viewController类非常臃肿，而且多个的列表，需要重复写tableView的方法。我想到使用json来配置tableView的数据源和跳转的类及方法参数。

封装之后的viewController没有一行代码,继承自BaseSectionTableViewViewController加一个json配置文件。这样我想增加一个列表或交换列表的顺序也非常简单。
```
#import <UIKit/UIKit.h>
#import "BaseSectionTableViewViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface CoreAnimationViewController : BaseSectionTableViewViewController

@end

NS_ASSUME_NONNULL_END

#import "CoreAnimationViewController.h"

@interface CoreAnimationViewController ()

@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"动画"];
}

@end
```
![viewController实现.png](https://upload-images.jianshu.io/upload_images/1387554-3546dd4b3b93825c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 一、BaseSectionTableViewViewController的实现:
## 1. 通过类名读取对应的配置文件，我把解析的方法放在NSObject(Json)中:
```
- (id)readConfigJsonWithName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    if (!path) {
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    id dataId = [NSJSONSerialization JSONObjectWithData:data                   options:NSJSONReadingMutableContainers error:nil];
    return dataId;
}
```
## 2. 解析配置文件信息
### 2.1 json配置介绍
title是用于展示titleForHeaderInSection的NSString，是一个数组。
content节点可配置title、classname、storyboardname、method、params。
```
{
    "title":[
        "其他",
        "小知识点总结"
    ],
    "content":[
        [
            {
                "title":"UIScrollView嵌套tableView",
            },
            {
                "title":"点赞动画",
            },
            {
                "title":"排行榜C化",
                "classname":"ClassifyViewController",
                "storyboardname":"CMClassify"
            },
            {
                "title":"壹句",
                "classname":"CMMiguOneSentenceViewController"
            },
            {
                "title":"图片裁剪",
                "classname":"ClipImageViewController"
            },
            {
                "title":"轮播图ScrollView",
                "classname":"SlideshowScrollViewController"
            },
            {
                "title":"彩虹",
                "classname":"RainbowViewController"
            },
            {
                "title":"NSString 为什么用copy",
                "classname":"CopyNString",
                "method":"main"
            },
            {
                "title":"关联对象弹窗",
                "classname":"AssociatedAlertView",
                "method":"askUserAQuestion"
            },
            {
                "title":"虚拟定位",
                "classname":"SelectLocationViewController"
            },
            {
                "title":"微信步数模拟",
                "classname":"WeChatStepSimulation",
                "method":"main"
            },
            {
                "title":"动画按顺序执行",
                "classname":"SequenceAnimationViewController"
            },
            {
                "title":"UIWebView",
                "classname":"UIWebViewViewController"
            },
            {
                "title":"WKWebView",
                "classname":"WKWebViewViewController"
            },
            {
                "title":"xib引用xib使用",
                "classname":"UseXibViewController"
            },
            {
                "title":"UILable内边距设置",
                "classname":"LabelEdgeInsetViewController"
            },
            {
                "title":"网络请求",
                "classname":"NetworkViewController"
            }
        ],
        [
            {
                "title":"多线程",
                "classname":"ThreadProblemViewController"
            },
            {
                "title":"内存泄露",
                "classname":"MemoryLeakViewController"
            },
            {
                "title":"RunLoop",
                "classname":"RunLoopViewController"
            },
            {
                "title":"RunTime",
                "classname":"RuntimeViewController"
            },
            {
                "title":"Category",
                "classname":"CategoryViewController"
            },
        ]
    ]
}
```

## 2.2获取title
```
- (NSString *)getTitleFromSectionTableView:(NSIndexPath *)indexPath{
    id content = self.contentArray[indexPath.section][indexPath.row];
    if ([content isKindOfClass:[NSDictionary class]]) {
        NSDictionary * contentDict = (NSDictionary *)content;
        return contentDict[BASETABLEVIEW_CONTENT_TITLE];
    }else if([content isKindOfClass:[NSString class]]){
        return content;
    }
    
    return nil;
}
```
title分两种，如果是NSString直接展示，如果是NSDictonary,则取出其中的title。

## 2.3 处理点击事件
### 2.3.1考虑到UIViewController可能是xib、纯代码、或storyBoard创建。如果是UIViewController类直接push。
```
id content = self.contentArray[indexPath.section][indexPath.row];
    
    NSString * className;
    NSString * storyBoardName;
    if ([content isKindOfClass:[NSString class]]) {
        className = (NSString *)content;
    }else{
        NSDictionary * contentDict = (NSDictionary *)content;
        className = contentDict[BASETABLEVIEW_CONTENT_CLASSNAME];
        storyBoardName = contentDict[BASETABLEVIEW_CONTENT_STORYBOARDNAME];
        
        _params = contentDict[BASETABLEVIEW_CONTENT_PARAMS];
        _method = contentDict[BASETABLEVIEW_CONTENT_METHOD];
    }
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
```
### 2.3.2 params解析
NSObject (AddParams)来给NSObject动态添加参数
```
- (void)setParams:(NSDictionary *)params {
    objc_setAssociatedObject(self, @"params", params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)params {
    return objc_getAssociatedObject(self, @"params");
}
```
### 2.3.3 method解析
```
 SEL selector = NSSelectorFromString(_method);
        if ([objClass respondsToSelector:selector]) {
            [objClass performSelector:selector withObject:self.params];
        }
```

# 3.使用
## 3.1[可通过pod方式集成](https://github.com/wuyanghu/WPBaseTableView.git)
## 3.2新建viewController继承BaseSectionTableViewViewController,并新建一个json文件。
```
{
                "title":"标题",
                "classname":"ViewController",
                "storyboardname":"storyboard名称，可省略",
                "params":{
                    "type":"0"
                }
            }
```
## 3.3 配置
### 3.3.1 仅展示title
```
{
                "title":"点赞动画",
            }
```
### 3.3.2 纯代码创建
```
{
                "title":"图片裁剪",
                "classname":"ClipImageViewController"
            }
```
### 3.3.3 storyboard创建
```
{
                "title":"排行榜C化",
                "classname":"ClassifyViewController",
                "storyboardname":"CMClassify"
            }
```
### 3.3.4 创建NSObject并运行指定方法
```
{
                "title":"NSString 为什么用copy",
                "classname":"CopyNString",
                "method":"main"
            }
```
### 3.3.5 创建类并带有参数
```
{
                "title":"CGAffineTransform 仿射变换",
                "classname":"AffineTransformViewController",
                "storyboardname":"CoreAnimationStoryboard",
                "params":{
                    "type":"0"
                }
            }
```

总结:
这种方式使得viewController类非常整洁，新增一个列表非常方便。不用关心跳转了，由BaseTableViewViewController为我们做好。

## Requirements

## Installation

WPBaseTableView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WPBaseTableView'
```

## Author

823105162@qq.com, 823105162@qq.com

## License

WPBaseTableView is available under the MIT license. See the LICENSE file for more info.
