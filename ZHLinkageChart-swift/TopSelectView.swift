//
//  TopSelectView.swift
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2019/12/26.
//  Copyright © 2019 Zhou. All rights reserved.
//

import UIKit

let KTopSelectViewHeight = 50.0


protocol TopSelectViewDelegate : NSObjectProtocol {
    func selectAction(indexPath: IndexPath) -> Void
}

class TopSelectView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

    weak var zh_delegate : TopSelectViewDelegate?
    var allKeysArr = Array<Any>() {
        didSet {
            headCollectionView.reloadData()
        }
    }
    
    lazy var headCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        flowLayout.itemSize = CGSize(width: 50, height: 50)
        
        let headCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 50), collectionViewLayout: flowLayout)
        headCollectionView.backgroundColor = UIColor.white
        headCollectionView.delegate = self
        headCollectionView.dataSource = self
        headCollectionView.showsHorizontalScrollIndicator = false
        headCollectionView.register(ZHTitleCollectionViewCell.self, forCellWithReuseIdentifier:NSStringFromClass(ZHTitleCollectionViewCell.self))
        self.addSubview(headCollectionView)
        return headCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        headCollectionView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allKeysArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZHTitleCollectionViewCell.self), for: indexPath) as! ZHTitleCollectionViewCell
        cell.titleLabel.text = "\(allKeysArr[indexPath.section])单元"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if zh_delegate != nil {
            zh_delegate?.selectAction(indexPath: indexPath)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
