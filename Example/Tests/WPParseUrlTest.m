//
//  WPParseUrlTest.m
//  WPMarkDownParse_Tests
//
//  Created by wupeng on 2020/2/26.
//  Copyright © 2020 823105162@qq.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WPMarkDownParseLink.h"

@interface WPParseUrlTest : XCTestCase
{
    WPMarkDownParseLink * parseLink;
}
@end

@implementation WPParseUrlTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    parseLink = [[WPMarkDownParseLink alloc] initWithSymbol:@"]("];
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

@end
