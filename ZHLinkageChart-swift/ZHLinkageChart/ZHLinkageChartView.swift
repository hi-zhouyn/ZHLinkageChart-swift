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
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate{
    
    weak var zh_delegate : ZHLinkageChartViewDelegate?
    var dataArr : NSArray?
    var allKeysArr : NSArray?
    var itemModel : ZHItemModel?
    
    var refreshCount = 0
    
    lazy var topLabel: UILabel = {
        let frame = CGRect(x: KLINESPACE, y: KSPACE, width: KITEMWIDTH, height: KITEMHEIGHT)
        let topLabel = UILabel.init(frame: frame)
        topLabel.text = "楼层"
        topLabel.textColor = UIColor.darkText
        topLabel.textAlignment = NSTextAlignment.center
        topLabel.font = UIFont.systemFont(ofSize: 12)
        topLabel.layer.masksToBounds = true
        topLabel.layer.cornerRadius = 2
        topLabel.layer.borderColor = UIColor.lightGray.cgColor
        topLabel.layer.borderWidth = 0.5
        self.addSubview(topLabel)
        return topLabel
    }()
    
    lazy var leftCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = KSPACE
        flowLayout.minimumInteritemSpacing = KSPACE
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: KSPACE, right: 0)
        flowLayout.scrollDirection = .vertical
        
        let frame = CGRect(x: KLINESPACE, y: self.topLabel.frame.maxY + KLINESPACE, width: self.topLabel.frame.width, height: self.frame.maxY - KLINESPACE - self.topLabel.frame.maxY - KLINESPACE)
        let leftCollectionView = UICollectionView.init(frame: frame, collectionViewLayout: flowLayout)
        leftCollectionView.delegate = self
        leftCollectionView.dataSource = self
        leftCollectionView.backgroundColor = UIColor.white
        leftCollectionView.showsVerticalScrollIndicator = false
        leftCollectionView.register(ZHItemCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZHItemCollectionViewCell.self))
        self.addSubview(leftCollectionView)
        return leftCollectionView
    }()
    
    lazy var headCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = KSPACE
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: KLINESPACE)
        let frame = CGRect.init(x: self.topLabel.frame.maxX + KSPACE, y: KSPACE, width: KSCREEN_WIDTH - self.topLabel.frame.maxX - KSPACE, height: KITEMHEIGHT)
        let headCollectionView = UICollectionView.init(frame: frame, collectionViewLayout: flowLayout)
        headCollectionView.delegate = self
        headCollectionView.dataSource = self
        headCollectionView.showsHorizontalScrollIndicator = false
        headCollectionView.backgroundColor = UIColor.white
        headCollectionView.register(ZHTitleCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZHTitleCollectionViewCell.self))
        self.addSubview(headCollectionView)
        return headCollectionView
    }()
    
    lazy var bgCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumInteritemSpacing = KSPACE
        flowLayout.minimumLineSpacing = KSPACE
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: KLINESPACE)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let frame = CGRect.init(x: self.leftCollectionView.frame.maxX + KSPACE, y: self.headCollectionView.frame.maxY + KSPACE, width: self.headCollectionView.frame.width, height: self.leftCollectionView.frame.height)
        let bgCollectionView = UICollectionView.init(frame: frame, collectionViewLayout: flowLayout)
        bgCollectionView.delegate = self
        bgCollectionView.dataSource = self
        bgCollectionView.backgroundColor = UIColor.white
        bgCollectionView.showsHorizontalScrollIndicator = false
        bgCollectionView.register(ZHBgCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZHBgCollectionViewCell.self))
        self.addSubview(bgCollectionView)
        return bgCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.allKeysArr!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.bgCollectionView {
            return (self.dataArr![section] as AnyObject).count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return nil
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
