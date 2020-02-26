//
//  WPUtilTests.m
//  WPMarkDownParse_Tests
//
//  Created by wupeng on 2020/2/26.
//  Copyright © 2020 823105162@qq.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WPMarkDownParseOrder.h"

@interface WPUtilTests : XCTestCase

@end

@implementation WPUtilTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
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

#pragma mark - 解析截取字符

- (void)testSubStringLast3Number{
    WPMarkDownParseOrder * order = [WPMarkDownParseOrder new];
    NSString * text = @"abcd123";
    NSString * subString = [order wp_subStringLastNum:text];
    XCTAssertTrue([subString isEqualToString:@"123"]);
}

- (void)testSubStringLast1Number{
    WPMarkDownParseOrder * order = [WPMarkDownParseOrder new];
    NSString * text = @"abcd1";
    NSString * subString = [order wp_subStringLastNum:text];
    XCTAssertTrue([subString isEqualToString:@"1"]);
}

- (void)testSubString1Number{
    WPMarkDownParseOrder * order = [WPMarkDownParseOrder new];
    NSString * text = @"1";
    NSString * subString = [order wp_subStringLastNum:text];
    XCTAssertTrue([subString isEqualToString:@"1"]);
}

- (void)testSubStringNoNumber{
    WPMarkDownParseOrder * order = [WPMarkDownParseOrder new];
    NSString * text = @"abc";
    NSString * subString = [order wp_subStringLastNum:text];
    XCTAssertTrue([subString isEqualToString:@""]);
}


@end
