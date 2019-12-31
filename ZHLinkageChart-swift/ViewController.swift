//
//  ViewController.swift
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2019/12/25.
//  Copyright © 2019 Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController,TopSelectViewDelegate,ZHLinkageChartViewDelegate {
    
    lazy var topView: TopSelectView = {
        
        let topView = TopSelectView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: KSCREEN_WIDTH, height: 50.0))
        topView.zh_delegate = self
        self.view.addSubview(topView)
        return topView
    }()
    
    lazy var chartView: ZHLinkageChartView = {
        let chartView = ZHLinkageChartView.init(frame: CGRect(x: 0, y: self.topView.frame.maxY + 10, width: KSCREEN_WIDTH, height: self.view.frame.height - 60))
        chartView.zh_delegate = self
        self.view.addSubview(chartView)
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func getQueryWithLayersCount(_ layersCount: Int, _ topLayers: Int) -> Void {
        
        
        
    }

    func selectAction(indexPath: IndexPath) {
        self.chartView.speedSelectIndexPath(indexpath: indexPath)
    }
    
    func linkageChartViewDidSelect(chartView: ZHLinkageChartView, type: ZHLinkageChartViewSelectType, indexPath: IndexPath, index: Int) {
        print("type:\(type),section:\(indexPath.section),row:\(indexPath.row),index:\(index)")
    }
}

