//
//  ViewController.swift
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2019/12/25.
//  Copyright © 2019 Zhou. All rights reserved.
//

import UIKit
import SnapKit
import HandyJSON

class ViewController: UIViewController,TopSelectViewDelegate,ZHLinkageChartViewDelegate {
    
    var topView = TopSelectView()
    var chartView = ZHLinkageChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
        self.getQueryWithLayersCount(40, 35)
    }
    
    //加载视图
    func updateUI() {
        self.navigationItem.title = "ZHLinkageChart-swift"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        topView.zh_delegate = self
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(KTopSelectViewHeight)
        }
        
        chartView.zh_delegate = self
        self.view.addSubview(chartView)
        chartView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(topView.snp_bottom).offset(10)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    
    /** 处理数据并进行传值 */
    func getQueryWithLayersCount(_ layersCount: Int, _ topLayers: Int) -> Void {
        let strPath = Bundle.main.path(forResource: "layer", ofType: "geojson")
        if let path = strPath {
            
            do {
                let layerJson = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                let layerModel = ZHItemModel()
                layerModel.layersCount = layersCount
                layerModel.topLayers = topLayers
                
                //处理数据
                let jsonArr = [ZHItemModel].deserialize(from: layerJson) ?? Array<ZHItemModel>()
                let sortedJsonArr = DataUtil.getSortedWithJsonArr(jsonArr as [Any])
                let allUnitKeys = DataUtil.getAllUnitKeysArr(withJsonArr: sortedJsonArr as [Any])
                let dataArr = DataUtil.getAllDataArr(withJsonArr: sortedJsonArr as [Any], allUnitKeys: allUnitKeys, layersCount: layersCount, topLayers: topLayers)
                
                //传值
                topView.allKeysArr = allUnitKeys
                chartView.itemModel = layerModel
                chartView.allKeysArr = allUnitKeys
                chartView.dataArr = dataArr
                
            } catch {
                
            }
        }
    }

    func selectAction(indexPath: IndexPath) {
        self.chartView.speedSelectIndexPath(indexpath: indexPath)
    }
    
    func linkageChartViewDidSelect(chartView: ZHLinkageChartView, type: ZHLinkageChartViewSelectType, indexPath: IndexPath, index: Int) {
        print("type:\(type),section:\(indexPath.section),row:\(indexPath.row),index:\(index)")
    }
    
    
    
    
}

