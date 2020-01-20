//
//  NSObject+ReadConfigJson.h
//  DataStructureDemo
//
//  Created by wupeng on 2019/9/18.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Json)
//读取本地json文件
- (id)readJsonWithName:(NSString *)name;//读取json文件
- (NSString *)readJsonMD5StringWithName:(NSString *)name;//读取二进制json文件的md5字符串
- (NSData *)readJsonDataWithName:(NSString *)name;//读取json文件的二进制
//data转md5
- (NSString *)md5String:(NSData *)data;//nsdata转md5string
//json与字典转换
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;//JSON字符串转化为字典
-(NSString *)convertToJsonData:(NSDictionary *)dict;// 字典转json字符串方法
@end

NS_ASSUME_NONNULL_END
