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
                                   indexPath: IndexPath,
                                   index: Int) -> Void
}

class ZHLinkageChartView: UIView {
    
    weak var zh_delegate : ZHLinkageChartViewDelegate?
    var dataArr = Array<Any>() {
        didSet {
            let allWidth = KSCREEN_WIDTH - KITEMWIDTH - KSPACE - KLINESPACE * 2
            let itemWith = KITEMWIDTH + KSPACE
            refreshCount = Int(ceilf(Float(allWidth / itemWith)));
            
        }
    }
    var allKeysArr = [Any]()
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
        
        let frame = CGRect(x: KLINESPACE, y: self.topLabel.frame.maxY + KSPACE, width: self.topLabel.frame.width, height: self.frame.height - KSPACE - KSPACE - KITEMHEIGHT - KSPACE)
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
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
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
        let frame = CGRect.init(x: leftCollectionView.frame.maxX + KSPACE, y: headCollectionView.frame.maxY + KSPACE, width: headCollectionView.frame.width, height: leftCollectionView.frame.height)
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
    
    override func layoutSubviews() {
        leftCollectionView.reloadData()
        headCollectionView.reloadData()
        bgCollectionView.reloadData()
    }
    
    @objc func speedSelectIndexPath(indexpath: IndexPath) -> Void {
        //此处用section进行下标判断选择
        headCollectionView.selectItem(at: IndexPath.init(row: 0, section: indexpath.section), animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
    }
    
}

extension ZHLinkageChartView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,ZHBgCollectionViewCellDelegate {
    
    /** 滑动回调,处理多向滑动 */
    func itemCollectionViewDidScroll(scrollView: UIScrollView) {
        self.scrollViewDidScroll(scrollView)
    }
    
    /** item点击回调 */
    func itemDidSelectIndexPath(indexPath: IndexPath, index: Int) {
        self.linkageChartViewDidSelectType(type: ZHLinkageChartViewSelectType.ZHLinkageChartViewSelectTypeItem,
                                           indexPath: indexPath,
                                           index: index)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == headCollectionView {
            bgCollectionView.contentOffset.x = headCollectionView.contentOffset.x
        } else if scrollView == bgCollectionView {
            headCollectionView.contentOffset.x = bgCollectionView.contentOffset.x
        }
        
        if scrollView == headCollectionView || scrollView == bgCollectionView || scrollView == leftCollectionView {
            self.updateCollectionViewOffictYWithView(scrollView: leftCollectionView)
        } else {
            leftCollectionView.contentOffset.y = scrollView.contentOffset.y
            self.updateCollectionViewOffictYWithView(scrollView: leftCollectionView)
        }
    }
    
    /** 循环取出赋值偏移量 */
    func updateCollectionViewOffictYWithView(scrollView: UIScrollView) -> Void {
        var indexPath = bgCollectionView.indexPathForItem(at: bgCollectionView.contentOffset)
        if indexPath == nil {
            indexPath = IndexPath(item: 0, section: 0)
        }
        var min = indexPath!.section - refreshCount
        var max = indexPath!.section + refreshCount
        max = max > dataArr.count ? dataArr.count : max
        min = min > 0 ? min : 0
        for i in min..<max {
            for j in 0..<(dataArr[i] as AnyObject).count {
                let cell = bgCollectionView.cellForItem(at: IndexPath.init(row: j, section: i)) as? ZHBgCollectionViewCell
                if cell == nil {
                    continue
                }
                if cell?.collectionView.contentOffset.y == scrollView.contentOffset.y {
                    continue
                }
                cell?.collectionView.contentOffset = CGPoint.init(x: 0, y: scrollView.contentOffset.y)
            }
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == leftCollectionView {
            return itemModel?.layersCount ?? 0
        }
        return self.allKeysArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bgCollectionView {
            return (dataArr[section] as AnyObject).count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZHTitleCollectionViewCell.self), for: indexPath) as! ZHTitleCollectionViewCell
            cell.showBorder = true
            cell.titleLabel.text =  "\(self.allKeysArr[indexPath.section])单元"
            return cell
        } else if collectionView == bgCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZHBgCollectionViewCell.self), for: indexPath) as! ZHBgCollectionViewCell
            cell.tag = indexPath.row
            cell.indexPath = indexPath
            cell.itemArr = (dataArr[indexPath.section] as! Array)[indexPath.row]
            cell.zh_itemDelegate = self
            
            cell.selectBlock = {(indexPath,index) -> Void in
                print(indexPath)
            }
            cell.selectBlock = { [weak self, weak cell] (indexPath,index) -> Void in
                print(self?.itemModel as Any)
                print(cell?.indexPath as Any)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZHItemCollectionViewCell.self), for: indexPath) as! ZHItemCollectionViewCell
            var layer = (itemModel?.topLayers ?? 0) - indexPath.section
            //考虑地下层的情况
            if layer <= 0 && (itemModel?.topLayers ?? 0) > 0 {
                layer -= 1
            }
            let title = "\(layer)楼"
            let info = "物理层\((itemModel?.layersCount ?? 0) - indexPath.section)"
            cell.updateDataWithTitle(title: title, info: info, tag: 0)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == headCollectionView {
            self.linkageChartViewDidSelectType(type: ZHLinkageChartViewSelectType.ZHLinkageChartViewSelectTypeTop,
                                               indexPath: indexPath,
                                               index: indexPath.section)
        } else {
            self.linkageChartViewDidSelectType(type: ZHLinkageChartViewSelectType.ZHLinkageChartViewSelectTypeLeft,
                                               indexPath: indexPath,
                                               index: indexPath.section)
        }
    }
    
    func linkageChartViewDidSelectType(type: ZHLinkageChartViewSelectType,indexPath: IndexPath,index: Int) -> Void {
        if zh_delegate != nil {
            zh_delegate?.linkageChartViewDidSelect(chartView: self,
                                                        type: type,
                                                        indexPath: indexPath,
                                                        index: index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == headCollectionView {
            return CGSize(width: CGFloat(Int((KITEMWIDTH + 10)) * (dataArr[indexPath.section] as AnyObject).count - 10),
                          height: collectionView.frame.height)
        } else if collectionView == bgCollectionView {
            return CGSize(width: KITEMWIDTH, height: collectionView.frame.height)
        } else if collectionView == leftCollectionView {
            return CGSize(width: KITEMWIDTH, height: KITEMHEIGHT)
        }
        return CGSize.zero
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}

