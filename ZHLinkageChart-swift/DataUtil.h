//
//  DataUtil.h
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2020/1/6.
//  Copyright © 2020 Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataUtil : NSObject

//给数组按相应规则进行排序
+ (NSArray *)getSortedWithJsonArr:(NSArray *)jsonArr;

//获取allUnitKeys
+ (NSArray *)getAllUnitKeysArrWithJsonArr:(NSArray *)jsonArr;

//获取最后构造完成的数据
+ (NSArray *)getAllDataArrWithJsonArr:(NSArray *)jsonArr allUnitKeys:(NSArray *)allUnitKeys layersCount:(NSInteger)layersCount topLayers:(NSInteger)topLayers;

@end

NS_ASSUME_NONNULL_END
