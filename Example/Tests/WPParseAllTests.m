//
//  WPParseAllTests.m
//  WPMarkDownParse_Tests
//
//  Created by wupeng on 2020/2/26.
//  Copyright © 2020 823105162@qq.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WPMarkDownParseFade.h"
#import "WPMarkDownBaseParse.h"

@interface WPMarkDownParseFade(Category)
@property (nonatomic,strong) NSMutableArray<WPMarkDownBaseParse *> * parseArray;
@end

@interface WPParseAllTests : XCTestCase
{
    WPMarkDownParseFade * parseFade;
}
@end

@implementation WPParseAllTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    parseFade = [WPMarkDownParseFade new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    parseFade = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        [self testTitleOrderCombine];
    }];
}

//测试标题、有序组合
- (void)testTitleOrderCombine{
    NSString * text = @"#1.组件分层\n1. 底层可以是与业务无关的基础组件，比如网络和存储等；\n2. 中间层一般是通用的业务组件，比如账号、埋点、支付、购物车等；\n3. 最上层是迭代业务组件，更新频率最高。\n\n#2.组件化细节\n##2.1细节\n分类的类名、方法名需加前缀宏、全局变量加前缀同类型的category合并在一个文件中资源文件放bundle中##2.2组件架构\nWPBase:存放常用的宏、工具、分类等。\n如果不是共用，放当前组件";
    NSArray * parseArray = parseFade.parseArray;
    for (WPMarkDownBaseParse * parseModel in parseArray) {
        [parseModel segmentString:&text];
        if ([parseModel.symbol isEqualToString:@"#"]) {
            XCTAssertTrue([[parseModel.segmentArray[0] text] isEqualToString:@"1.组件分层"]);
            XCTAssertTrue([[parseModel.segmentArray[1] text] isEqualToString:@"2.组件化细节"]);
        }
        if ([parseModel.symbol isEqualToString:@"##"]) {
            XCTAssertTrue([[parseModel.segmentArray[0] text] isEqualToString:@"2.1细节"]);
            XCTAssertTrue([[parseModel.segmentArray[1] text] isEqualToString:@"2.2组件架构"]);
        }
        
        if ([parseModel.symbol isEqualToString:@". "]) {
            XCTAssertTrue([[parseModel.segmentArray[0] text] isEqualToString:@"底层可以是与业务无关的基础组件，比如网络和存储等；\n"]);
            XCTAssertTrue([[parseModel.segmentArray.lastObject text] isEqualToString:@"最上层是迭代业务组件，更新频率最高。"]);
        }
        
    }
    
}

- (void)testTitleImgCombine{
    NSString * text = @"#1.MVC\n![MVC.png](http://api.cocoachina.com/uploads//20190523/1558578823581797.png)\nC中持有Model,View；C添加M的KVO观察者，M是被观察者；V的action通过点击反馈给C\nM发生改变，通过KVO通知C,C更新V\nV发生交换，反馈给C，C更新M\n\n#2.MVVM\n![MVVM.png](https://upload-images.jianshu.io/upload_images/3807682-f10f2cdf99f4de05.png)\nC持有VM、V\nVM持有M\nview通过构造持有viewModel，view更新数据直接更新viewModel\nviewModel存放数据列表、从网络获取数据\n\n\n思考：笔记功能拆成MVVM";
    NSArray * parseArray = parseFade.parseArray;
    for (WPMarkDownBaseParse * parseModel in parseArray) {
        [parseModel segmentString:&text];
        if ([parseModel isKindOfClass:NSClassFromString(@"WPMarkDownParseImage")]) {
            WPMarkDownParseImageModel * imageModel0 = parseModel.segmentArray[0];
            XCTAssertTrue([imageModel0.text isEqualToString:@"MVC.png"]);
            XCTAssertTrue([imageModel0.url isEqualToString:@"http://api.cocoachina.com/uploads//20190523/1558578823581797.png"]);
            
            WPMarkDownParseImageModel * imageModel1 = parseModel.segmentArray[1];
            XCTAssertTrue([imageModel1.text isEqualToString:@"MVVM.png"]);
            XCTAssertTrue([imageModel1.url isEqualToString:@"https://upload-images.jianshu.io/upload_images/3807682-f10f2cdf99f4de05.png"]);
        }
        if ([parseModel.symbol isEqualToString:@"#"]) {
            XCTAssertTrue([[parseModel.segmentArray[0] text] isEqualToString:@"1.MVC"]);
            XCTAssertTrue([[parseModel.segmentArray[1] text] isEqualToString:@"2.MVVM"]);
        }
        
    }

}

@end
