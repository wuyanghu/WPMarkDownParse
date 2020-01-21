# WPMarkDownParse

[![CI Status](https://img.shields.io/travis/823105162@qq.com/WPMarkDownParse.svg?style=flat)](https://travis-ci.org/823105162@qq.com/WPMarkDownParse)
[![Version](https://img.shields.io/cocoapods/v/WPMarkDownParse.svg?style=flat)](https://cocoapods.org/pods/WPMarkDownParse)
[![License](https://img.shields.io/cocoapods/l/WPMarkDownParse.svg?style=flat)](https://cocoapods.org/pods/WPMarkDownParse)
[![Platform](https://img.shields.io/cocoapods/p/WPMarkDownParse.svg?style=flat)](https://cocoapods.org/pods/WPMarkDownParse)

## Example

# 1.效果展示
[MarkDown简书](https://www.jianshu.com/p/649e72b1bf1f)

![MarkDown解析.gif](https://upload-images.jianshu.io/upload_images/1387554-068ec99f3268c330.gif?imageMogr2/auto-orient/strip)

# 2.调用
# 2.1 NSString+WPMarkDownParse入口
WPMarkDownParse主要是提供了一个NSString的分类，方便调用；真正的入口在WPMarkDownParseFactory
# 2.2 WPMarkDownParseFactory
# 2.2.1 同步异步入口
```
+ (NSMutableAttributedString *)parseMarkDownWithText:(NSString *)text；
+ (NSMutableAttributedString *)parseMarkDownWithText:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width；
- (void)parseMarkDownWithText:(NSString *)text finishBlock:(void (^)(NSMutableAttributedString * string))block;
- (void)parseMarkDownWithText:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width finishBlock:(void (^)(NSMutableAttributedString * string))block;
```
# 2.2.2 parseMarkDownWithText
```
+ (NSMutableAttributedString *)parseMarkDownWithText:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width{
    NSArray * parseArray = [self setUpParseArray];
    for (WPMarkDownBaseParse * parseModel in parseArray) {
        [parseModel configFontSize:fontSize width:width];
        [parseModel segmentString:&text];
    }
    
    [self replaceBackslash:&text];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [self setAttributedDefaultFont:attributedString fontSize:fontSize];
    
    for (WPMarkDownBaseParse * parseModel in parseArray) {
        [parseModel setAttributedString:attributedString];
    }
    return attributedString;
}
```
# 2.2.3 setUpParseArray初始化
>WPMarkDownParseImage:解析图片
WPMarkDownParseLink:解析链接
WPMarkDownParseQuoteParagraph:解析段落引用
WPMarkDownParseCodeBlock:解析代码块
WPMarkDownParseBold:加粗
WPMarkDownParseItalic:斜体
WPMarkDownParseTitle:标题
WPMarkDownParseDisorder:无序
WPMarkDownParseOrder:有序

所有的解析类继承自WPMarkDownBaseParse，使用策略模式、模板模式与工厂模式结合进行解析。

# 2.2.4 策略模式方法
```
//解析策略模式
@protocol WPMarkDownParseStrageInterface <NSObject>
- (NSString *)replace:(NSString *)text;
- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text;//分割字符串
- (void)setAttributedString:(NSMutableAttributedString *)attributedString;
@end
```
1. 每个类按symbol进行分割，如果separatedArray不为空，则进行解析，判断是否满足条件，加入self.segmentArray中。
2. 替换掉markdown的标识符，如链接\[百度](https:baidu.com)，只能显示百度，字体高亮，点击能跳转到WebView.

# 2.2.5 replaceBackslash
替换掉转义字符\，即出现反斜杠，都不解析。

# 2.2.6 setAttributedString
attributedString 是所有都替换完，才生产的attributedString。
策略模式使得每个类setAttributedString能够设置对应的属性，如图片，高亮、斜体等。

# 3. 链接、图片解析过程
# 3.1 WPMarkDownParseLink
1. 在setUpParseArray初始化，WPMarkDownParseLink添加到解析parseArray数组中
2. 配置fontSize与width
```
for (WPMarkDownBaseParse * parseModel in parseArray) {
        [parseModel configFontSize:fontSize width:width];
        [parseModel segmentString:&text];
    }
```
3. segmentString 按symbo分割，如果分割separatedArray不为空，则wp_markdownParseSegmentString进行解析，解析出url于对应的title的WPMarkDownParseLinkModel,添加到segmentArray
```
- (void)wp_markdownParseSegmentString:(NSArray *)separatedArray text:(NSString *)text{
    for (int i = 0; i<separatedArray.count-1; i++) {
        NSString * leftString = separatedArray[i];
        if ([self isBackslash:leftString]) {
            continue;
        }
        WPMarkDownParseLinkModel * urlModel = [[WPMarkDownParseLinkModel alloc] initWithSymbol:self.symbol];
        NSArray * leftStringSeparateArray = [leftString componentsSeparatedByString:@"["];
        if (leftStringSeparateArray.count>0) {
            urlModel.text = leftStringSeparateArray.lastObject;
        }
        NSArray * rightStringSepartedArray = [separatedArray[i+1] componentsSeparatedByString:@")"];
        if (rightStringSepartedArray.count>0) {
            urlModel.url = rightStringSepartedArray.firstObject;
        }
        if (urlModel.text.length && urlModel.url.length) {
            [self.segmentArray addObject:urlModel];//当文字与url都不为空时，才算解析成功
        }        
    }
}
```
 - 遍历separatedArray
- isBackslash上一个字符是转义字符，不添加urlModel
- 左则的字符查找符号[，右侧查找)
- 当两者都找到时，则匹配成功
4. 替换用[]的内容，替换[]()内容。即wp_markdownParseReplace
- 遍历segmentArray，逐个替换。
- willBeReplacedString、replaceString用了模板模式，因为每个解析略有不同。
5. replaceBackslash替换掉转义字符\，生成NSMutableAttributedString
6. 设置一个默认字体大小setAttributedDefaultFont
7. wp_markdownParseSetAttributedString为链接添加下划线，和点击调整事件
```
- (void)wp_markdownParseSetAttributedString:(NSMutableAttributedString *)attributedString{
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
```

# 3.2 WPMarkDownParseImage
图片解析或其他解析与链接解析大致相同，区别在于每个细节内容都不相同。
1. WPMarkDownParseImage添加到parseArray
2. 配置字体和宽度configFontSize:fontSize:width
3. segmentString木模模式，分割生成segmentArray，并匹配字符
```
- (void)wp_markdownParseSegmentString:(NSArray *)separatedArray text:(NSString *)text{
    
    for (int i = 0; i<separatedArray.count-1; i++) {
        
        NSString * leftString = separatedArray[i];
        if ([self isBackslash:leftString]) {
            continue;
        }
        WPMarkDownParseImageModel * urlModel = [[WPMarkDownParseImageModel alloc] initWithSymbol:self.symbol];
        NSArray * leftStringSeparteds = [leftString componentsSeparatedByString:@"!["];
        if (leftStringSeparteds.count>1) {
            urlModel.text = leftStringSeparteds.lastObject;
        }
        NSArray * rightSepartedArray = [separatedArray[i+1] componentsSeparatedByString:@")"];
        if (rightSepartedArray.count>0) {
            urlModel.url = rightSepartedArray.firstObject;
        }
        if (urlModel.text.length && urlModel.url.length) {
            [self.segmentArray addObject:urlModel];//当文字与url都不为空时，才算解析成功
        }
    }
}
```
- 遍历separatedArray
- isBackslash上一个字符是转义字符，不添加urlModel
- 左则的字符查找符号![，右侧查找)
- 当两者都找到时，则匹配成功

**与链接不同的是，图片的左边是![,所以防止链接被图片的解析覆盖，所以需要把图片解析放在链接解析前面。**

4. 设置UIImageView
```
- (void)wp_markdownParseSetAttributedString:(NSMutableAttributedString *)attributedString{
    NSString * text = attributedString.string;
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseLinkModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        
        {   /*
             设置图片,现在是固定宽高，可让url后带上宽高
             */
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.defaultWidth, self.defaultWidth*0.68)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:obj.url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
            
            imageView.backgroundColor = [UIColor whiteColor];
            NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.frame.size alignToFont:[UIFont systemFontOfSize:self.defaultFontSize] alignment:YYTextVerticalAlignmentCenter];
            [attachText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
            [attributedString insertAttributedString:attachText atIndex:range.location];
        }
        
        {//处理描述文字
            range = [text rangeOfString:obj.text];
            [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
                make.textFont(self.defaultFontSize-2,range);
                make.textColor([UIColor grayColor],range);
                
                CGFloat width = [self calculateWidth:obj.text fontSize:self.defaultFontSize];
                WPMutableParagraphStyleModel * styleModel = [self paragraphStyleModel:width];
                make.paragraphStyle([styleModel createParagraphStyle],range);
            }];
        }
    }];
}

- (WPMutableParagraphStyleModel *)paragraphStyleModel:(CGFloat)width{
    
    WPMutableParagraphStyleModel * styleModel = [WPMutableParagraphStyleModel new];
    styleModel.headIndent =  (self.defaultWidth-width)/2;//整体缩进(首行除外)
    styleModel.firstLineHeadIndent = (self.defaultWidth-width)/2;
    styleModel.alignment = NSTextAlignmentJustified;
    return styleModel;
}

- (CGFloat)calculateWidth:(NSString *)text fontSize:(CGFloat)fontSize{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(0, 16) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.width;
}
 ```
- 这里借助了YYText，直接在对应的位置插入了UIImageView,使用SDWebImage进行下载。
- 这里的图片宽度是根据外面传入的，高度比例固定，实际情况可根据服务端在url地址上直接返回比例，解决图片压缩问题。
- 文字设置成了灰色，字号缩小2号，位置居中

# 3.3 其他解析
其他解析与图片和链接解析类似，细节略有不同。采用统一模板和策略。

# 3.4 组装
```
+ (NSMutableAttributedString *)parseMarkDownWithText:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width{
    NSArray * parseArray = [self setUpParseArray];
    for (WPMarkDownBaseParse * parseModel in parseArray) {
        [parseModel configFontSize:fontSize width:width];
        [parseModel segmentString:&text];
    }
    
    [self replaceBackslash:&text];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [self setAttributedDefaultFont:attributedString fontSize:fontSize];
    
    for (WPMarkDownBaseParse * parseModel in parseArray) {
        [parseModel wp_markdownParseSetAttributedString:attributedString];
    }
    return attributedString;
}
```
- 所有的字符解析完成，替换反斜杠，最后生成attributedString
- setAttributedDefaultFont设置默认字号
- wp_markdownParseSetAttributedString统一设置对应的属性

# 4.链接与标题单元测试
```
@interface WPMarkDownParseStringTest : XCTestCase
{
    WPMarkDownParseLink * parseLink;
    WPMarkDownParseTitle * parseTitle;
}
@end

@implementation WPMarkDownParseStringTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    parseLink = [[WPMarkDownParseLink alloc] initWithSymbol:@"]("];
    parseTitle = [[WPMarkDownParseTitle alloc] initWithSymbol:@"#"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    parseLink = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - 解析URL

- (void)testSpiltOneUrl{
    NSString * text = @"计划:[事件传递和事件响应](https://blog.csdn.net/suma110/article/details/99290799)";
    
    [parseLink segmentString:&text];
    
    WPMarkDownParseLinkModel * urlModel = parseLink.segmentArray.firstObject;
    XCTAssertTrue([urlModel.text isEqualToString:@"事件传递和事件响应"],@"text分割正确");
    XCTAssertTrue([urlModel.url isEqualToString:@"https://blog.csdn.net/suma110/article/details/99290799"],@"url分割正确");
}

- (void)testSpiltTwoUrl{
    NSString * text = @"计划:[事件传递和事件响应](https://blog.csdn.net/suma110/article/details/99290799)中间级还有很多[事件传递和事件响应2](https://blog.csdn.net/suma110/article/details/99290798)";
    
    [parseLink segmentString:&text];
        
    WPMarkDownParseLinkModel * urlModel = parseLink.segmentArray.firstObject;
    XCTAssertTrue([urlModel.text isEqualToString:@"事件传递和事件响应"],@"text分割正确");
    XCTAssertTrue([urlModel.url isEqualToString:@"https://blog.csdn.net/suma110/article/details/99290799"],@"url分割正确");
    
    WPMarkDownParseLinkModel * twoUrlModel = parseLink.segmentArray[1];
    XCTAssertTrue([twoUrlModel.text isEqualToString:@"事件传递和事件响应2"],@"text分割正确");
    XCTAssertTrue([twoUrlModel.url isEqualToString:@"https://blog.csdn.net/suma110/article/details/99290798"],@"url分割正确");
}

- (void)testSpiltOneUrl2{
    NSString * text = @"[事件传递和事件响应](https://blog.csdn.net/suma110/article/details/99290799)";
    
    [parseLink segmentString:&text];
    
    WPMarkDownParseLinkModel * urlModel = parseLink.segmentArray.firstObject;
    XCTAssertTrue([urlModel.text isEqualToString:@"事件传递和事件响应"],@"text分割正确");
    XCTAssertTrue([urlModel.url isEqualToString:@"https://blog.csdn.net/suma110/article/details/99290799"],@"url分割正确");
}

- (void)testSpiltTwoUrl2{
    NSString * text = @"1.Textview展示超链接，除了链接外，其他区域父视图响应\n替补方案：没有超链接的，关闭响应。\n2.scrollView添加tableView，scrollView支持横向，tableView竖向滚动，在数据少时，不能下拉刷新。\n[嵌套UIScrollview的滑动冲突解决方案](https://www.jianshu.com/p/040772693872)\n[iOS 嵌套UIScrollview的滑动冲突另一种解决方案](https://www.jianshu.com/p/df01610b4e73)";
    
    [parseLink segmentString:&text];
    
    WPMarkDownParseLinkModel * urlModel = parseLink.segmentArray.firstObject;
    XCTAssertTrue([urlModel.text isEqualToString:@"嵌套UIScrollview的滑动冲突解决方案"],@"text分割正确");
    XCTAssertTrue([urlModel.url isEqualToString:@"https://www.jianshu.com/p/040772693872"],@"url分割正确");
    
    WPMarkDownParseLinkModel * twoUrlModel = parseLink.segmentArray[1];
    XCTAssertTrue([twoUrlModel.text isEqualToString:@"iOS 嵌套UIScrollview的滑动冲突另一种解决方案"],@"text分割正确");
    XCTAssertTrue([twoUrlModel.url isEqualToString:@"https://www.jianshu.com/p/df01610b4e73"],@"url分割正确");
}

#pragma mark - 解析title

- (void)testParseOneTitle{
    NSString * text = @"#1.Textview展示超链接\n2.scrollView添加tableView，scrollView支持横向，tableView竖向滚动，在数据少时，不能下拉刷新。\n[嵌套UIScrollview的滑动冲突解决方案](https://www.jianshu.com/p/040772693872)\n[iOS 嵌套UIScrollview的滑动冲突另一种解决方案](https://www.jianshu.com/p/df01610b4e73)";
    
    [parseTitle segmentString:&text];
    
    WPMarkDownParseLinkModel * titleModel =  parseTitle.segmentArray.firstObject;
    XCTAssertTrue([titleModel.text isEqualToString:@"1.Textview展示超链接"]);
}

- (void)testParseTwoTitle{
    NSString * text = @"#1.Textview展示超链接\n#2.scrollView添加tableView，scrollView支持横向，tableView竖向滚动，在数据少时，不能下拉刷新。\n[嵌套UIScrollview的滑动冲突解决方案](https://www.jianshu.com/p/040772693872)\n[iOS 嵌套UIScrollview的滑动冲突另一种解决方案](https://www.jianshu.com/p/df01610b4e73)";
    
    [parseTitle segmentString:&text];
    
    WPMarkDownParseLinkModel * titleModel =  parseTitle.segmentArray.firstObject;
    WPMarkDownParseLinkModel * titleModel2 =  parseTitle.segmentArray[1];
    XCTAssertTrue([titleModel.text isEqualToString:@"1.Textview展示超链接"]);
    XCTAssertTrue([titleModel2.text isEqualToString:@"2.scrollView添加tableView，scrollView支持横向，tableView竖向滚动，在数据少时，不能下拉刷新。"]);
}

#pragma mark - 解析截取字符

- (void)testSubStringLast3Number{
    WPMarkDownParseOrder * order = [WPMarkDownParseOrder new];
    NSString * text = @"abcd123";
    NSString * subString = [order subStringLastNum:text];
    XCTAssertTrue([subString isEqualToString:@"123"]);
}

- (void)testSubStringLast1Number{
    WPMarkDownParseOrder * order = [WPMarkDownParseOrder new];
    NSString * text = @"abcd1";
    NSString * subString = [order subStringLastNum:text];
    XCTAssertTrue([subString isEqualToString:@"1"]);
}

- (void)testSubString1Number{
    WPMarkDownParseOrder * order = [WPMarkDownParseOrder new];
    NSString * text = @"1";
    NSString * subString = [order subStringLastNum:text];
    XCTAssertTrue([subString isEqualToString:@"1"]);
}

- (void)testSubStringNoNumber{
    WPMarkDownParseOrder * order = [WPMarkDownParseOrder new];
    NSString * text = @"abc";
    NSString * subString = [order subStringLastNum:text];
    XCTAssertTrue([subString isEqualToString:@""]);
}

@end
```
# 5. 总结
1. Markdown的解析功能基本完成，但还有很多细节需处理。
2. 由于按文字匹配，会出现匹配文字。如标题与链接相同时，标题可能会被加上下划线；有序嵌套时效果不是很好，现在是碰到两个\n停止，而实际远不止这些条件。
3. 文中的富文本链式使用，已经封装成了[WPChained](https://github.com/wuyanghu/WPChained)

## Requirements

## Installation

WPMarkDownParse is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WPMarkDownParse'
```

## Author

823105162@qq.com, 823105162@qq.com

## License

WPMarkDownParse is available under the MIT license. See the LICENSE file for more info.
