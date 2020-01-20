//
//  ParseVCJsonAPI.m
//  WPBase
//
//  Created by wupeng on 2019/11/17.
//

#import "WPParseSectionsModel.h"
#import "WPBaseSectionModel.h"
#import "NSObject+Json.h"

@implementation WPParseSectionsModel

#pragma mark - 解析数据

+ (WPBaseSectionsModel *)parseServerJsonToBaseSetcionModel:(NSDictionary *)jsonDict{
    NSDictionary * configDict = [self dictionaryWithJsonString:jsonDict[@"json"]];
    WPBaseSectionsModel * sectionModel = [self parseLocalJsonToBaseSetcionModel:configDict];
    return sectionModel;
}

+ (WPBaseSectionsModel *)parseLocalJsonToBaseSetcionModel:(NSDictionary *)configDict{
    WPBaseSectionsModel * sectionsModel = [WPBaseSectionsModel new];
    
    NSArray * titleArray = configDict[@"title"];
    NSArray * contentArray = configDict[@"content"];
    for (int i = 0;i<contentArray.count;i++) {
        NSArray * sectionArr = contentArray[i];
        
        WPBaseSectionModel * sectionModel = [WPBaseSectionModel new];
        sectionModel.sectionTitle = titleArray[i];
        
        for (id content in sectionArr) {
            WPBaseRowModel * rowModel = [WPBaseRowModel new];
            if ([content isKindOfClass:[NSString class]]) {
                rowModel.title = (NSString *)content;
            }else if ([content isKindOfClass:[NSDictionary class]]){
                NSDictionary * rowDict = (NSDictionary *)content;
                rowModel.title = rowDict[@"title"];
                rowModel.desc = rowDict[@"desc"];
                rowModel.classname = rowDict[@"classname"];
                rowModel.storyboardname = rowDict[@"storyboardname"];
                rowModel.method = rowDict[@"method"];
                
                NSDictionary * params = rowDict[@"params"];
                if (params) {
                    [rowModel.params setValuesForKeysWithDictionary:params];
                }
                
                NSDictionary * imageDict = rowDict[@"image"];
                rowModel.imageModel.url = imageDict[@"img"];
                rowModel.imageModel.width = imageDict[@"width"];
                rowModel.imageModel.height = imageDict[@"height"];
            }
            
            [sectionModel.rowArray addObject:rowModel];
        }
        
        [sectionsModel.contentArray addObject:sectionModel];
    }
    return sectionsModel;
}

@end


