//
//  WPMarkDownParseLinkModel.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseLink.h"
#import "YYText.h"
#import "WPMarkDownParseBaseModel.h"
#import "NSMutableAttributedString+WPAddAttributed.h"

#import <WebKit/WebKit.h>

@interface WPWKWebViewController : UIViewController<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) WKWebView * wkView;
@property (nonatomic,copy) NSString * url;
+ (void)pushWKWebViewController:(NSString *)url title:(NSString *)title;
@end

@implementation WPMarkDownParseLink

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    
    for (int i = 0; i<separatedArray.count-1; i++) {
        NSString * leftString = separatedArray[i];
        if ([self wp_isBackslash:leftString]) {
            continue;
        }
        WPMarkDownParseLinkModel * urlModel = [[WPMarkDownParseLinkModel alloc] initWithSymbol:self.symbol];
        
        NSRange leftRange = [leftString rangeOfString:@"["];
        if (leftRange.location != NSNotFound) {
            urlModel.text = [leftString substringFromIndex:NSMaxRange(leftRange)];
        }else{
            continue;
        }
        
        NSString * rightText = separatedArray[i+1];
        NSRange rightRange = [rightText rangeOfString:@")"];
        if (rightRange.location != NSNotFound) {
            urlModel.url = [rightText substringToIndex:rightRange.location];
        }else{
            continue;
        }
        
        if (urlModel.text.length && urlModel.url.length) {
            [self.segmentArray addObject:urlModel];//当文字与url都不为空时，才算解析成功
        }        
    }

}

//设置富文本url的字体颜色和url
- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseLinkModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
            make.textColor([UIColor blueColor],range);
            make.underlineStyle(NSUnderlineStyleSingle,[UIColor blueColor],range);
        }];
        [attributedString yy_setTextHighlightRange:range color:[UIColor blueColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            [WPWKWebViewController pushWKWebViewController:obj.url title:obj.text];
        }];
    }];
}

@end

@implementation WPWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.wkView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark WKNavigationDelegate

// 开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // 可以在这里做正在加载的提示动画 然后在加载完成代理方法里移除动画
}

// 网络错误
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    // 在这里可以做错误提示
}


// 网页加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //设置JS
    NSString *inputValueJS = @"document.getElementsByTagName('h1')[0].innerText";
    //执行JS
    [webView evaluateJavaScript:inputValueJS completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"value: %@ error: %@", response, error);
    }];
}

#pragma mark WKUIDelegate

//点击确认按钮的相应事件需要执行completionHandler，这样js才能继续执行

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

// confirm
//作为js中confirm接口的实现，需要有提示信息以及两个相应事件， 确认及取消，并且在completionHandler中回传相应结果，确认返回YES， 取消返回NO
//参数 message为  js 方法 confirm(<message>) 中的<message>
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert]; [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - getter

- (WKWebView *)wkView{
    if (!_wkView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:self.getWkUserScript];
                
        _wkView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        _wkView.UIDelegate = self;
        _wkView.navigationDelegate = self;
    
        [self.view addSubview:_wkView];
    }
    return _wkView;
}

- (WKUserScript *)getWkUserScript{
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    return wkUserScript;
}

#pragma mark - 入口

+ (void)pushWKWebViewController:(NSString *)url title:(NSString *)title{
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        
        WPWKWebViewController * webView = [[WPWKWebViewController alloc] init];
        webView.url = url;
        webView.title = title;
        UIViewController * topViewController = [self getCurrentVC];
        if (topViewController && ![topViewController isKindOfClass:[WPWKWebViewController class]]) {
            [[topViewController navigationController] pushViewController:webView animated:YES];
        }
    }
}

#pragma mark - 获取最顶层viewController
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [self getViewControllerWindow].rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

//获取RootViewController所在的window
+ (UIWindow*)getViewControllerWindow{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *target in windows) {
            if (target.windowLevel == UIWindowLevelNormal) {
                window = target;
                break;
            }
        }
    }
    return window;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        while ([rootVC presentedViewController]) {
            rootVC = [rootVC presentedViewController];
        }
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
        
    }
    
    return currentVC;
}

@end
