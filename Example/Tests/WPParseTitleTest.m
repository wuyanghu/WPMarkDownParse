//
//  WPParseTitleTest.m
//  WPMarkDownParse_Tests
//
//  Created by wupeng on 2020/2/26.
//  Copyright © 2020 823105162@qq.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WPMarkDownParseTitle.h"

@interface WPParseTitleTest : XCTestCase
{
    WPMarkDownParseTitle * parseTitle;
}
@end

@implementation WPParseTitleTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    parseTitle = [[WPMarkDownParseTitle alloc] initWithSymbol:@"#"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    parseTitle = nil;
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


@end
