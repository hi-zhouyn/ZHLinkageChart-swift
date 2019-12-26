//
//  ZHLinkageChartView.swift
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2019/12/26.
//  Copyright © 2019 Zhou. All rights reserved.
//

import UIKit

enum ZHLinkageChartViewSelectType : Int {
    case ZHLinkageChartViewSelectTypeTop = 1,  //顶部区域
    ZHLinkageChartViewSelectTypeLeft,          //左边区域
    ZHLinkageChartViewSelectTypeItem           //item
}

protocol ZHLinkageChartViewDelegate: NSObjectProtocol {
    func linkageChartViewDidSelect(chartView: ZHLinkageChartView,
                                   type: ZHLinkageChartViewSelectType,
                                   indexPath: NSIndexPath,
                                   index: NSInteger) -> Void
}

class ZHLinkageChartView: UIView,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    weak var zh_delegate : ZHLinkageChartViewDelegate?
    var dataArr : NSArray?
    var allKeysArr : NSArray?
    var itemModel : ZHItemModel?
    
    var refreshCount = 0
    
    lazy var leftCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = KSPACE
        
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let leftCollectionView = UICollectionView.init(frame: frame, collectionViewLayout: flowLayout)
        return leftCollectionView
    }()
    
    lazy var headCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        
        return <#value#>
    }()
    
    lazy var bgCollectionView: UICollectionView = {
        
        return <#value#>
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
