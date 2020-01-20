//
//  NSObject+ReadConfigJson.m
//  DataStructureDemo
//
//  Created by wupeng on 2019/9/18.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import "NSObject+Json.h"
#include <CommonCrypto/CommonCrypto.h>

@implementation NSObject (Json)

#pragma mark - 读取json文件

//读取json
- (id)readJsonWithName:(NSString *)name{
    NSData *data = [self readJsonDataWithName:name];
    if (!data) {
        return nil;
    }
    id dataId = [NSJSONSerialization JSONObjectWithData:data                   options:NSJSONReadingMutableContainers error:nil];
    return dataId;
}
//读取json的md5
- (NSString *)readJsonMD5StringWithName:(NSString *)name{
    NSData * data = [self readJsonDataWithName:name];
    return [self md5String:data];
}
//读取json的NSData
- (NSData *)readJsonDataWithName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    if (!path) {
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

#pragma mark - NSData转成md5字符串

- (NSString *)md5String:(NSData *)data {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark - 字典转json

// 字典转json字符串方法
-(NSString *)convertToJsonData:(NSDictionary *)dict{
    if (!dict) {
        return nil;
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    return mutStr;
    
}

#pragma mark - json转字典

//JSON字符串转化为字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end

