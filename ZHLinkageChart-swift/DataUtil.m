//
//  DataUtil.m
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2020/1/6.
//  Copyright © 2020 Zhou. All rights reserved.
//

#import "DataUtil.h"
#import "LinqToObjectiveC.h"
#import "ZHLinkageChart_swift-Swift.h"

@implementation DataUtil

//给数组按相应规则进行排序
+ (NSArray *)getSortedWithJsonArr:(NSArray *)jsonArr
{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (ZHItemModel *model in jsonArr) {
        [tempArr addObject:model];
    }
    //key :按照unitNum属性 升序排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"unitNum" ascending:YES];
    //unitNum 相同 按照uIndex属性 升序排序
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"uIndex" ascending:YES];
    //uIndex 相同 按照onNominalLayer属性 降序排序
    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"onNominalLayer" ascending:NO];
    //给数组添加排序规则
    [tempArr sortUsingDescriptors:@[sort,sort1,sort2]];
    return tempArr;
}

//获取allUnitKeys
+ (NSArray *)getAllUnitKeysArrWithJsonArr:(NSArray *)jsonArr
{
    NSDictionary *dict = [jsonArr linq_groupBy:^id(id item) {
        ZHItemModel *model = (ZHItemModel *)item;
        return model.unitNum;
    }];
    //key排序
    NSMutableArray *unitKeysArr = [NSMutableArray array];
    for (NSString *key in dict.allKeys) {
        [unitKeysArr addObject:[NSNumber numberWithInteger:key.integerValue]];
    }
    NSArray *allUnitKeys = [unitKeysArr linq_sort];
    return allUnitKeys;
}

//获取最后构造完成的数据
+ (NSArray *)getAllDataArrWithJsonArr:(NSArray *)jsonArr allUnitKeys:(NSArray *)allUnitKeys layersCount:(NSInteger)layersCount topLayers:(NSInteger)topLayers
{
    NSDictionary *dict = [jsonArr linq_groupBy:^id(id item) {
        ZHItemModel *model = (ZHItemModel *)item;
        return model.unitNum;
    }];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSNumber *unitKey in allUnitKeys) {
        NSMutableArray *tempArr = [NSMutableArray array];
        NSDictionary *unitDict = [[dict objectForKey:unitKey.stringValue] linq_groupBy:^id(id item) {
            ZHItemModel *tempModel = (ZHItemModel *)item;
            return tempModel.uIndex;
        }];
        //key排序
        NSMutableArray *indexKeysArr = [NSMutableArray array];
        for (NSString *key in unitDict.allKeys) {
            [indexKeysArr addObject:[NSNumber numberWithInteger:key.integerValue]];
        }
        NSArray *allIndexKeys = [indexKeysArr linq_sort];
        for (NSNumber *indexKey in allIndexKeys) {
            NSMutableArray *allLayerArr = [NSMutableArray array];
            NSMutableArray *layerArr = [unitDict objectForKey:indexKey.stringValue];
            for (int i = 0; i < layersCount; i ++) {
                ZHItemModel *placeholderModel = [[ZHItemModel alloc] init];
                NSInteger layer = topLayers - i;
                if (layer <= 0 && topLayers > 0) {
                    layer = layer - 1;
                }
                placeholderModel.physicLayers = [NSString stringWithFormat:@"%ld",layer];
                for (ZHItemModel *layerModel in layerArr) {
                    //符合判断条件赋值，不再展示空值
                    if (layerModel.lowerNominalLayer <= layer
                        && layer <= layerModel.highNominalLayer) {
                        placeholderModel = layerModel;
                        break;
                    }
                }
                [allLayerArr addObject:placeholderModel];
            }
            //去重保存 避免因为楼层合并出现重复值多的问题
            NSArray *distinctLayers = [allLayerArr linq_distinct];
            if (distinctLayers.count) {
                [tempArr addObject:distinctLayers];
            }
        }
        [dataArr addObject:tempArr];
    }
    return dataArr;
}


@end
