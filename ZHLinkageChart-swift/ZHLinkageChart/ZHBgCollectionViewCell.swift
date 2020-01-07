//
//  ZHBgCollectionViewCell.swift
//  ZHLinkageChart-swift
//
//  Created by 周亚楠 on 2019/12/26.
//  Copyright © 2019 Zhou. All rights reserved.
//

import UIKit

protocol ZHBgCollectionViewCellDelegate : NSObjectProtocol {
    /** 滑动回调 */
    func itemCollectionViewDidScroll(scrollView: UIScrollView) -> Void
    /** 点击回调 */
    func itemDidSelectIndexPath(indexPath: IndexPath, index: Int) -> Void
}

/** 闭包 */
typealias ItemSelectBlock = (_ indexPath: IndexPath, _ index: Int) -> Void

class ZHBgCollectionViewCell: UICollectionViewCell {
    
    var itemArr = [Any](){
        didSet {
            collectionView.reloadData()
        }
    }
    var indexPath = IndexPath()
    var zh_itemDelegate : ZHBgCollectionViewCellDelegate?
    var selectBlock : ItemSelectBlock?
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = KSPACE
        flowLayout.minimumInteritemSpacing = KSPACE
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: KSPACE, right: 0)
        
        let collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ZHItemCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZHItemCollectionViewCell.self))
        self.addSubview(collectionView)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

extension ZHBgCollectionViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if zh_itemDelegate != nil {
            zh_itemDelegate?.itemCollectionViewDidScroll(scrollView: scrollView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZHItemCollectionViewCell.self), for: indexPath) as! ZHItemCollectionViewCell
        if itemArr.count > indexPath.row {
            let infoModel = itemArr[indexPath.row] as! ZHItemModel
            cell.updateDataWithTitle(title: infoModel.houseName ?? "", info: infoModel.layoutName ?? "", tag: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (selectBlock != nil) {
            selectBlock!(indexPath,indexPath.row)
        }
        if zh_itemDelegate != nil {
            zh_itemDelegate?.itemDidSelectIndexPath(indexPath: indexPath, index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !itemArr.isEmpty {
            let infoModel = itemArr[indexPath.row] as! ZHItemModel
            let difference : CGFloat = CGFloat(infoModel.highNominalLayer - infoModel.lowerNominalLayer + 1)
            let height : CGFloat = KITEMHEIGHT * difference + KSPACE * (difference - 1)
            return CGSize(width: KITEMWIDTH, height: height)
        }
        return CGSize(width: KITEMWIDTH, height: KITEMHEIGHT)
    }
    
}
