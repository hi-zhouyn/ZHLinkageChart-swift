//
//  ZHItemModel.swift
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2019/12/26.
//  Copyright © 2019 Zhou. All rights reserved.
//

import UIKit
import HandyJSON

@objcMembers class ZHItemModel: NSObject,HandyJSON {
    var layersCount: Int?//总楼层
    var topLayers: Int?//最高楼层
    var houseName: String?//房屋名称（部位）：3-308
    var layoutName: String?//用途名称
    var houseId: String?//房屋编号
    var physicLayers: String?//物理层
    var lowerNominalLayer: Int = 0//底部逻辑层
    var highNominalLayer: Int = 0//高位逻辑层
    var onNominalLayer: String?//所在逻辑层
    var unitNum: String?//单元
    var unitName: String?//单元名称
    var uIndex: String?//单元内序号
    
    required override init() {
        
    }
}
