//
//  ViewController.swift
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2019/12/25.
//  Copyright © 2019 Zhou. All rights reserved.
//

import UIKit
import SnapKit

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
//        var dataArr = Array<Any>()
//        let strPath = Bundle.main.path(forResource: "layer", ofType: "geojson")
//        let layerJson: Any = String.init(contentsOfFile: strPath!, encoding: String.Encoding.utf8)
        
        
        
        
    }

    func selectAction(indexPath: IndexPath) {
        self.chartView.speedSelectIndexPath(indexpath: indexPath)
    }
    
    func linkageChartViewDidSelect(chartView: ZHLinkageChartView, type: ZHLinkageChartViewSelectType, indexPath: IndexPath, index: Int) {
        print("type:\(type),section:\(indexPath.section),row:\(indexPath.row),index:\(index)")
    }
}

