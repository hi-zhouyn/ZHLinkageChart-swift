//
//  ZHItemModel.swift
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2019/12/26.
//  Copyright © 2019 Zhou. All rights reserved.
//

import UIKit
import HandyJSON

class ZHItemModel: NSObject,HandyJSON {
    var layersCount: NSInteger?//总楼层
    var topLayers: NSInteger?//最高楼层
    var houseName: NSString?//房屋名称（部位）：3-308
    var houseId: NSString?//房屋编号
    var physicLayers: NSString?//物理层
    var lowerNominalLayer: NSString?//底部逻辑层
    var highNominalLayer: NSString?//高位逻辑层
    var onNominalLayer: NSString?//所在逻辑层
    var unitNum: NSString?//单元
    var unitName: NSString?//单元名称
    var uIndex: NSString?//单元内序号
    
    required override init() {
        
    }
}
